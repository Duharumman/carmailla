import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';
import 'package:yellow_carmailla/App/models/car.dart';
import 'package:yellow_carmailla/App/models/entry.dart';
import 'package:yellow_carmailla/App/services/Firestore_services.dart';
import 'package:yellow_carmailla/App/services/api_path.dart';

abstract class Database {
  Future<void> setCar(Car car);
  Future<void> deleteCar(Car car);
  Stream<List<Car>> carsStream();

  Future<void> setEntry(Entry entry);
  Future<void> deleteEntry(Entry entry);
  Stream<List<Entry>> entriesStream({Car car});
}

String documentIdFromCurrentDate() => DateTime.now().toIso8601String();

class FirestoreDatabase implements Database {
  FirestoreDatabase({@required this.uid}) : assert(uid != null);
  final String uid;

  final _service = FirestoreService.instance;

  @override
  Future<void> setCar(Car car) => _service.setData(
        path: APIpath.car(uid, car.id),
        data: car.toMap(),
      );

  @override
  Future<void> deleteCar(Car car) async {
    // delete where entry.jobId == job.jobId
    final allEntries = await entriesStream(car: car).first;
    for (Entry entry in allEntries) {
      if (entry.carId == car.id) {
        await deleteEntry(entry);
      }
    }
    // delete job
    await _service.deleteData(path: APIpath.car(uid, car.id));
  }

  @override
  Stream<List<Car>> carsStream() => _service.collectionStream(
        path: APIpath.cars(uid),
        builder: (data, documentId) => Car.fromMap(data, documentId),
      );

  @override
  Future<void> setEntry(Entry entry) => _service.setData(
        path: APIpath.entry(uid, entry.id),
        data: entry.toMap(),
      );

  @override
  Future<void> deleteEntry(Entry entry) => _service.deleteData(
        path: APIpath.entry(uid, entry.id),
      );

  @override
  Stream<List<Entry>> entriesStream({Car car}) =>
      _service.collectionStream<Entry>(
        path: APIpath.entries(uid),
        queryBuilder: car != null
            ? (query) => query.where('carId', isEqualTo: car.id)
            : null,
        builder: (data, documentID) => Entry.fromMap(data, documentID),
        sort: (lhs, rhs) => rhs.start.compareTo(lhs.start),
      );
}
