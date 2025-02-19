import 'package:mongo_dart/mongo_dart.dart' as mongo;

class PhoneModel {
  final mongo.ObjectId id;
  String marca;
  String modelo;
  int existencia;
  double precio;

  PhoneModel({
    required this.id,
    required this.marca,
    required this.modelo,
    required this.existencia,
    required this.precio,
  });
  // convertir un map a Json
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'marca': marca,
      'modelo': modelo,
      'existencia': existencia,
      'precio': precio,
    };
  }

  factory PhoneModel.fromJson(Map<String, dynamic> json) {
    var id = json['_id'];
    if (id is String) {
      try {
        id = mongo.ObjectId.fromHexString(id);
      } catch (e) {
        id = mongo.ObjectId();
      }
    } else if (id is! mongo.ObjectId) {
      id = mongo.ObjectId();
    }
    return PhoneModel(
      id: id as mongo.ObjectId,
      marca: json['marca'] as String,
      modelo: json['modelo'] as String,
      existencia: json['existencia'] as int,
      precio: json['precio'] as double,
    );
  }
}
