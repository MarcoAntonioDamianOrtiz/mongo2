import 'dart:io';
import 'package:mongo2/models/phone_model.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;

class MongoService {
  //servicio para conectar con Mongo atlas
  // Usando Singleton
  static final MongoService _instance = MongoService._internal();

  late mongo.Db _db;

  MongoService._internal();

  factory MongoService() {
    return _instance;
  }

  Future<void> connect() async {
    try {
      _db = await mongo.Db.create(
          'mongodb+srv://mo27marco:esparta117@cluster0.ygwr4.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0');
      await _db.open();
      _db.databaseName = 'productos';
      print('Conexion a MongoDB establecida');
    } on SocketException catch (e) {
      print('Error de conexion: $e');
      rethrow;
    }
  }

  mongo.Db get db {
    if (!db.isConnected) {
      throw StateError(
          'Base de datos no inicializada, llama a connect() primero');
    }
    return _db;
  }

  Future<List<PhoneModel>> getPhones() async {
    final collection = _db.collection('celulares');
    print('Coleccion obtenida: $collection');
    var phones = await collection.find().toList();
    print('En MongoService: $phones');
    if (phones.isEmpty) {
      print('No se encontrar b on datos de la coleccion');
    }
    return phones.map((phone) => PhoneModel.fromJson(phone)).toList();
  }

  Future<void> insertPhone(PhoneModel phone) async {
    final collection = _db.collection('celulares');
    await collection.insertOne(phone.toJson());
  }

  Future<void> updatePhone(PhoneModel phone) async {
    final collection = _db.collection('celulares');
    await collection.updateOne(
        mongo.where.eq('_id', phone.id),
        mongo.modify
            .set('marca', phone.marca)
            .set('modelo', phone.modelo)
            .set('existencia', phone.existencia)
            .set('precio', phone.precio));
  }

  Future<void> deletePhone(mongo.ObjectId id) async {
    var collection = _db.collection('celulares');
    await collection.remove(mongo.where.eq('_id', id));
  }

  Future<void> InsertPhone(PhoneModel phone) async {
    final collection = _db.collection('celulares');
    await collection.insertOne(phone.toJson());
  }

  void close() {
    _db.close();
  }
}
