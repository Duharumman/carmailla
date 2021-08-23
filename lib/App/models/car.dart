import 'package:flutter/material.dart';

class Car {
  Car({@required this.id, this.image, this.name, this.price});
  final String id;
  final Image image;
  final String name;
  final int price;

  factory Car.fromMap(Map<String, dynamic> data, String documentId) {
    if (data == null) {
      return null;
    }
    final String name = data['name'];
    final int price = data['price'];
    // final Image image = data['image'];
    return Car(id: documentId, name: name, price: price);
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': price,
    };
  }
}
