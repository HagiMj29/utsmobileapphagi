import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobileuts/model/api_services.dart';
import 'package:mobileuts/model/model_listbudaya.dart';


class DetailBudayaPage extends StatelessWidget {
  final Result? data;
  const DetailBudayaPage({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Detail Data Budaya",
          style: GoogleFonts.inriaSans(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: data !=null && data!.image.isNotEmpty ? Image.network('${AppConfig.baseStorage}${data!.image}',
                fit: BoxFit.fill,
                width: double.infinity,
                height: 200,
                ) : Container()
              ),
              SizedBox(height: 10,),
              Text(
                data?.title ?? 'No Title',
                style: GoogleFonts.inriaSans(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10,),
              Text(
                data?.content ?? 'No Content',
                style: GoogleFonts.inriaSans(
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
