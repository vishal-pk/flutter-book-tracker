import 'package:book_tracker/constants/constants.dart';
import 'package:book_tracker/modal/book.dart';
import 'package:flutter/material.dart';

class ReadingListCard extends StatelessWidget {
  final String? image;
  final String? title;
  final String? author;
  final String? rating;
  final Book? book;
  final bool? isBookread;
  final Function? pressDetails;
  final Function? pressRead;
  const ReadingListCard(
      {Key? key,
      this.image,
      this.author,
      this.book,
      this.isBookread,
      this.pressDetails,
      this.pressRead,
      this.rating,
      this.title})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 24, bottom: 0),
      width: 202,
      child: Stack(
        children: [
          Positioned(
              left: 0,
              right: 0,
              child: Container(
                child: Container(
                    height: 244,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(29),
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(0, 10),
                              blurRadius: 33,
                              color: kShadowColor)
                        ])),
              )),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.network(
              image!,
              width: 100,
            ),
          ),
          Positioned(
            child: Column(
              children: [
                IconButton(onPressed: () {}, icon: Icon(Icons.favorite_border))
              ],
            ),
            right: 10,
            top: 34,
          ),
          Positioned(
              top: 160,
              child: Container(
                height: 85,
                width: 202,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 24),
                      child: RichText(
                        text: TextSpan(
                            style: TextStyle(color: kBlackColor),
                            children: [
                              TextSpan(
                                  text: '$title\n',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              TextSpan(
                                  text: '$author',
                                  style: TextStyle(color: kLightBlackColor))
                            ]),
                        maxLines: 2,
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          width: 100,
                          alignment: Alignment.center,
                          child: Text('details'),
                        ),
                        Expanded(child: Text('Reading'))
                      ],
                    )
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
