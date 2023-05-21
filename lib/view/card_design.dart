import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ogrenciden_canli_egitim_uygulamasi/constants/string_detail_constants.dart';
import '../constants/color_constants.dart';

class CardDesign extends StatefulWidget {
  const CardDesign({
    Key? key,
    required this.ogretmenisim,
    required this.dersicerigi,
    required this.dersadi,
    required this.dersid,
    required this.ogretmenid,
  }) : super(key: key);

  final String ogretmenisim;
  final String dersicerigi;
  final String dersadi;
  final String dersid;
  final String ogretmenid;
  @override
  State<CardDesign> createState() => _CardDesignState();
}

class _CardDesignState extends State<CardDesign> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: ColorConstants.instance.hippieGreenLight8x,
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
     
      ),
    );
  }
}
