import 'dart:convert';

import 'package:book_tracker/modal/user.dart';
import 'package:book_tracker/screens/login_page.dart';
import 'package:book_tracker/widgets/book_search_page.dart';
import 'package:book_tracker/widgets/create_profile.dart';
import 'package:book_tracker/widgets/input_decoration.dart';
import 'package:book_tracker/widgets/readling_list_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MainScreenPage extends StatelessWidget {
  const MainScreenPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CollectionReference userCollectionReference =
        FirebaseFirestore.instance.collection('users');
    CollectionReference bookCollectionReference =
        FirebaseFirestore.instance.collection('books');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white24,
        toolbarHeight: 77,
        elevation: 0.0,
        centerTitle: false,
        title: Row(
          children: [
            Text(
              'A.reader',
              style: TextStyle(color: Colors.black26),
            ),
          ],
        ),
        actions: [
          StreamBuilder<QuerySnapshot>(
            stream: userCollectionReference.snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              final userListStream = snapshot.data!.docs.map((user) {
                // print(user.id);
                return MUser.fromDocument(user, user.id);
              }).where((user) {
                return (user.uid == FirebaseAuth.instance.currentUser!.uid);
              }).toList();
              MUser currentUser = userListStream[0];
              return Column(
                children: [
                  SizedBox(
                    height: 40,
                    width: 40,
                    child: InkWell(
                      child: CircleAvatar(
                        radius: 60,
                        backgroundImage: NetworkImage((currentUser.avatarUrl !=
                                null)
                            ? currentUser.avatarUrl.toString()
                            : 'https://images.pexels.com/photos/674010/pexels-photo-674010.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'),
                        backgroundColor: Colors.white,
                      ),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return createProfileDialog(
                              currentUser,
                              context,
                            );
                          },
                        );
                      },
                    ),
                  ),
                  Text(
                    '${currentUser.displayName}',
                    style: TextStyle(color: Colors.black12),
                  )
                ],
              );
            },
          ),
          TextButton.icon(
              onPressed: () {
                FirebaseAuth.instance.signOut().then((value) {
                  return Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return LoginPage();
                    },
                  ));
                });
              },
              icon: Icon(Icons.logout),
              label: Text(''))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BookSearchPage(),
              ));
        },
        child: Icon(
          Icons.add,
        ),
        backgroundColor: Colors.redAccent,
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 12, left: 12),
            width: double.infinity,
            child: Container(
              child: RichText(
                  text: TextSpan(
                      style: Theme.of(context).textTheme.headline5,
                      children: [
                    TextSpan(text: 'Your Reading\n Activity'),
                    TextSpan(
                        text: 'right now',
                        style: TextStyle(fontWeight: FontWeight.bold))
                  ])),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          StreamBuilder<QuerySnapshot>(
            stream: bookCollectionReference.snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }
              return Expanded(
                  flex: 1,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 15,
                    itemBuilder: (context, index) {
                      // return Container(
                      //   width: 159,
                      //   height: 200,
                      //   child: Card(
                      //     elevation: 3,
                      //     child: ListTile(
                      //       title: Text('hello'),
                      //     ),
                      //   ),
                      // );
                      return ReadingListCard(
                        title: 'Build flutter web apps',
                        author: 'vishal',
                        image:
                            'data:image/jpeg;base64,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',
                      );
                    },
                  ));
            },
          ),
          Expanded(flex: 1, child: Column())
        ],
      ),
    );
  }
}
