import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yellow_carmailla/App/Home/pages.dart/home_page.dart';
import 'package:yellow_carmailla/App/services/database.dart';
import 'App/services/auth_provider.dart';
import 'App/sign_in/sign_in_page.dart';

class LandingPage extends StatelessWidget {
  Widget build(BuildContext context) {
    final auth = AuthProvider.of(context);
    return StreamBuilder<User>(
      stream: auth.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final User user = snapshot.data;

          if (user == null) {
            return SignInPage();
          }
          return Provider<Database>(
              create: (_) => FirestoreDatabase(uid: user.uid),
              child: HomePage());
        }
        return Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
