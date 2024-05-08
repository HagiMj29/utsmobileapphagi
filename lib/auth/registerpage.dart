import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobileuts/auth/loginpage.dart';
import 'package:mobileuts/model/api_services.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final ApiServices apiService = ApiServices(baseUrl: AppConfig.baseUrl);
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> keyForm = GlobalKey<FormState>();

  void _register() async {

    if (keyForm.currentState!.validate()) {
      final name = nameController.text;
      final email = emailController.text;
      final password = passwordController.text;

      try {
        final response = await apiService.register(name, email, password);
        final user = response['user'];
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginPage()));

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                'Registration successful for $name with email $email'),
            backgroundColor: Colors.green,
          ),
        );
      } catch (e) {
        print('Registration failed: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Registration failed: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: keyForm,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 150,),
              Text("Register",style: GoogleFonts.inriaSans(
                fontWeight: FontWeight.bold,
                fontSize:40
              ),),
              SizedBox(height: 20,),
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
                      return 'Email tidak boleh kosong';
                    }
                    return null;
                  },
                  controller: emailController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Colors.black, width: 30)),
                      hintText: "Email",
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
                      return 'Password tidak boleh kosong';
                    }
                    return null;
                  },
                  controller: passwordController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Colors.black, width: 30)),
                      hintText: "Password",
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
                onTap: _register,
                child: Container(
                  width: 120,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.black,
                  ),
                  child: Center(child: Text('Register', style: GoogleFonts.inriaSans(
                      fontSize:25,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                  ),)),
                ),
              ),
              SizedBox(height: 30,),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
                },
                child:Text("Already have account?. click here..", style: GoogleFonts.inriaSans(
                    fontWeight: FontWeight.bold,
                    fontSize:15
                ),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
