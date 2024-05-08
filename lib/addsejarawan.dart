import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobileuts/listsejarawan.dart';
import 'package:image_picker/image_picker.dart';
import 'model/api_services.dart';



class AddSejarawan extends StatefulWidget {
  const AddSejarawan({super.key});

  @override
  State<AddSejarawan> createState() => _AddSejarawanState();
}

class _AddSejarawanState extends State<AddSejarawan> {
  final ApiServices apiService = ApiServices(baseUrl: AppConfig.baseUrl);
  String _selectedSex = "male";
  final TextEditingController nameController = TextEditingController();
  final TextEditingController birthdateController = TextEditingController();
  final TextEditingController originController = TextEditingController();
  final TextEditingController sexController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController imageController = TextEditingController();
  final GlobalKey<FormState> keyForm = GlobalKey<FormState>();


  File? _image;

  final ImagePicker _picker = ImagePicker();

  Future<void> _selectImage() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  void _sejarawan() async {
    if (keyForm.currentState!.validate()) {
      final name = nameController.text;
      final birthdate = birthdateController.text;
      final origin = originController.text;
      final sex = _selectedSex;
      final description = descriptionController.text;

      try {
        // Ubah gambar menjadi Uint8List
        Uint8List? imageBytes;
        if (_image != null) {
          imageBytes = await _image!.readAsBytes();
        }

        final response = await apiService.sejarawan(
          name,
          birthdate,
          origin,
          sex,
          description,
          imageBytes,
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ListSejarawan()),
        );

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Add successful for List Sejarawan'),
            backgroundColor: Colors.green,
          ),
        );
      } catch (e) {
        print('Add data Sejarawan failed: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Data failed: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add data Sejarawan", style: GoogleFonts.inriaSans(
          fontWeight: FontWeight.bold
        ),),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: keyForm,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 50,),
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Nama tidak boleh kosong';
                      }
                      return null;
                    },
                    controller: nameController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: Colors.black, width: 30)),
                        hintText: "Name",
                        hintStyle: GoogleFonts.inriaSans(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                ),
                SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Birthdate tidak boleh kosong';
                      }
                      return null;
                    },
                    controller: birthdateController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: Colors.black, width: 30)),
                        hintText: "Birthdate",
                        hintStyle: GoogleFonts.inriaSans(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Origin tidak boleh kosong';
                      }
                      return null;
                    },
                    controller: originController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: Colors.black, width: 30)),
                        hintText: "Origin",
                        hintStyle: GoogleFonts.inriaSans(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
        
                        )),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: DropdownButtonFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Colors.black, width: 30)
                      ),
                      hintText: "Sex",
                      hintStyle: GoogleFonts.inriaSans(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    value: _selectedSex,
                    onChanged: (newValue) {
                      setState(() {
                        _selectedSex = newValue.toString();
                      });
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'Sex tidak boleh kosong';
                      }
                      return null;
                    },
                    items: ["male", "female"].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: GoogleFonts.inriaSans(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Description tidak boleh kosong';
                      }
                      return null;
                    },
                    controller: descriptionController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: Colors.black, width: 30)),
                        hintText: "Description",
                        hintStyle: GoogleFonts.inriaSans(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
        
                        )),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: _selectImage,
                  child: Container(
                    width: 120,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.black,
                    ),
                    child: Center(
                      child: Text(
                        'Upload Image',
                        style: GoogleFonts.inriaSans(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                if (_image != null)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.file(
                      _image!,
                      height: 200,
                    ),
                  ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: _sejarawan,
                  child: Container(
                    width: 300,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.black,
                    ),
                    child: Center(child: Text('Add Data Sejarawan', style: GoogleFonts.inriaSans(
                        fontSize:25,
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                    ),)),
                  ),
                ),
                SizedBox(height: 30,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
