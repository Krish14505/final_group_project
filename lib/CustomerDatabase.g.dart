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
            'CREATE TABLE IF NOT EXISTS `Customer` (`customer_id` INTEGER NOT NULL, `first_name` TEXT NOT NULL, `last_name` TEXT NOT NULL, `email` TEXT NOT NULL, `phoneNumber` TEXT NOT NULL, `address` TEXT NOT NULL, `birthday` TEXT NOT NULL, PRIMARY KEY (`customer_id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  CustomerDAO get getCustomerDAO {
    return _getCustomerDAOInstance ??= _$CustomerDAO(database, changeListener);
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
