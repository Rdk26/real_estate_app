import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/services.dart';

class AddAnnouncementPage extends StatefulWidget {
  final String? propertyId;
  final Map<String, dynamic>? initialData;

  const AddAnnouncementPage({super.key, this.propertyId, this.initialData});

  @override
  AddAnnouncementPageState createState() => AddAnnouncementPageState();
}

class AddAnnouncementPageState extends State<AddAnnouncementPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final List<XFile> _images = [];

  final ImagePicker _picker = ImagePicker();

  String? _selectedBathrooms;
  String? _selectedBedrooms;
  String? _selectedLivingRooms;
  String? _selectedKitchens;

  @override
  void initState() {
    super.initState();
    if (widget.initialData != null) {
      _titleController.text = widget.initialData!['title'] ?? '';
      _selectedBathrooms = widget.initialData!['bathRooms'] ?? '';
      _selectedBedrooms = widget.initialData!['bedRooms'] ?? '';
      _descriptionController.text = widget.initialData!['description'] ?? '';
      _selectedLivingRooms = widget.initialData!['livingRooms'] ?? '';
      _selectedKitchens = widget.initialData!['kitchens'] ?? '';
      _locationController.text = widget.initialData!['location'] ?? '';
      _priceController.text = widget.initialData!['price']?.toString() ?? '';
      // Load images if they exist in initial data
    }
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    _locationController.dispose();
    _priceController.dispose();
    _titleController.dispose();
    super.dispose();
  }

  Future<void> _uploadImagesAndSubmitAnnouncement() async {
    try {
      print('Iniciando upload de imagens...');
      List<String> imageUrls = [];

      for (var image in _images) {
        final storageRef = _storage.ref().child('announcements/${DateTime.now().millisecondsSinceEpoch}_${image.name}');
        final uploadTask = kIsWeb
            ? storageRef.putData(await image.readAsBytes())
            : storageRef.putFile(File(image.path));

        final snapshot = await uploadTask.whenComplete(() => null);
        final downloadUrl = await snapshot.ref.getDownloadURL();

        imageUrls.add(downloadUrl);
      }

      print('Upload de imagens concluído.');

      String description = _descriptionController.text;
      String location = _locationController.text;
      String price = _priceController.text;
      String title = _titleController.text;

      final data = {
        'bathRooms': _selectedBathrooms,
        'bedRooms': _selectedBedrooms,
        'description': description,
        'livingRooms': _selectedLivingRooms,
        'kitchens': _selectedKitchens,
        'location': location,
        'price': price,
        'title': title,
        'userId': FirebaseAuth.instance.currentUser!.uid,
        'imageUrls': imageUrls,
      };

      if (widget.propertyId == null) {
        await _firestore.collection('properties').add(data);
      } else {
        await _firestore.collection('properties').doc(widget.propertyId).update(data);
      }

      print('Anúncio enviado com sucesso.');
      if (mounted) {
        Navigator.pop(context);
      }
    } catch (e) {
      print('Erro ao enviar anúncio: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao enviar anúncio: $e'),
          ),
        );
      }
    }
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _images.add(pickedFile);
      });
    }
  }

  Future<void> _takePhoto() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _images.add(pickedFile);
      });
    }
  }

  Widget _buildImagePreview(XFile image) {
    if (kIsWeb) {
      return Image.network(image.path, width: 100, height: 100, fit: BoxFit.cover);
    } else {
      return Image.file(File(image.path), width: 100, height: 100, fit: BoxFit.cover);
    }
  }

  @override
  Widget build(BuildContext context) {
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
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^[^\d][\w\s]*$')),
                ],
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: _selectedBathrooms,
                items: List.generate(10, (index) => (index + 1).toString()).map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                decoration: const InputDecoration(
                  labelText: 'Casas de banho',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
                onChanged: (newValue) {
                  setState(() {
                    _selectedBathrooms = newValue;
                  });
                },
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: _selectedBedrooms,
                items: List.generate(10, (index) => (index + 1).toString()).map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                decoration: const InputDecoration(
                  labelText: 'Quartos',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
                onChanged: (newValue) {
                  setState(() {
                    _selectedBedrooms = newValue;
                  });
                },
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: _selectedLivingRooms,
                items: List.generate(10, (index) => (index + 1).toString()).map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                decoration: const InputDecoration(
                  labelText: 'Salas',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
                onChanged: (newValue) {
                  setState(() {
                    _selectedLivingRooms = newValue;
                  });
                },
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: _selectedKitchens,
                items: List.generate(10, (index) => (index + 1).toString()).map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                decoration: const InputDecoration(
                  labelText: 'Cozinhas',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
                onChanged: (newValue) {
                  setState(() {
                    _selectedKitchens = newValue;
                  });
                },
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
                controller: _priceController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Preço',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _descriptionController,
                maxLines: 5,
                decoration: const InputDecoration(
                  labelText: 'Descrição',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Wrap(
                spacing: 10,
                children: _images
                    .map((file) => Stack(
                          children: [
                            _buildImagePreview(file),
                            Positioned(
                              right: 0,
                              top: 0,
                              child: IconButton(
                                icon: const Icon(Icons.remove_circle, color: Colors.red),
                                onPressed: () {
                                  setState(() {
                                    _images.remove(file);
                                  });
                                },
                              ),
                            ),
                          ],
                        ))
                    .toList(),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: _pickImage,
                    child: const Text('Galeria'),
                  ),
                  ElevatedButton(
                    onPressed: _takePhoto,
                    child: const Text('Câmera'),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _uploadImagesAndSubmitAnnouncement,
                child: const Text('Enviar Anúncio'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
