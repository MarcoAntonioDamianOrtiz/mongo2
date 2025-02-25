import 'package:flutter/material.dart';
import 'package:mongo2/models/phone_model.dart';
import 'package:mongo2/services/mongo_service.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;

class InsertPhoneScreen extends StatefulWidget {
  const InsertPhoneScreen({super.key});

  @override
  State<InsertPhoneScreen> createState() => InsertPhoneScreenState();
}

class InsertPhoneScreenState extends State<InsertPhoneScreen> {
  late TextEditingController _marcaController;
  late TextEditingController _modeloController;
  late TextEditingController _existenciaController;
  late TextEditingController _precioController;

  @override
  void initState() {
    super.initState();
    _marcaController = TextEditingController();
    _modeloController = TextEditingController();
    _existenciaController = TextEditingController();
    _precioController = TextEditingController();
  }

  void dispose() {
    _marcaController.dispose();
    _modeloController.dispose();
    _existenciaController.dispose();
    _precioController.dispose();
    super.dispose();
  }

  void _inserPhone() async {
    var phone = PhoneModel(
        id: mongo.ObjectId(),
        marca: _marcaController.text,
        modelo: _modeloController.text,
        existencia: int.parse(_existenciaController.text),
        precio: double.parse(_precioController.text));
    await MongoService().InsertPhone(phone);
    if (!mounted) return;
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Insertar nuevo Telefono"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _marcaController,
              decoration: InputDecoration(labelText: "Marca"),
            ),
            TextField(
              controller: _modeloController,
              decoration: InputDecoration(labelText: "Modelo"),
            ),
            TextField(
              controller: _existenciaController,
              decoration: InputDecoration(labelText: "Existencia"),
            ),
            TextField(
              controller: _precioController,
              decoration: InputDecoration(labelText: "Precio"),
            ),
            const SizedBox(height: 16),
            ElevatedButton(onPressed: _inserPhone, child: Text("Insertar"))
          ],
        ),
      ),
    );
  }
}
