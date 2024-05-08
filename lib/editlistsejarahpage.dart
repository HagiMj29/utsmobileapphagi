import 'package:flutter/material.dart';
import 'package:mobileuts/listsejarawan.dart';
import 'package:mobileuts/model/api_services.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';
import 'package:google_fonts/google_fonts.dart';

import 'model/model_listsejarawan.dart';

class UpdateSejarawan extends StatefulWidget {
  final Result sejarawan;

  const UpdateSejarawan({Key? key, required this.sejarawan}) : super(key: key);

  @override
  State<UpdateSejarawan> createState() => _UpdateSejarawanState();
}

class _UpdateSejarawanState extends State<UpdateSejarawan> {
  final ApiServices apiService = ApiServices(baseUrl: AppConfig.baseUrl);
  late TextEditingController nameController ;
  late TextEditingController birthdateController;
  late TextEditingController originController;
  String _selectedSex = "male";
  late TextEditingController descriptionController;
  String? imagePath;
  File? _image;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.sejarawan.name);
    birthdateController = TextEditingController(text: widget.sejarawan.birthdate);
    originController = TextEditingController(text: widget.sejarawan.origin);
    descriptionController = TextEditingController(text: widget.sejarawan.description);
    imagePath = widget.sejarawan.image;
  }


  final ImagePicker _picker = ImagePicker();

  Future<void> _selectImage() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        // Set imagePath dari path file yang baru dipilih
        imagePath = pickedFile.path;
      });
    }
  }

  void _updateSejarawan() async {
    final name = nameController.text;
    final birthdate = birthdateController.text;
    final origin = originController.text;
    final description = descriptionController.text;

    // Periksa apakah semua bidang terisi
    if (name.isEmpty || birthdate.isEmpty || origin.isEmpty || description.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please fill all required fields'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    try {
      // Periksa apakah ada gambar yang dipilih
      Uint8List? imageBytes;
      if (_image != null) {
        imageBytes = await _image!.readAsBytes();
      }

      final response = await apiService.updateSejarawan(
        widget.sejarawan.id,
        name,
        birthdate,
        origin,
        _selectedSex.toLowerCase(),
        description,
        imageBytes,
      );

      if (response.containsKey('sejarawan')) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Update successful for List Sejarawan'),
            backgroundColor: Colors.green,
          ),
        );

        // Redirect ke halaman list sejarawan setelah update berhasil
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ListSejarawan()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Update failed: ${response['error']}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      print('Error updating Sejarawan data: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Update failed: $e'),
          backgroundColor: Colors.red,
        ),
      );
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
        child:  Center(
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
                  child: DropdownButtonFormField<String>(
                    value: _selectedSex,
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedSex = newValue!;
                      });
                    },
                    items: <String>['male', 'female'].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
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
                SizedBox(height: 20,),
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
                  )
                else
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.network(
                    '${AppConfig.baseStorage}${widget.sejarawan.image}',
                height: 200,
                    ),
                  ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: _updateSejarawan,
                  child: Container(
                    width: 300,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.black,
                    ),
                    child: Center(child: Text('Update Data Sejarawan', style: GoogleFonts.inriaSans(
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
    );
  }
}
