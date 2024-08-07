import 'database.dart';
import 'airplane.dart';

class AirplaneDao {
  final dbProvider = AppDatabase();

  Future<int> insertAirplane(Airplane airplane) async {
    final db = await dbProvider.database;
    try {
      int result = await db.insert('airplanes', airplane.toMap());
      return result;
    } catch (e) {
      print("Insert failed: $e");
      throw Exception('Failed to insert airplane');
    }
  }

  Future<List<Airplane>> fetchAirplanes() async {
    final db = await dbProvider.database;
    final maps = await db.query('airplanes');
    return List.generate(maps.length, (i) {
      return Airplane.fromMap(maps[i]);
    });
  }

  Future<int> updateAirplane(Airplane airplane) async {
    final db = await dbProvider.database;
    try {
      return await db.update(
        'airplanes',
        airplane.toMap(),
        where: 'id = ?',
        whereArgs: [airplane.id],
      );
    } catch (e) {
      print("Update failed: $e");
      throw Exception('Failed to update airplane');
    }
  }

  Future<int> deleteAirplane(int id) async {
    final db = await dbProvider.database;
    try {
      return await db.delete(
        'airplanes',
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (e) {
      print("Delete failed: $e");
      throw Exception('Failed to delete airplane');
    }
  }
}
