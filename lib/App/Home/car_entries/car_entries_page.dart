import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:yellow_carmailla/App/Home/car_entries/entry_list_item.dart';
import 'package:yellow_carmailla/App/Home/car_entries/entry_page.dart';
import 'package:yellow_carmailla/App/Home/cars/add_cars.dart';
import 'package:yellow_carmailla/App/Home/cars/list_item_builder.dart';
import 'package:yellow_carmailla/App/common_widgets/show_exaption_alert_dialog.dart';
import 'package:yellow_carmailla/App/models/car.dart';
import 'package:yellow_carmailla/App/models/entry.dart';
import 'package:yellow_carmailla/App/services/database.dart';

class CarEntriesPage extends StatelessWidget {
  const CarEntriesPage({@required this.database, @required this.car});
  final Database database;
  final Car car;

  static Future<void> show(BuildContext context, Car car,
      {Database database}) async {
    final database = Provider.of<Database>(context, listen: false);
    await Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: false,
        builder: (context) => CarEntriesPage(database: database, car: car),
      ),
    );
  }

  Future<void> _deleteEntry(BuildContext context, Entry entry) async {
    try {
      await database.deleteEntry(entry);
    } on FirebaseException catch (e) {
      showExceptionAlertDialog(
        context,
        title: 'Operation failed',
        exception: e,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2.0,
        title: Text(car.name),
        actions: <Widget>[
          FlatButton(
            child: Text(
              'Edit',
              style: TextStyle(fontSize: 18.0, color: Colors.white),
            ),
            onPressed: () =>
                EntryPage.show(context: context, database: database, car: car),
          ),
        ],
      ),
      body: _buildContent(context, car),
    );
  }

  Widget _buildContent(BuildContext context, Car car) {
    return StreamBuilder<List<Entry>>(
      stream: database.entriesStream(car: car),
      builder: (context, snapshot) {
        return ListItemsBuilder<Entry>(
          snapshot: snapshot,
          itemBuilder: (context, entry) {
            return DismissibleEntryListItem(
              key: Key('entry-${entry.id}'),
              entry: entry,
              car: car,
              onDismissed: () => _deleteEntry(context, entry),
              onTap: () => EntryPage.show(
                context: context,
                database: database,
                car: car,
                entry: entry,
              ),
            );
          },
        );
      },
    );
  }
}
