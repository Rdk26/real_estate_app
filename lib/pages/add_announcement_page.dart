import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'dart:io';

import 'package:real_estate_app/models/user.dart';

class AddAnnouncementPage extends StatefulWidget {
  const AddAnnouncementPage({super.key});

  @override
  AddAnnouncementPageState createState() => AddAnnouncementPageState();
}

class AddAnnouncementPageState extends State<AddAnnouncementPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final TextEditingController _bathRoomsController = TextEditingController();
  final TextEditingController _bedRoomsController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _livingRoomsController = TextEditingController();
  final TextEditingController _kitchensController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _imageUrlController = TextEditingController();
  final List<File> _images = [];

  final ImagePicker _picker = ImagePicker();

  @override
  void dispose() {
    _bathRoomsController.dispose();
    _bedRoomsController.dispose();
    _descriptionController.dispose();
    _livingRoomsController.dispose();
    _kitchensController.dispose();
    _locationController.dispose();
    _priceController.dispose();
    _titleController.dispose();
    super.dispose();
  }

  void submitAnnouncement(String owner) async {
    // Lógica para enviar o anúncio
    // integrar com a API ou bd
    String bathRooms = _bathRoomsController.text;
    String bedRooms = _bedRoomsController.text;
    String description = _descriptionController.text;
    String livingRooms = _livingRoomsController.text;
    String kitchens = _kitchensController.text;
    String location = _locationController.text;
    String price = _priceController.text;
    String title = _titleController.text;
    String image = _imageUrlController.text;

    await _firestore.collection('properties').doc().set({
      'bathRooms': bathRooms,
      'bedRooms': bedRooms,
      'description': description,
      'livingRooms': livingRooms,
      'kitchens': kitchens,
      'location': location,
      'price': price,
      'title': title,
      'image': image,
      'is_favorited': false,
      'owner': owner
    });

    Navigator.pop(context);
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _images.add(File(pickedFile.path));
      });
    }
  }

  Future<void> _takePhoto() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _images.add(File(pickedFile.path));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final userModel = Provider.of<UserModel>(context);

    String owner = userModel.id;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Adicionar Anúncio"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Título',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _bathRoomsController,
                decoration: const InputDecoration(
                  labelText: 'Casas de banho',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _bedRoomsController,
                decoration: const InputDecoration(
                  labelText: 'Quartos',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _livingRoomsController,
                decoration: const InputDecoration(
                  labelText: 'Salas',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _locationController,
                decoration: const InputDecoration(
                  labelText: 'Localização',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _kitchensController,
                decoration: const InputDecoration(
                  labelText: 'Cozinhas',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _imageUrlController,
                decoration: const InputDecoration(
                  labelText: 'Url da imagem',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Descrição',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
                maxLines: 5,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _priceController,
                decoration: const InputDecoration(
                  labelText: 'Preço',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  ElevatedButton.icon(
                    onPressed: _pickImage,
                    icon: const Icon(Icons.photo),
                    label: const Text("Selecionar Foto"),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton.icon(
                    onPressed: _takePhoto,
                    icon: const Icon(Icons.camera),
                    label: const Text("Tirar Foto"),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              _buildImageGrid(),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => submitAnnouncement(owner),
                child: const Text("Submeter Anúncio"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: _images.length,
      itemBuilder: (context, index) {
        return Stack(
          children: [
            Image.file(
              _images[index],
              fit: BoxFit.cover,
              width: double.infinity,
            ),
            Positioned(
              right: 0,
              top: 0,
              child: IconButton(
                icon: const Icon(Icons.close, color: Colors.red),
                onPressed: () {
                  setState(() {
                    _images.removeAt(index);
                  });
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
