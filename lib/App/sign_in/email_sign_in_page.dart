import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:yellow_carmailla/App/sign_in/email_sign_in_page_form.dart';

class EmailSignInpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        brightness: Brightness.light,
        title: Text(
          "Sign-In",
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor,
          ),
        ),
        centerTitle: true,
        // actions: [
        //   Padding(
        //     padding: EdgeInsets.only(right: 16),
        //     child: IconButton(
        //       icon: Icon(Icons.menu),
        //       color: Colors.black,
        //       onPressed: () {},
        //     ),
        //   )
        // ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 10,
          margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(17.0)),
          child: EmailSginINForm(),
        ),
      ),
      backgroundColor: Colors.grey[200],
    );
  }
}
