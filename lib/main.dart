import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:yellow_carmailla/App/Home/pages.dart/get_started.dart';

import 'App/services/auth_provider.dart';
import 'App/services/authentication_service.dart';

//flutter run --no-sound-null-safety
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AuthProvider(
      auth: Auth(),
      child: MaterialApp(
          title: "Carmilla",
          theme: ThemeData(
            primaryColor: Colors.amberAccent,
            accentColor: Colors.white,
          ),
          // debugShowCheckedModeBanner: flase,
          home: Onboarding()),
    );
  }
}
