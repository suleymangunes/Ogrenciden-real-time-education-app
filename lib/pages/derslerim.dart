import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ogrenciden_canli_egitim_uygulamasi/constants/sizedbox_constants.dart';
import 'package:ogrenciden_canli_egitim_uygulamasi/constants/string_detail_constants.dart';
import 'package:ogrenciden_canli_egitim_uygulamasi/pages/home_page.dart';
import 'package:ogrenciden_canli_egitim_uygulamasi/service/auth_register.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

String token =
    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhcGlrZXkiOiI3Zjk5YTRjNC00NjA2LTQ3MDktYWNjMy1lZTAxOTdjY2Y1OGMiLCJwZXJtaXNzaW9ucyI6WyJhbGxvd19qb2luIl0sImlhdCI6MTY3MjI0ODQwMiwiZXhwIjoxNjc0ODQwNDAyfQ.ft5uORSdTyC-CgMoreKulQPWNs3KrcNjVAJk8JlxdVs";
    
class DerslerimPage extends StatefulWidget {
  const DerslerimPage({
    super.key,
  });

  @override
  State<DerslerimPage> createState() => _DerslerimPageState();
}

class _DerslerimPageState extends State<DerslerimPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: Get.height * 0.07,
          title: Align(
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [    
                SizedBox(
                  width: Get.width * 0.05,
                ),
                Image.asset(
                  "assets/images/ogrenciden_logo_png.png",
                  height: Get.height * 0.05,
                )
              ],
            ),
          )
        ),
    );
  }
}