import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:mobileuts/addsejarawan.dart';
import 'package:mobileuts/detailsejarawan.dart';
import 'package:mobileuts/editlistsejarahpage.dart';
import 'package:mobileuts/model/api_services.dart';
import 'package:mobileuts/model/model_listsejarawan.dart';

class ListSejarawan extends StatefulWidget {
  const ListSejarawan({Key? key}) : super(key: key);

  @override
  State<ListSejarawan> createState() => _ListSejarawanState();
}

class _ListSejarawanState extends State<ListSejarawan> {
  List<Result> sejarawanList = [];
  List<Result> searchResults = [];

  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchSejarawan();
  }

  Future<void> fetchSejarawan() async {
    try {
      final response =
      await http.get(Uri.parse("${AppConfig.baseUrl}/sejarawan"));
      final data = modelSejarawanFromJson(response.body);
      setState(() {
        sejarawanList = data.result;

      });
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  Future<void> deleteSejarawan(int id) async {
    try {
      final response = await http.delete(
        Uri.parse('${AppConfig.baseUrl}/sejarawan/$id'),
      );
      if (response.statusCode == 200) {
        print('Sejarawan deleted successfully');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Data Berhasil dihapus'),
          backgroundColor: Colors.green,
        ));
        fetchSejarawan();
        // Memuat ulang daftar sejarawan setelah penghapusan berhasil
        fetchSejarawan();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Data gagal dihapus'),
          backgroundColor: Colors.red,
        ));
        print('Failed to delete sejarawan: ${response.body}');
      }
    } catch (e) {
      print('Error deleting sejarawan: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Terjadi kesalahan saat menghapus data'),
        backgroundColor: Colors.red,
      ));
    }
  }


  void searchSejarawan(String query) {
    List<Result> searchSejarawan = sejarawanList
        .where((berita) =>
    berita.name.toLowerCase().contains(query.toLowerCase()) ||
        berita.origin.toLowerCase().contains(query.toLowerCase()))
        .toList();
    setState(() {
      sejarawanList = searchSejarawan;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sejarawan Minang',
          style: GoogleFonts.inriaSans(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () {
              sejarawanList.clear();
            },
            icon: Icon(Icons.refresh),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddSejarawan()));
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: TextField(
                controller: controller,
                onChanged: searchSejarawan,
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
            SizedBox(
              height: 20,
            ),
            Expanded(
                child: Scrollbar(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: ListView.builder(
                        itemCount: sejarawanList.length,
                        itemBuilder: (context, index) {
                          Result result = sejarawanList[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          DetailListSejarawan(data: result)));
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
                                      scale: 4,
                                    ),
                                  ),
                                ),
                                ListTile(
                                  title: Text(
                                    result.name,
                                    style: GoogleFonts.inriaSans(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(
                                    "Tap for more detail...",
                                    style: GoogleFonts.inriaSans(),
                                  ),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => UpdateSejarawan(sejarawan: result,),
                                            ),
                                          );
                                        },
                                        icon: Icon(Icons.edit),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          deleteSejarawan(result.id);
                                        },
                                        icon: Icon(Icons.delete),
                                      ),
                                    ],
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
