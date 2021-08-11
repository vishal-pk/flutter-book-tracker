import 'package:book_tracker/widgets/create_account_form.dart';
import 'package:book_tracker/widgets/login_form.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isCreateAccountClicked = false;

  final _formKey = GlobalKey<FormState>();

  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        child: Column(
          children: [
            Expanded(
                // flex: 2,
                child: Container(
              color: HexColor('#b9c2d1'),
            )),
            Text(
              'Sign in',
              style: Theme.of(context).textTheme.headline5,
            ),
            SizedBox(
              height: 10,
            ),
            Column(
              children: [
                SizedBox(
                    width: 300,
                    height: 300,
                    child: isCreateAccountClicked
                        ? LoginForm(
                            formKey: _formKey,
                            emailTextController: _emailTextController,
                            passwordTextController: _passwordTextController)
                        : CreateAccountForm(
                            formKey: _formKey,
                            emailTextController: _emailTextController,
                            passwordTextController: _passwordTextController)),
                TextButton.icon(
                  icon: Icon(Icons.portrait_rounded),
                  label: Text(!isCreateAccountClicked
                      ? 'Already have an Account?'
                      : 'Create Account'),
                  onPressed: () {
                    setState(() {
                      isCreateAccountClicked = !isCreateAccountClicked;
                    });
                  },
                  style: TextButton.styleFrom(
                      primary: HexColor('#fd5b28'),
                      textStyle:
                          TextStyle(fontSize: 18, fontStyle: FontStyle.italic)),
                )
              ],
            ),
            Expanded(
                // flex: 2,
                child: Container(
              color: HexColor('#b9c2d1'),
            )),
          ],
        ),
      ),
    );
  }
}
