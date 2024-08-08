// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ReservationDB.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

abstract class $ReservationDBBuilderContract {
  /// Adds migrations to the builder.
  $ReservationDBBuilderContract addMigrations(List<Migration> migrations);

  /// Adds a database [Callback] to the builder.
  $ReservationDBBuilderContract addCallback(Callback callback);

  /// Creates the database and initializes it.
  Future<ReservationDB> build();
}

// ignore: avoid_classes_with_only_static_members
class $FloorReservationDB {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $ReservationDBBuilderContract databaseBuilder(String name) =>
      _$ReservationDBBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $ReservationDBBuilderContract inMemoryDatabaseBuilder() =>
      _$ReservationDBBuilder(null);
}

class _$ReservationDBBuilder implements $ReservationDBBuilderContract {
  _$ReservationDBBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  @override
  $ReservationDBBuilderContract addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  @override
  $ReservationDBBuilderContract addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  @override
  Future<ReservationDB> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$ReservationDB();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$ReservationDB extends ReservationDB {
  _$ReservationDB([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  ReservationDAO? _reservationDaoInstance;

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
            'CREATE TABLE IF NOT EXISTS `reservations` (`reservationId` INTEGER NOT NULL, `customerName` TEXT NOT NULL, `flightName` TEXT NOT NULL, `reservationDate` INTEGER NOT NULL, `reservationName` TEXT NOT NULL, PRIMARY KEY (`reservationId`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  ReservationDAO get reservationDao {
    return _reservationDaoInstance ??=
        _$ReservationDAO(database, changeListener);
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
                  'customerName': item.customerName,
                  'flightName': item.flightName,
                  'reservationDate':
                      _dateTimeConverter.encode(item.reservationDate),
                  'reservationName': item.reservationName
                }),
        _reservationUpdateAdapter = UpdateAdapter(
            database,
            'reservations',
            ['reservationId'],
            (Reservation item) => <String, Object?>{
                  'reservationId': item.reservationId,
                  'customerName': item.customerName,
                  'flightName': item.flightName,
                  'reservationDate':
                      _dateTimeConverter.encode(item.reservationDate),
                  'reservationName': item.reservationName
                }),
        _reservationDeletionAdapter = DeletionAdapter(
            database,
            'reservations',
            ['reservationId'],
            (Reservation item) => <String, Object?>{
                  'reservationId': item.reservationId,
                  'customerName': item.customerName,
                  'flightName': item.flightName,
                  'reservationDate':
                      _dateTimeConverter.encode(item.reservationDate),
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
            reservationId: row['reservationId'] as int,
            customerName: row['customerName'] as String,
            flightName: row['flightName'] as String,
            reservationDate:
                _dateTimeConverter.decode(row['reservationDate'] as int),
            reservationName: row['reservationName'] as String));
  }

  @override
  Future<List<Reservation>> getAllReservations() async {
    return _queryAdapter.queryList('SELECT * FROM Reservation',
        mapper: (Map<String, Object?> row) => Reservation(
            reservationId: row['reservationId'] as int,
            customerName: row['customerName'] as String,
            flightName: row['flightName'] as String,
            reservationDate:
                _dateTimeConverter.decode(row['reservationDate'] as int),
            reservationName: row['reservationName'] as String));
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

// ignore_for_file: unused_element
final _dateTimeConverter = DateTimeConverter();
