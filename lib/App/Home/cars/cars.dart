import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:yellow_carmailla/App/Home/car_entries/car_entries_page.dart';
import 'package:yellow_carmailla/App/Home/cars/add_cars.dart';
import 'package:yellow_carmailla/App/Home/cars/cars_list.dart';
import 'package:yellow_carmailla/App/Home/cars/list_item_builder.dart';
import 'package:yellow_carmailla/App/Home/pages.dart/nav_drawer.dart';
import 'package:yellow_carmailla/App/common_widgets/show_alert_dialog.dart';
import 'package:yellow_carmailla/App/common_widgets/show_exaption_alert_dialog.dart';
import 'package:yellow_carmailla/App/models/car.dart';
import 'package:yellow_carmailla/App/services/auth_provider.dart';
import 'package:yellow_carmailla/App/services/database.dart';

class Cars extends StatelessWidget {
  Future<void> _signOut(BuildContext context) async {
    try {
      final auth = AuthProvider.of(context);
      await auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _confirmSignOut(BuildContext context) async {
    final didRequestSignOut = await showAlertDialog(context,
        title: 'Logout',
        content: 'Are you sure that are you want to logout?',
        cancelActionText: 'Cancel',
        defaultActionText: 'Logout');
    if (didRequestSignOut == true) {
      _signOut(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final database = Provider.of<Database>(context, listen: false);
    database.carsStream();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
        brightness: Brightness.light,
        title: Text(
          "CARMIALLA",
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add, color: Colors.white),
            onPressed: () => EditCarPage.show(
              context,
              database: Provider.of<Database>(context, listen: false),
            ),
          ),
          FlatButton(
            child: Text(
              'Logout',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            onPressed: () => _confirmSignOut(context),
          ),
        ],
      ),
      drawer: NavDrawer(),
      body: _buildContents(context),
    );
  }

  Future<void> _delete(BuildContext context, Car car) async {
    try {
      final database = Provider.of<Database>(context, listen: false);
      await database.deleteCar(car);
    } on FirebaseException catch (e) {
      showExceptionAlertDialog(
        context,
        title: 'Operation faild',
        exception: e,
      );
    }
  }

  Widget _buildContents(BuildContext context) {
    final database = Provider.of<Database>(context, listen: false);
    return StreamBuilder<List<Car>>(
      stream: database.carsStream(),
      builder: (context, snapshot) {
        return ListItemsBuilder<Car>(
          snapshot: snapshot,
          itemBuilder: (context, car) => Dismissible(
            key: Key('car-${car.id}'),
            background: Container(color: Colors.red),
            direction: DismissDirection.endToStart,
            onDismissed: (direction) => _delete(context, car),
            child: CarListTile(
              car: car,
              onTap: () => CarEntriesPage.show(context, car),
            ),
          ),
        );
      },
    );
  }
}
