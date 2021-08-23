import 'package:flutter/material.dart';
import 'package:yellow_carmailla/App/Home/pages.dart/nav_drawer.dart';
import 'package:yellow_carmailla/App/services/auth_provider.dart';
import 'package:yellow_carmailla/App/sign_in/email_sign_in_page.dart';
import 'package:yellow_carmailla/App/user/timeline.dart';
import 'package:yellow_carmailla/landing_page.dart';

import 'sign_in_button.dart';

class SignInPage extends StatelessWidget {
  Future<void> _singInAnonymously(BuildContext context) async {
    try {
      final auth = AuthProvider.of(context);

      await auth.signInAnonymously();
    } catch (e) {
      print(e.toString());
    }
  }

  void _signInWithEmail(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        fullscreenDialog: true,
        builder: (context) => EmailSignInpage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          brightness: Brightness.light,
          title: Text(
            "CARmailla",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor,
            ),
          ),
          centerTitle: true,
        ),
        drawer: NavDrawer(),
        body: _buildContent(context));
  }

  Widget _buildContent(BuildContext context) {
    return Card(
      elevation: 10,
      margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(17.0)),
      child: Stack(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SignInButton(
                  text: 'Sign in as employee ',
                  textColor: Colors.black,
                  color: Theme.of(context).primaryColor,
                  onPressed: () => _signInWithEmail(context),
                ),
                Align(
                    alignment: Alignment.center,
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        "Are you reday to use our App (:",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      ),
                    )),
                SignInButton(
                  text: 'sign in with Email',
                  textColor: Colors.black,
                  color: Theme.of(context).primaryColor,
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => Timeline(),
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 20.0,
                ),
                SignInButton(
                  text: 'AS A GUEST',
                  textColor: Colors.black,
                  color: Theme.of(context).primaryColor,
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => Timeline(),
                      ),
                    );
                  },
                ),
                SizedBox(height: 23.0),
                SizedBox(height: 20.0),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
