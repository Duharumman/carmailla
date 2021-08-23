import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:yellow_carmailla/App/common_widgets/show_alert_dialog.dart';
import 'package:yellow_carmailla/App/common_widgets/show_exaption_alert_dialog.dart';
import 'package:yellow_carmailla/App/models/car.dart';
import 'package:yellow_carmailla/App/services/database.dart';

class EditCarPage extends StatefulWidget {
  const EditCarPage({Key key, @required this.database, this.car})
      : super(key: key);
  final Database database;
  final Car car;

  static Future<void> show(BuildContext context,
      {Database database, Car car}) async {
    await Navigator.of(context, rootNavigator: true).push(
      MaterialPageRoute(
        builder: (context) => EditCarPage(database: database, car: car),
        fullscreenDialog: true,
      ),
    );
  }

  @override
  _EditJobPageState createState() => _EditJobPageState();
}

class _EditJobPageState extends State<EditCarPage> {
  final _formKey = GlobalKey<FormState>();

  String _name;
  int _ratePerHour;

  @override
  void initState() {
    super.initState();
    if (widget.car != null) {
      _name = widget.car.name;
      _ratePerHour = widget.car.price;
    }
  }

  bool _validateAndSaveForm() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  Future<void> _submit() async {
    if (_validateAndSaveForm()) {
      try {
        final cars = await widget.database.carsStream().first;
        final allNames = cars.map((car) => car.name).toList();
        if (widget.car != null) {
          allNames.remove(widget.car.name);
        }
        if (allNames.contains(_name)) {
          showAlertDialog(
            context,
            title: 'Name already used',
            content: 'Please choose a different job name',
            defaultActionText: 'OK',
          );
        } else {
          final id = widget.car?.id ?? documentIdFromCurrentDate();
          final car = Car(id: id, name: _name, price: _ratePerHour);
          await widget.database.setCar(car);
          Navigator.of(context).pop();
        }
      } on FirebaseException catch (e) {
        showExceptionAlertDialog(
          context,
          title: 'Operation failed',
          exception: e,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2.0,
        title: Text(widget.car == null ? 'New Car' : 'Edit Car'),
        actions: <Widget>[
          FlatButton(
            child: Text(
              'Save',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            onPressed: _submit,
          ),
        ],
      ),
      body: _buildContents(),
      backgroundColor: Colors.grey[200],
    );
  }

  Widget _buildContents() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: _buildForm(),
          ),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: _buildFormChildren(),
      ),
    );
  }

  List<Widget> _buildFormChildren() {
    return [
      TextFormField(
        decoration: InputDecoration(labelText: 'Car name'),
        initialValue: _name,
        validator: (value) => value.isNotEmpty ? null : 'Name can\'t be empty',
        onSaved: (value) => _name = value,
      ),
      TextFormField(
        decoration: InputDecoration(labelText: 'Price per hour'),
        initialValue: _ratePerHour != null ? '$_ratePerHour' : null,
        keyboardType: TextInputType.numberWithOptions(
          signed: false,
          decimal: false,
        ),
        onSaved: (value) => _ratePerHour = int.tryParse(value) ?? 0,
      ),
    ];
  }
}
