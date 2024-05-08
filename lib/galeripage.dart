import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:mobileuts/detailgaleripage.dart';
import 'package:mobileuts/model/api_services.dart';
import 'package:mobileuts/model/model_galeri.dart';

class GaleriPage extends StatefulWidget {
  const GaleriPage({super.key});

  @override
  State<GaleriPage> createState() => _GaleriPageState();
}

class _GaleriPageState extends State<GaleriPage> {
  List<Result> listGaleri = [];

  @override
  void initState(){
    super.initState();
    fetchGaleri();
  }

  Future<void> fetchGaleri() async {
    try{
      final response = await http.get(Uri.parse("${AppConfig.baseUrl}/galeri"));
      final data = modelGaleriFromJson(response.body);
      setState(() {
        listGaleri = data.result;
      });
    }catch(e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Galeri Page', style: GoogleFonts.inriaSans(
          fontWeight: FontWeight.bold
        ),),
      ),
      body: GridView.builder(
          itemCount: listGaleri.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemBuilder: (context, index){
            final galeri = listGaleri[index];
            return GestureDetector(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailGaleriPage(data: galeri),
                  ),
                );
              },
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: ClipRRect(
                          child: Image.network(
                            '${AppConfig.baseStorage}${galeri.image}',
                            fit: BoxFit.fill,
                            width: double.infinity,
                          ),
                        ),
                      ),
                      Text(
                        "${galeri.title}",
                        style: GoogleFonts.inriaSans(
                            fontWeight: FontWeight.bold
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
