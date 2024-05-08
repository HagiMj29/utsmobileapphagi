import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobileuts/model/api_services.dart';
import 'package:mobileuts/model/sharedpreferences.dart';


class UserProfilePage extends StatefulWidget {
  final int userId;
  final String userName;
  final String userEmail;
  final ApiServices apiService;

  const UserProfilePage({Key? key, required this.userId, required this.userName, required this.userEmail, required this.apiService,}) : super(key: key);

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {

  late TextEditingController _nameController;
  late TextEditingController _emailController;


  @override
  void initState(){
    _nameController = TextEditingController(text: widget.userName);
    _emailController = TextEditingController(text: widget.userEmail);
    super.initState();
  }

  void _updateUserProfile() async {
    final updatedName = _nameController.text;
    final updatedEmail = _emailController.text;
    try {
      final response = await widget.apiService.updateUser(widget.userId, updatedName, updatedEmail);
      final user = response['user'] as Map<String, dynamic>;
      SharedPreferencesHelper.saveUserProfile(user);
      Navigator.pop(context, {'success': true, 'updatedName': updatedName, 'updatedEmail': updatedEmail});
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Update Data Profile Berhasil",),
        backgroundColor: Colors.green,));
    } catch (error) {
      // Tampilkan pesan gagal
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile', style: GoogleFonts.inriaSans(
          fontWeight: FontWeight.bold
        ),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name', labelStyle:GoogleFonts.inriaSans(fontWeight: FontWeight.bold) ),
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email',labelStyle:GoogleFonts.inriaSans(fontWeight: FontWeight.bold)),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _updateUserProfile,
              child: Text('Edit',style: GoogleFonts.inriaSans(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.black
              ),),
            )
          ],
        ),
      ),

    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }
}
