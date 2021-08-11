import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import 'login_page.dart';

class GetStartedPage extends StatelessWidget {
  const GetStartedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: CircleAvatar(
        backgroundColor: HexColor('#f5f6f8'),
        child: Column(
          children: [
            Spacer(),
            Text(
              'Book Tracker',
              style: Theme.of(context).textTheme.headline3,
            ),
            SizedBox(height: 15),
            Text(
              ' "Read. Change. Yourself"',
              style: TextStyle(
                  color: Colors.black26,
                  fontSize: 29,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 50,
            ),
            TextButton.icon(
                style: TextButton.styleFrom(
                    primary: Colors.white,
                    backgroundColor: HexColor('69639f'),
                    textStyle: TextStyle(fontSize: 18)),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginPage(),
                      ));
                },
                icon: Icon(Icons.login_rounded),
                label: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Sign in to get started'),
                )),
            Spacer()
          ],
        ),
      ),
    );
  }
}
