import 'package:flutter/material.dart';
import 'package:yellow_carmailla/App/models/car.dart';

class CarListTile extends StatelessWidget {
  const CarListTile({Key key, @required this.car, this.onTap})
      : super(key: key);

  final Car car;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(car.name),
      trailing: Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
