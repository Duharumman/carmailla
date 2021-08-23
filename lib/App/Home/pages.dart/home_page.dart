import 'package:flutter/material.dart';
import 'package:yellow_carmailla/App/Home/cars/cupertino_home_scaffold.dart';
import 'package:yellow_carmailla/App/Home/cars/tab_item.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TabItem _currentTab = TabItem.cars;

  void _select(TabItem tabItem) {
    setState(() => _currentTab = tabItem);
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoHomeScaffold(currentTab: _currentTab, onSelectTab: _select);
  }
}
