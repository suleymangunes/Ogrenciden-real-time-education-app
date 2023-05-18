import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ogrenciden_canli_egitim_uygulamasi/constants/color_constants.dart';
import 'package:ogrenciden_canli_egitim_uygulamasi/pages/arama_page.dart';
import 'package:ogrenciden_canli_egitim_uygulamasi/pages/ders_ekle.dart';

import '../view/card_design.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<QuerySnapshot<Map<String, dynamic>>> verilerial() async {
    return await _firestore.collection('dersler').where('dersalindimi', isEqualTo: false).get();
  }

  Future? futureveri;

  @override
  void initState() {
    super.initState();
    futureveri = verilerial();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorConstants.instance.hippieGreenDark,
        onPressed: (() {
          Get.to(const DersEkle());
        }),
        child: Icon(
          Icons.add,
          size: Get.width * 0.07,
        ),
      ),
    );
  }
}
