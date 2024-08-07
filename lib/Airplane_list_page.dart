import 'package:flutter/material.dart';
import 'airplane.dart';
import 'airplane_dao.dart';

class AirplaneListPage extends StatefulWidget {
  @override
  _AirplaneListPageState createState() => _AirplaneListPageState();
}

class _AirplaneListPageState extends State<AirplaneListPage> {
  final AirplaneDao _airplaneDao = AirplaneDao();
  List<Airplane> _airplanes = [];

  @override
  void initState() {
    super.initState();
    _loadAirplanes();
  }

  Future<void> _loadAirplanes() async {
    try {
      final airplanes = await _airplaneDao.fetchAirplanes();
      setState(() {
        _airplanes = airplanes;
      });
    } catch (e) {
      _showError(e.toString());
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message))
    );
  }

  void _showAirplaneForm({Airplane? airplane}) {
    final typeController = TextEditingController(text: airplane?.type ?? '');
    final passengersController = TextEditingController(text: airplane?.passengers.toString() ?? '');
    final speedController = TextEditingController(text: airplane?.speed.toString() ?? '');
    final rangeController = TextEditingController(text: airplane?.range.toString() ?? '');

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(airplane == null ? 'Add New Airplane' : 'Edit Airplane'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                _buildTextField(typeController, 'Type'),
                _buildTextField(passengersController, 'Passengers', numeric: true),
                _buildTextField(speedController, 'Speed (km/h)', numeric: true),
                _buildTextField(rangeController, 'Range (km)', numeric: true),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text(airplane == null ? 'Add' : 'Update'),
              onPressed: () => _submitAirplaneForm(
                  typeController.text,
                  passengersController.text,
                  speedController.text,
                  rangeController.text,
                  airplane
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, {bool numeric = false}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(labelText: label),
      keyboardType: numeric ? TextInputType.number : TextInputType.text,
    );
  }

  void _submitAirplaneForm(String type, String passengers, String speed, String range, Airplane? airplane) {
    if ([type, passengers, speed, range].any((element) => element.isEmpty)) {
      _showError('All fields are required!');
      return;
    }

    final newAirplane = Airplane(
      id: airplane?.id,
      type: type,
      passengers: int.parse(passengers),
      speed: int.parse(speed),
      range: int.parse(range),
    );

    final future = airplane == null ?
    _airplaneDao.insertAirplane(newAirplane) :
    _airplaneDao.updateAirplane(newAirplane);

    future.then((_) {
      Navigator.of(context).pop();
      _loadAirplanes();
    }).catchError((e) {
      _showError('Failed to save airplane: $e');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Airplane List'),
      ),
      body: ListView.builder(
        itemCount: _airplanes.length,
        itemBuilder: (context, index) {
          final airplane = _airplanes[index];
          return ListTile(
            title: Text('${airplane.type} - ${airplane.passengers} passengers'),
            subtitle: Text('Speed: ${airplane.speed} km/h, Range: ${airplane.range} km'),
            onTap: () => _showAirplaneForm(airplane: airplane),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () => _showAirplaneForm(airplane: airplane),
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => _deleteAirplane(airplane),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _showAirplaneForm(),
      ),
    );
  }

  void _deleteAirplane(Airplane airplane) {
    _airplaneDao.deleteAirplane(airplane.id!).then((_) {
      _loadAirplanes();
    }).catchError((e) {
      _showError('Failed to delete airplane: $e');
    });
  }
}
