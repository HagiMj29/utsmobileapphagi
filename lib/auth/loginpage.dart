import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobileuts/auth/registerpage.dart';
import 'package:mobileuts/mainmenu.dart';
import 'package:mobileuts/model/api_services.dart';
import 'package:mobileuts/model/sharedpreferences.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final ApiServices apiServices = ApiServices(baseUrl: AppConfig.baseUrl);
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> keyForm = GlobalKey<FormState>();

  void _login() async {
    if (keyForm.currentState!.validate()) {
      final email = emailController.text;
      final password = passwordController.text;

      try {
        final response = await apiServices.login(email, password);
        final user = response['user'] as Map<String, dynamic>;
        final userId = user['id'];

        await SharedPreferencesHelper.saveUserProfile(user);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => ListBudaya(
                    userId: userId,
                    apiService:
                        ApiServices(baseUrl: AppConfig.baseUrl),
                  )),
        );

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Login successful'),
            backgroundColor: Colors.green,
          ),
        );

        print('Login successful: $response');
      } catch (e) {
        print('Login failed: $e');

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Login failed: $e'),
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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 150,),
              Text(
                "Login",
                style: GoogleFonts.inriaSans(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Image.asset(
                'images/logo.png',
                scale: 35,
              ),
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
                onTap: _login,
                child: Container(
                  width: 100,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.black,
                  ),
                  child: Center(child: Text('Login', style: GoogleFonts.inriaSans(
                    fontSize:25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                  ),)),
                ),
              ),
              SizedBox(height: 30,),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>RegisterPage()));
                },
                child:Text("Register your Account in here..", style: GoogleFonts.inriaSans(
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
