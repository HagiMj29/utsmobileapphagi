import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobileuts/model/api_services.dart';

import 'model/model_galeri.dart';

class DetailGaleriPage extends StatefulWidget {
  final Result? data;
  const DetailGaleriPage({super.key, this.data});

  @override
  State<DetailGaleriPage> createState() => _DetailGaleriPageState();
}

class _DetailGaleriPageState extends State<DetailGaleriPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Galeri',style: GoogleFonts.inriaSans(
          fontWeight: FontWeight.bold
        ),),

      ),
      body: Center(
        child: widget.data != null && widget.data!.image.isNotEmpty
            ? Image.network(
          '${AppConfig.baseStorage}${widget.data!.image}',
          fit: BoxFit.contain,
        )
            : Container(), // Widget kosong jika data tidak tersedia atau gambar tidak ada
      ),
    );
  }
}
