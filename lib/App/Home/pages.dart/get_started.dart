import 'package:flutter/material.dart';
import 'package:yellow_carmailla/App/sign_in/sign_in_button.dart';
import 'package:yellow_carmailla/landing_page.dart';

class Onboarding extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/car3.jpeg"), fit: BoxFit.cover)),
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 73, left: 32, right: 32, bottom: 16),
              child: Container(
                child: SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 30.0),
                            child: Text.rich(TextSpan(
                              text: "Welcom to Carmilla car rent in Jordan",
                              style: TextStyle(
                                  fontSize: 38.0,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).primaryColor),
                            )),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SignInButton(
                              text: 'GET STARTED',
                              textColor: Colors.white,
                              color: Theme.of(context).primaryColor,
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => LandingPage(),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )));
  }
}
