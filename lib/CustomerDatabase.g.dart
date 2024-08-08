// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CustomerDatabase.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

abstract class $CustomerDatabaseBuilderContract {
  /// Adds migrations to the builder.
  $CustomerDatabaseBuilderContract addMigrations(List<Migration> migrations);

  /// Adds a database [Callback] to the builder.
  $CustomerDatabaseBuilderContract addCallback(Callback callback);

  /// Creates the database and initializes it.
  Future<CustomerDatabase> build();
}

// ignore: avoid_classes_with_only_static_members
class $FloorCustomerDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $CustomerDatabaseBuilderContract databaseBuilder(String name) =>
      _$CustomerDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $CustomerDatabaseBuilderContract inMemoryDatabaseBuilder() =>
      _$CustomerDatabaseBuilder(null);
}

class _$CustomerDatabaseBuilder implements $CustomerDatabaseBuilderContract {
  _$CustomerDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  @override
  $CustomerDatabaseBuilderContract addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  @override
  $CustomerDatabaseBuilderContract addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  @override
  Future<CustomerDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$CustomerDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$CustomerDatabase extends CustomerDatabase {
  _$CustomerDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  CustomerDAO? _getCustomerDAOInstance;

  AirplaneDao? _getAirplaneDAOInstance;

  ReservationDAO? _getReservationDAOInstance;

  FlightsDAO? _flightsDAOInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 3,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Customer` (`customer_id` INTEGER NOT NULL, `first_name` TEXT NOT NULL, `last_name` TEXT NOT NULL, `email` TEXT NOT NULL, `phoneNumber` TEXT NOT NULL, `address` TEXT NOT NULL, `birthday` TEXT NOT NULL, PRIMARY KEY (`customer_id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Airplane` (`id` INTEGER NOT NULL, `airplaneType` TEXT NOT NULL, `number_passenger` TEXT NOT NULL, `maximum_speed` TEXT NOT NULL, `distance` TEXT NOT NULL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `reservations` (`reservationId` INTEGER NOT NULL, `reservationDate` TEXT NOT NULL, `reservationName` TEXT NOT NULL, PRIMARY KEY (`reservationId`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Flight` (`flight_id` INTEGER NOT NULL, `destination` TEXT NOT NULL, `source` TEXT NOT NULL, `departure` INTEGER NOT NULL, `arrival` INTEGER NOT NULL, PRIMARY KEY (`flight_id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  CustomerDAO get getCustomerDAO {
    return _getCustomerDAOInstance ??= _$CustomerDAO(database, changeListener);
  }

  @override
  AirplaneDao get getAirplaneDAO {
    return _getAirplaneDAOInstance ??= _$AirplaneDao(database, changeListener);
  }

  @override
  ReservationDAO get getReservationDAO {
    return _getReservationDAOInstance ??=
        _$ReservationDAO(database, changeListener);
  }

  @override
  FlightsDAO get flightsDAO {
    return _flightsDAOInstance ??= _$FlightsDAO(database, changeListener);
  }
}

class _$CustomerDAO extends CustomerDAO {
  _$CustomerDAO(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _customerInsertionAdapter = InsertionAdapter(
            database,
            'Customer',
            (Customer item) => <String, Object?>{
                  'customer_id': item.customer_id,
                  'first_name': item.first_name,
                  'last_name': item.last_name,
                  'email': item.email,
                  'phoneNumber': item.phoneNumber,
                  'address': item.address,
                  'birthday': item.birthday
                }),
        _customerUpdateAdapter = UpdateAdapter(
            database,
            'Customer',
            ['customer_id'],
            (Customer item) => <String, Object?>{
                  'customer_id': item.customer_id,
                  'first_name': item.first_name,
                  'last_name': item.last_name,
                  'email': item.email,
                  'phoneNumber': item.phoneNumber,
                  'address': item.address,
                  'birthday': item.birthday
                }),
        _customerDeletionAdapter = DeletionAdapter(
            database,
            'Customer',
            ['customer_id'],
            (Customer item) => <String, Object?>{
                  'customer_id': item.customer_id,
                  'first_name': item.first_name,
                  'last_name': item.last_name,
                  'email': item.email,
                  'phoneNumber': item.phoneNumber,
                  'address': item.address,
                  'birthday': item.birthday
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Customer> _customerInsertionAdapter;

  final UpdateAdapter<Customer> _customerUpdateAdapter;

  final DeletionAdapter<Customer> _customerDeletionAdapter;

  @override
  Future<List<Customer>> getAllCustomers() async {
    return _queryAdapter.queryList('select * from Customer',
        mapper: (Map<String, Object?> row) => Customer(
            row['customer_id'] as int,
            row['first_name'] as String,
            row['last_name'] as String,
            row['email'] as String,
            row['phoneNumber'] as String,
            row['address'] as String,
            row['birthday'] as String));
  }

  @override
  Future<void> addCustomer(Customer customer) async {
    await _customerInsertionAdapter.insert(customer, OnConflictStrategy.abort);
  }

  @override
  Future<int> updateCustomer(Customer customer) {
    return _customerUpdateAdapter.updateAndReturnChangedRows(
        customer, OnConflictStrategy.abort);
  }

  @override
  Future<int> deleteCustomer(Customer customer) {
    return _customerDeletionAdapter.deleteAndReturnChangedRows(customer);
  }
}

class _$AirplaneDao extends AirplaneDao {
  _$AirplaneDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _airplaneInsertionAdapter = InsertionAdapter(
            database,
            'Airplane',
            (Airplane item) => <String, Object?>{
                  'id': item.id,
                  'airplaneType': item.airplaneType,
                  'number_passenger': item.number_passenger,
                  'maximum_speed': item.maximum_speed,
                  'distance': item.distance
                }),
        _airplaneUpdateAdapter = UpdateAdapter(
            database,
            'Airplane',
            ['id'],
            (Airplane item) => <String, Object?>{
                  'id': item.id,
                  'airplaneType': item.airplaneType,
                  'number_passenger': item.number_passenger,
                  'maximum_speed': item.maximum_speed,
                  'distance': item.distance
                }),
        _airplaneDeletionAdapter = DeletionAdapter(
            database,
            'Airplane',
            ['id'],
            (Airplane item) => <String, Object?>{
                  'id': item.id,
                  'airplaneType': item.airplaneType,
                  'number_passenger': item.number_passenger,
                  'maximum_speed': item.maximum_speed,
                  'distance': item.distance
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Airplane> _airplaneInsertionAdapter;

  final UpdateAdapter<Airplane> _airplaneUpdateAdapter;

  final DeletionAdapter<Airplane> _airplaneDeletionAdapter;

  @override
  Future<List<Airplane>> getAllAirPlanes() async {
    return _queryAdapter.queryList('select * from Airplane',
        mapper: (Map<String, Object?> row) => Airplane(
            row['id'] as int,
            row['airplaneType'] as String,
            row['number_passenger'] as String,
            row['maximum_speed'] as String,
            row['distance'] as String));
  }

  @override
  Future<void> insertAirplane(Airplane airplane) async {
    await _airplaneInsertionAdapter.insert(airplane, OnConflictStrategy.abort);
  }

  @override
  Future<int> updateAirplane(Airplane airplane) {
    return _airplaneUpdateAdapter.updateAndReturnChangedRows(
        airplane, OnConflictStrategy.abort);
  }

  @override
  Future<int> deleteAirplane(Airplane airplane) {
    return _airplaneDeletionAdapter.deleteAndReturnChangedRows(airplane);
  }
}

class _$ReservationDAO extends ReservationDAO {
  _$ReservationDAO(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _reservationInsertionAdapter = InsertionAdapter(
            database,
            'reservations',
            (Reservation item) => <String, Object?>{
                  'reservationId': item.reservationId,
                  'reservationDate': item.reservationDate,
                  'reservationName': item.reservationName
                }),
        _reservationUpdateAdapter = UpdateAdapter(
            database,
            'reservations',
            ['reservationId'],
            (Reservation item) => <String, Object?>{
                  'reservationId': item.reservationId,
                  'reservationDate': item.reservationDate,
                  'reservationName': item.reservationName
                }),
        _reservationDeletionAdapter = DeletionAdapter(
            database,
            'reservations',
            ['reservationId'],
            (Reservation item) => <String, Object?>{
                  'reservationId': item.reservationId,
                  'reservationDate': item.reservationDate,
                  'reservationName': item.reservationName
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Reservation> _reservationInsertionAdapter;

  final UpdateAdapter<Reservation> _reservationUpdateAdapter;

  final DeletionAdapter<Reservation> _reservationDeletionAdapter;

  @override
  Future<List<Reservation>> fetchAllReservations() async {
    return _queryAdapter.queryList('SELECT * FROM Reservation',
        mapper: (Map<String, Object?> row) => Reservation(
            row['reservationId'] as int,
            row['reservationDate'] as String,
            row['reservationName'] as String));
  }

  @override
  Future<List<Reservation>> getAllReservations() async {
    return _queryAdapter.queryList('SELECT * FROM Reservation',
        mapper: (Map<String, Object?> row) => Reservation(
            row['reservationId'] as int,
            row['reservationDate'] as String,
            row['reservationName'] as String));
  }

  @override
  Future<void> insertReservation(Reservation reservation) async {
    await _reservationInsertionAdapter.insert(
        reservation, OnConflictStrategy.abort);
  }

  @override
  Future<int> updateReservation(Reservation reservation) {
    return _reservationUpdateAdapter.updateAndReturnChangedRows(
        reservation, OnConflictStrategy.abort);
  }

  @override
  Future<int> deleteReservation(Reservation reservation) {
    return _reservationDeletionAdapter.deleteAndReturnChangedRows(reservation);
  }
}

class _$FlightsDAO extends FlightsDAO {
  _$FlightsDAO(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _flightInsertionAdapter = InsertionAdapter(
            database,
            'Flight',
            (Flight item) => <String, Object?>{
                  'flight_id': item.flight_id,
                  'destination': item.destination,
                  'source': item.source,
                  'departure': item.departure,
                  'arrival': item.arrival
                }),
        _flightUpdateAdapter = UpdateAdapter(
            database,
            'Flight',
            ['flight_id'],
            (Flight item) => <String, Object?>{
                  'flight_id': item.flight_id,
                  'destination': item.destination,
                  'source': item.source,
                  'departure': item.departure,
                  'arrival': item.arrival
                }),
        _flightDeletionAdapter = DeletionAdapter(
            database,
            'Flight',
            ['flight_id'],
            (Flight item) => <String, Object?>{
                  'flight_id': item.flight_id,
                  'destination': item.destination,
                  'source': item.source,
                  'departure': item.departure,
                  'arrival': item.arrival
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Flight> _flightInsertionAdapter;

  final UpdateAdapter<Flight> _flightUpdateAdapter;

  final DeletionAdapter<Flight> _flightDeletionAdapter;

  @override
  Future<List<Flight>> getAllFlights() async {
    return _queryAdapter.queryList('select * from Flight',
        mapper: (Map<String, Object?> row) => Flight(
            row['flight_id'] as int,
            row['destination'] as String,
            row['source'] as String,
            row['arrival'] as int,
            row['departure'] as int));
  }

  @override
  Future<void> addFlight(Flight flight) async {
    await _flightInsertionAdapter.insert(flight, OnConflictStrategy.abort);
  }

  @override
  Future<int> updateFlight(Flight flight) {
    return _flightUpdateAdapter.updateAndReturnChangedRows(
        flight, OnConflictStrategy.abort);
  }

  @override
  Future<int> deleteFlight(Flight flight) {
    return _flightDeletionAdapter.deleteAndReturnChangedRows(flight);
  }
}
