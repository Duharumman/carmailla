import 'package:flutter/material.dart';

enum TabItem { cars, account }

class TabItemData {
  const TabItemData({@required this.title, @required this.icon});

  final String title;
  final IconData icon;

  static const Map<TabItem, TabItemData> allTabs = {
    TabItem.cars: TabItemData(title: 'cars', icon: Icons.car_rental),
    // TabItem.post: TabItemData(title: 'post', icon: Icons.photo_album),
    TabItem.account: TabItemData(title: 'Account', icon: Icons.person),
  };
}
