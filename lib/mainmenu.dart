import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobileuts/auth/loginpage.dart';
import 'package:mobileuts/detailbudayapage.dart';
import 'package:mobileuts/galeripage.dart';
import 'package:mobileuts/listsejarawan.dart';
import 'package:mobileuts/userprofilepage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mobileuts/model/api_services.dart';
import 'package:mobileuts/model/model_listbudaya.dart';
import 'package:mobileuts/model/sharedpreferences.dart';
import 'package:http/http.dart' as http;

Future<String?> getUserName() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('user_name');
}

Future<String?> getUserEmail() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('user_email');
}

class ListBudaya extends StatefulWidget {
  final int userId;
  final ApiServices apiService;

  const ListBudaya({Key? key, required this.userId, required this.apiService}) : super(key: key);

  @override
  State<ListBudaya> createState() => _ListBudayaState();
}

class _ListBudayaState extends State<ListBudaya> {
  String? userName;
  String? userEmail;
  List<Result> _budayaList = [];
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _fetchBudaya();
    _loadUserInfo();
    _searchController = TextEditingController();
  }

  void _goToUserProfile() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UserProfilePage(
          userId: widget.userId,
          userName: userName!,
          userEmail: userEmail!,
          apiService: ApiServices(baseUrl: AppConfig.baseUrl),
        ),
      ),
    );

    if (result != null && result['success'] == true) {
      _loadUserInfo();
    }
  }

  Future<void> _loadUserInfo() async {
    try {
      final String? name = await SharedPreferencesHelper.getUserName();
      final String? email = await SharedPreferencesHelper.getUserEmail();
      if (name != null && email != null) {
        setState(() {
          userName = name;
          userEmail = email;
        });
      } else {
        print('Failed to load user info');
      }
    } catch (error) {
      print('Error loading user info: $error');
    }
  }

  Future<void> _fetchBudaya() async {
    try {
      http.Response res = await http.get(
        Uri.parse('${AppConfig.baseUrl}/budaya'),
      );
      if (res.statusCode == 200) {
        setState(() {
          _budayaList = listBudayaFromJson(res.body).result;
        });
      } else {
        throw Exception('Failed to load Data');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }

  void searchBudaya(String query) {
    List<Result> searchBudaya = _budayaList
        .where((berita) =>
            berita.title.toLowerCase().contains(query.toLowerCase()) ||
            berita.content.toLowerCase().contains(query.toLowerCase()))
        .toList();
    setState(() {
      _budayaList = searchBudaya;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Menu",
          style: GoogleFonts.inriaSans(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () {
              _searchController.clear();
              _fetchBudaya();
            },
            icon: Icon(Icons.refresh),
          ),
          PopupMenuButton(itemBuilder: (context)=>[
            PopupMenuItem(onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>ListSejarawan()));
            },child: Text('List Sejarawan')),
            PopupMenuItem(onTap: _goToUserProfile ,child: Text('User Profile')),
            PopupMenuItem(onTap:(){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>GaleriPage()));
            } , child: Text('Galeri')),

            PopupMenuItem(onTap:(){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginPage()));
            },child: Text('Logout'))
          ]),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 30,right: 30),
              child: TextField(
                controller: _searchController,
                onChanged: searchBudaya,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.black, width: 30)),
                    hintText: "Search...",
                    hintStyle: GoogleFonts.inriaSans(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    )),
              ),
            ),
            SizedBox(height: 20,),
            Expanded(
                child: Scrollbar(
              child: Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: ListView.builder(
                    itemCount: _budayaList.length,
                    itemBuilder: (context, index) {
                      Result result = _budayaList[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailBudayaPage(data: result)));
                        },
                        child: Card(
                          child: Column(children: [
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  '${AppConfig.baseStorage}${result.image}',
                                  fit: BoxFit.fill,
                                  width: double.infinity,
                                  height: 200,
                                ),
                              ),
                            ),
                            ListTile(
                              title: Text(
                                result.title,
                                style: GoogleFonts.inriaSans(
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                result.content,
                                maxLines: 2,
                                style: GoogleFonts.inriaSans(
                                    ),
                              ),
                            )
                          ]),
                        ),
                      );
                    }),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
