import 'dart:convert';
import 'package:book_tracker/modal/book.dart';
import 'package:book_tracker/widgets/searched_book_detail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'input_decoration.dart';

class BookSearchPage extends StatefulWidget {
  BookSearchPage({Key? key}) : super(key: key);

  @override
  _BookSearchPageState createState() => _BookSearchPageState();
}

class _BookSearchPageState extends State<BookSearchPage> {
  TextEditingController _searchTextController = TextEditingController();

  List<Book> listOfBooks = [];
  @override
  void initState() {
    super.initState();
    _searchTextController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Search'),
        backgroundColor: Colors.redAccent,
      ),
      body: Material(
          elevation: 0.0,
          child: Center(
              child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.9,
            child: Column(
              children: [
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Form(
                        child: TextField(
                      onSubmitted: (value) {
                        _search();
                      },
                      controller: _searchTextController,
                      decoration: buildInputDecoration(
                          label: 'Search', hintText: 'Flutter development'),
                    )),
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                (listOfBooks != null)
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                              child: SizedBox(
                            width: 300,
                            height: 200,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: createBookCards(listOfBooks, context),
                            ),
                          )),
                        ],
                      )
                    : Center(
                        child: Text(''),
                      )
              ],
            ),
          ))),
    );
  }

  void _search() async {
    await fetchBooks(_searchTextController.text).then((value) {
      setState(() {
        listOfBooks = value;
      });

      return null;
    }, onError: (value) {
      throw Exception('Failed to Load Books ${value.toString()}');
    });
  }

  Future<List<Book>> fetchBooks(String query) async {
    List<Book> books = [];
    http.Response response = await http.get(
        Uri.parse('https://www.googleapis.com/books/v1/volumes?q=${query}'));
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      final Iterable list = body['items'];
      for (var item in list) {
        // print('${item['volumeInfo']['title']}');
        String title = item['volumeInfo']['title'];
        String author = item['volumeInfo']['authors'] == null
            ? "N/A"
            : item['volumeInfo']['authors'][0];
        String thumbNail = (item['volumeInfo']['imageLinks'] == null)
            ? ""
            : item['volumeInfo']['imageLinks']['thumbnail'];
        String publishedDate = item['volumeInfo']['publishedDate'] == null
            ? "N/A"
            : item['volumeInfo']['publishedDate'];
        String description = item['volumeInfo']['description'] == null
            ? "N/A"
            : item['volumeInfo']['description'];
        int pageCount = item['volumeInfo']['pageCount'] == null
            ? 0
            : item['volumeInfo']['pageCount'];
        String categories = item['volumeInfo']['categories'] == null
            ? "N/A"
            : item['volumeInfo']['categories'][0];

        Book searchedBook = new Book(
            title: title,
            author: author,
            photoUrl: thumbNail,
            description: description,
            publishedDate: publishedDate,
            pageCount: pageCount,
            categories: categories);
        books.add(searchedBook);
      }
    } else {
      throw ('Error ${response.reasonPhrase}');
    }
    return books;
  }

  List<Widget> createBookCards(List<Book> listOfBooks, BuildContext context) {
    List<Widget> children = [];
    final bookCollectionReference =
        FirebaseFirestore.instance.collection('books');
    for (var book in listOfBooks) {
      children.add(Container(
        width: 160,
        margin: EdgeInsets.symmetric(horizontal: 12.0),
        decoration:
            BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5))),
        child: Card(
          elevation: 5,
          color: HexColor('f6f4ff'),
          child: Wrap(
            children: [
              Image.network(
                (book.photoUrl == null || book.photoUrl!.isEmpty)
                    ? ''
                    : book.photoUrl.toString(),
                width: 160,
                height: 100,
              ),
              ListTile(
                title: Text(
                  '${book.title}',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: HexColor('#5d48b6')),
                ),
                subtitle: Text(
                  '${book.author}',
                  overflow: TextOverflow.ellipsis,
                ),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return SearchedBookDetailDialog(
                          book: book,
                          bookCollectionReference: bookCollectionReference);
                    },
                  );
                },
              )
            ],
          ),
        ),
      ));
    }
    return children;
  }
}
