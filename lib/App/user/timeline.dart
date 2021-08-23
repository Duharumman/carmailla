import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yellow_carmailla/App/Home/pages.dart/profile.dart';
import 'package:yellow_carmailla/App/user/home_page_user.dart';

class Timeline extends StatefulWidget {
  final int initialPage = 0;
  @override
  _Timeline createState() => _Timeline();
}

class _Timeline extends State<Timeline> {
  List _pageOptions = [
    Home(),
    Profile(),
  ];

  int _page;

  @override
  void initState() {
    super.initState();
    setState(() {
      _page = widget.initialPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);

    return Scaffold(
      body: _pageOptions[_page],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: _theme.primaryColor,
        selectedItemColor: _theme.accentColor,
        unselectedItemColor: Colors.white,
        currentIndex: _page,
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline), label: 'Account'),
        ],
      ),
    );
  }
}
