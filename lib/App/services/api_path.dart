class APIpath {
  static String car(String uid, String carId) => 'users/$uid/cars/$carId';
  static String cars(String uid) => 'users/$uid/cars';

  static String entry(String uid, String entryId) =>
      'users/$uid/entries/$entryId';
  static String entries(String uid) => 'users/$uid/entries';
}
