import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class ShareScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4FAF4),
      // appBar: AppBar(
      //   title: Text('Share Item'),
      // ),
      body: ShareItemForm(),
    );
  }
}

class ShareItemForm extends StatefulWidget {
  @override
  _ShareItemFormState createState() => _ShareItemFormState();
}

class _ShareItemFormState extends State<ShareItemForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? _category;
  String? _itemName;
  String? _description;
  String? _imageUrl; // No need for a controller
  double? _hirePrice;
  late TextEditingController _itemNameController;
  late TextEditingController _descriptionController;
  late TextEditingController _hirePriceController;
  TextEditingController _imageUrlController = TextEditingController();

  File? _image;

  @override
  void initState() {
    super.initState();
    _itemNameController = TextEditingController();
    _descriptionController = TextEditingController();
    _hirePriceController = TextEditingController();
  }

  @override
  void dispose() {
    _itemNameController.dispose();
    _descriptionController.dispose();
    _hirePriceController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final form = _formKey.currentState;
    if (form != null && form.validate()) {
      form.save();

      try {
        // Upload image to Firebase Storage
        String imageName = DateTime.now().millisecondsSinceEpoch.toString();
        Reference storageReference =
            FirebaseStorage.instance.ref().child('share/$imageName.jpg');
        await storageReference.putFile(_image!);
        String imageUrl = await storageReference.getDownloadURL();

        // Upload item details to Firestore
        await FirebaseFirestore.instance.collection(_category!).add({
          'itemName': _itemName,
          'description': _description,
          'imageUrl': imageUrl,
          'hirePrice': _hirePrice,
          // Add more fields as needed
        });

        // Show success message or navigate to another screen
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Item shared successfully')),
        );
      } catch (e) {
        // Handle errors
        print('Error sharing item: $e');
      }
    }
  }

  Future<void> _getImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedImage != null) {
        _image = File(pickedImage.path);
        _imageUrlController.text =
            _image!.path.split('/').last; // Display image name
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: ListView(
          children: [
            const Text(
              'Share Item',
              style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),

            DropdownButtonFormField<String>(
              padding: const EdgeInsets.all(20),
              value: _category,
              decoration: const InputDecoration(labelText: 'Select Category'),
              onChanged: (String? newValue) {
                setState(() {
                  _category = newValue;
                });
              },
              items: <String>['Machines', 'Land', 'Fertilizers']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),

            // Hidden imageUrl field
            Container(
              margin: const EdgeInsets.all(10),
              child: TextFormField(
                controller: _imageUrlController,
                enabled: false,
                style: const TextStyle(color: Colors.transparent),
              ),
            ),

            Container(
              margin: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width / 2.5,
                  right: 20,
                  top: 5,
                  bottom: 5),
              child: FloatingActionButton(
                heroTag: 'Select Image',
                onPressed: _getImage,
                tooltip: 'Select Image',
                hoverColor: Colors.black26,
                foregroundColor: Colors.white,
                backgroundColor: Colors.black26,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                      Radius.circular(30.0)), // Set the border radius
                ),
                child: const Text(
                  'Select Image',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ),

            Container(
              margin: const EdgeInsets.all(10),
              child: TextFormField(
                controller: _itemNameController,
                decoration: const InputDecoration(
                  labelText: 'Item Name',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the item name';
                  }
                  return null;
                },
                onSaved: (value) {
                  _itemName = value;
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              child: TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  // errorText: "Please enter description",
                  iconColor: Colors.green,
                  // errorStyle: TextStyle(
                  //   color: Colors.red,
                  // ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
                onSaved: (value) {
                  _description = value;
                },
              ),
            ),

            if (_image != null) Image.file(_image!),
            Container(
              margin: EdgeInsets.all(10),
              child: TextFormField(
                controller: _hirePriceController,
                decoration: const InputDecoration(labelText: 'Hire Price'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the hire price';
                  }
                  return null;
                },
                onSaved: (value) {
                  _hirePrice = double.tryParse(value!);
                },
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: FloatingActionButton(
                heroTag: "share_item",
                onPressed: () {
                  SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: const Center(
                      heightFactor: 100,
                      widthFactor: 20,
                      child: Text(
                        'Item shared Successfully!',
                      ),
                    ),
                  );
                },
                tooltip: 'share item',
                hoverColor: Colors.black26,
                foregroundColor: Colors.white,
                backgroundColor: Colors.green,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                      Radius.circular(30.0)), // Set the border radius
                ),
                child: const Text(
                  'Share Item',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
