import 'package:flutter/material.dart';

class NavigationItem {
  IconData iconData;
  String s;
  NavigationItem(this.iconData, this.s);
}

List<NavigationItem> getNavigationItemList() {
  return <NavigationItem>[
    NavigationItem(Icons.home, "Home"),
    NavigationItem(Icons.post_add, "post"),
    NavigationItem(Icons.notifications, "notifications"),
    NavigationItem(Icons.person, "profile"),
  ];
}

class Car2 {
  final Image image;
  final String name;
  final int price;

  Car2({@required this.image, @required this.name, @required this.price});
}

List<String> carLogos = [
  "assets/bmw.png",
  "assets/mercedes.png",
  "assets/porsche.png",
  "assets/vw.png",
  "assets/hyundai-logo.png",
  "assets/nissan.jpeg",
  "assets/toyota.jpeg",
  "assets/ford-logo.png",
];

class Item {
  const Item(this.name);
  final String name;
  // final Icon icon;
}

List<Item> users = <Item>[
  const Item('BMW'),
  const Item('Flutter'),
  const Item('ReactNative'),
  const Item('iOS'),
];
