
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:book_tracker/modal/user.dart';
import 'package:book_tracker/widgets/input_decoration.dart';
import 'package:book_tracker/widgets/update_user_profile.dart';

AlertDialog createProfileDialog(
      MUser currentUser,
      BuildContext context,
      ) {
        final TextEditingController _displayNameTextController =
        TextEditingController(text: currentUser.displayName);
    final TextEditingController _professionTextController =
        TextEditingController(text: currentUser.profession);
    final TextEditingController _avatarTextController = TextEditingController(text: currentUser.avatarUrl);
    final TextEditingController _quoteTextController = TextEditingController(text: currentUser.quote);
    return AlertDialog(
      content: Container(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.transparent,
                  backgroundImage: NetworkImage((currentUser.avatarUrl != null)
                      ? currentUser.avatarUrl.toString()
                      : 'https://images.pexels.com/photos/674010/pexels-photo-674010.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'),
                  radius: 50,
                )
              ],
            ),
            Text(
              'Books Red',
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(color: Colors.redAccent),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '${currentUser.displayName!.toUpperCase()}',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ),
                TextButton.icon(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return updateUserProfile( currentUser,
     _displayNameTextController,
     _professionTextController,
     _quoteTextController,
     _avatarTextController,context);
                        },
                      );
                    },
                    icon: Icon(
                      Icons.mode_edit,
                      color: Colors.black12,
                    ),
                    label: Text(''))
              ],
            ),
            Text(
              '${currentUser.profession}',
              style: Theme.of(context).textTheme.subtitle1,
            ),
            SizedBox(
              width: 100,
              height: 2,
              child: Container(
                color: Colors.red,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.blueGrey.shade100),
                  color: HexColor('#f1f3f6'),
                  borderRadius: BorderRadius.all(Radius.circular(4))),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    Text(
                      'Favourite Quote',
                      style: TextStyle(color: Colors.black),
                    ),
                    SizedBox(
                      width: 100,
                      height: 2,
                      child: Container(
                        color: Colors.black,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          '\"${currentUser.quote == null ? "Favourite Book Quote: Life is Great" : currentUser.quote}\"',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(fontStyle: FontStyle.italic),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
