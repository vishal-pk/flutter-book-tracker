import 'package:book_tracker/modal/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'input_decoration.dart';

AlertDialog updateUserProfile(
    MUser user,
    TextEditingController _displayNameTextController,
    TextEditingController _professionTextController,
    TextEditingController _quoteTextController,
    TextEditingController _avatarTextController,
    BuildContext context) {
  return AlertDialog(
    title: Center(
      child: Text('Edit ${user.displayName}'),
    ),
    content: Form(
        child: SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              backgroundImage: NetworkImage((user.avatarUrl != null)
                  ? user.avatarUrl.toString()
                  : 'https://images.pexels.com/photos/674010/pexels-photo-674010.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'),
              radius: 50,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
                // initialValue:
                //     '${currentUser.displayName}',
                controller: _displayNameTextController,
                decoration:
                    buildInputDecoration(label: 'Your Name', hintText: '')),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
                controller: _professionTextController,
                decoration: buildInputDecoration(
                    label: 'Your Profession', hintText: '')),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
                controller: _quoteTextController,
                decoration: buildInputDecoration(
                    label: 'Favourite Quote', hintText: '')),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
                controller: _avatarTextController,
                decoration:
                    buildInputDecoration(label: 'Avatar URL', hintText: '')),
          ),
        ],
      ),
    )),
    actions: [
      TextButton(
          onPressed: () {
            FirebaseFirestore.instance.collection('users').doc(user.id).update(
                MUser(
                        uid: user.uid,
                        avatarUrl: _avatarTextController.text,
                        displayName: _displayNameTextController.text,
                        profession: _professionTextController.text,
                        quote: _quoteTextController.text)
                    .toMap());
          },
          child: Text('Update')),
      TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel'))
    ],
  );
}
