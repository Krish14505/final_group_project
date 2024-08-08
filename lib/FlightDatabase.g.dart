// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FlightDatabase.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

abstract class $FlightDatabaseBuilderContract {
  /// Adds migrations to the builder.
  $FlightDatabaseBuilderContract addMigrations(List<Migration> migrations);

  /// Adds a database [Callback] to the builder.
  $FlightDatabaseBuilderContract addCallback(Callback callback);

  /// Creates the database and initializes it.
  Future<FlightDatabase> build();
}

// ignore: avoid_classes_with_only_static_members
class $FloorFlightDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $FlightDatabaseBuilderContract databaseBuilder(String name) =>
      _$FlightDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $FlightDatabaseBuilderContract inMemoryDatabaseBuilder() =>
      _$FlightDatabaseBuilder(null);
}

class _$FlightDatabaseBuilder implements $FlightDatabaseBuilderContract {
  _$FlightDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  @override
  $FlightDatabaseBuilderContract addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  @override
  $FlightDatabaseBuilderContract addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  @override
  Future<FlightDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$FlightDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$FlightDatabase extends FlightDatabase {
  _$FlightDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  FlightsDAO? _flightsDAOInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
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
            'CREATE TABLE IF NOT EXISTS `Flight` (`flight_id` INTEGER NOT NULL, `destination` TEXT NOT NULL, `source` TEXT NOT NULL, `departure` INTEGER NOT NULL, `arrival` INTEGER NOT NULL, PRIMARY KEY (`flight_id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  FlightsDAO get flightsDAO {
    return _flightsDAOInstance ??= _$FlightsDAO(database, changeListener);
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
