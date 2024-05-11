import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'model/model_listsejarawan.dart';

class DetailListSejarawan extends StatelessWidget {
  final Result? data;
  const DetailListSejarawan({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Detail Data Sejarawan",
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
                  child: data !=null && data!.image.isNotEmpty ? Image.network('http://192.168.1.8:8000/storage/${data!.image}',
                    fit: BoxFit.fill,
                    width: double.infinity,
                  ) : Container()
              ),
              SizedBox(height: 10,),
              Text(
                data?.name ?? 'No Name',
                style: GoogleFonts.inriaSans(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5,),
              Row(
                children: [
                  Text(
                   "Lahir :",
                    style: GoogleFonts.inriaSans(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 2,),
                  Text(
                    data?.birthdate ?? 'No birthdate',
                    style: GoogleFonts.inriaSans(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5,),
              Row(
                children: [
                  Text(
                    "Asal :",
                    style: GoogleFonts.inriaSans(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 2,),
                  Text(
                    data?.origin ?? 'No origin',
                    style: GoogleFonts.inriaSans(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5,),
              Row(
                children: [
                  Text(
                    "Jenis Kelamin :",
                    style: GoogleFonts.inriaSans(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 2,),
                  Text(
                    data?.sex == Sex.MALE ? "Laki-laki" : "Perempuan",
                    style: GoogleFonts.inriaSans(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 20,),
              Text(
                "Deskripsi :",
                style: GoogleFonts.inriaSans(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5,),
              Text(
                data?.description ?? 'No description',
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


