import 'package:book_tracker/modal/book.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SearchedBookDetailDialog extends StatelessWidget {
  const SearchedBookDetailDialog({
    Key? key,
    required this.book,
    required this.bookCollectionReference,
  }) : super(key: key);

  final Book book;
  final CollectionReference<Map<String, dynamic>> bookCollectionReference;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        children: [
          Container(
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              backgroundImage: NetworkImage(book.photoUrl.toString()),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '${book.title}',
              style: Theme.of(context)
                  .textTheme
                  .headline4!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Category: ${book.categories}',
            ),
          ),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Page Count: ${book.pageCount}',
              )),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Author: ${book.author}',
              )),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Published: ${book.publishedDate}',
              )),
          Expanded(
              child: Container(
            margin: EdgeInsets.all(18),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.blueGrey.shade100, width: 1)),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Text(
                  '${book.description}',
                  style: TextStyle(wordSpacing: 0.9, letterSpacing: 1.5),
                ),
              ),
            ),
          ))
        ],
      ),
      actions: [
        TextButton(
            onPressed: () {
              bookCollectionReference.add(Book(
                      userId: FirebaseAuth.instance.currentUser!.uid,
                      title: book.title,
                      photoUrl: book.photoUrl,
                      publishedDate: book.publishedDate,
                      description: book.description,
                      categories: book.categories,
                      author: book.author,
                      pageCount: book.pageCount)
                  .toMap());
              Navigator.of(context).pop();
            },
            child: Text('Save')),
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancel')),
      ],
    );
  }
}
