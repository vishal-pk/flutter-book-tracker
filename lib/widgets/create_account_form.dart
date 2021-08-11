import 'package:book_tracker/screens/main_screen.dart';
import 'package:book_tracker/services/create_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'input_decoration.dart';

class CreateAccountForm extends StatelessWidget {
  const CreateAccountForm({
    Key? key,
    required GlobalKey<FormState> formKey,
    required TextEditingController emailTextController,
    required TextEditingController passwordTextController,
  })  : _formKey = formKey,
        _emailTextController = emailTextController,
        _passwordTextController = passwordTextController,
        super(key: key);

  final GlobalKey<FormState> _formKey;
  final TextEditingController _emailTextController;
  final TextEditingController _passwordTextController;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Text(
              'Please enter a valid email and password that is atleast 6 characters in length'),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextFormField(
              validator: (value) {
                return (value?.isEmpty == true) ? 'Please add an email' : null;
              },
              controller: _emailTextController,
              decoration: buildInputDecoration(
                  hintText: 'john@example.com', label: 'Enter Email'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextFormField(
              validator: (value) {
                return (value?.isEmpty == true) ? 'Enter password' : null;
              },
              controller: _passwordTextController,
              obscureText: true,
              decoration: buildInputDecoration(
                  hintText: 'Password', label: 'Enter Password'),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          TextButton(
              style: TextButton.styleFrom(
                  primary: Colors.white,
                  padding: EdgeInsets.all(15),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4)),
                  backgroundColor: Colors.amber,
                  textStyle: TextStyle(fontSize: 18)),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  String email = _emailTextController.text;
                  FirebaseAuth.instance
                      .createUserWithEmailAndPassword(
                          email: _emailTextController.text,
                          password: _passwordTextController.text)
                      .then((value) {
                    if (value.user != null) {
                      String displayName = email.toString().split('@')[0];
                      createUser(displayName, context).then((value) {
                        FirebaseAuth.instance
                            .signInWithEmailAndPassword(
                                email: email,
                                password: _passwordTextController.text)
                            .then((value) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MainScreenPage()));
                        });
                      });
                    }
                  });
                } else {}
              },
              child: Text('Create Account'))
        ],
      ),
    );
  }
}
