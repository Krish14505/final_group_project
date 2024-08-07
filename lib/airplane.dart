class Airplane {
  int? id;
  final String type;
  final int passengers;
  final int speed;
  final int range;

  Airplane({
    this.id,
    required this.type,
    required this.passengers,
    required this.speed,
    required this.range,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type,
      'passengers': passengers,
      'speed': speed,
      'range': range,
    };
  }

  factory Airplane.fromMap(Map<String, dynamic> map) {
    return Airplane(
      id: map['id'],
      type: map['type'],
      passengers: map['passengers'],
      speed: map['speed'],
      range: map['range'],
    );
  }
}

