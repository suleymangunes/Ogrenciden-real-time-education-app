import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ogrenciden_canli_egitim_uygulamasi/pages/home_page.dart';
import 'package:ogrenciden_canli_egitim_uygulamasi/service/auth_register.dart';
import 'package:ogrenciden_canli_egitim_uygulamasi/view/back_button.dart';

import '../constants/color_constants.dart';
import '../constants/sizedbox_constants.dart';
import '../constants/string_detail_constants.dart';

class EnterLesson extends StatefulWidget {
  const EnterLesson({
    super.key,
    required this.ogretmenadi,
    required this.dersisim,
    required this.dersicerigi,
    required this.dersid,
    required this.ogretmenid,
  });

  final String ogretmenadi;
  final String dersisim;
  final String dersicerigi;
  final String dersid;
  final String ogretmenid;

  @override
  State<EnterLesson> createState() => _EnterLessonState();
}

class _EnterLessonState extends State<EnterLesson> {
  String? ogretmenid;
  AuthService authService = AuthService();
  var alinandersler;

  Future<QuerySnapshot<Map<String, dynamic>>> derslerilistele() async {
    return await _firestore.collection('Person').doc(ogretmenid).collection('alinacakdersler').get();
  }

  List listem = [];
  bool katildimi = false;

  @override
  void initState() {
    ogretmenid = authService.infouser();
    derslerilistele().then((value) {
      alinandersler = value.docs;
      print(alinandersler);
      for (var element in alinandersler) {
        listem.add(element.data()['ders']);
        print(element.data()['ders']);
        print('/**************');
      }
    });
    // listeyeekle();
    setState(() {
      listem.contains(widget.dersid);
    });
    super.initState();
    print('------------------------');
    print(ogretmenid);
    print('------------------------');
  }

  // void listeyeekle() {
  //   for (var element in alinandersler.docs) {
  //     listem.add(element.data()['ders']);
  //   }
  // }

  TimeOfDay _time = const TimeOfDay(hour: 7, minute: 15);

  void _selectTime() async {
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: _time,
    );
    if (newTime != null) {
      setState(() {
        _time = newTime;
      });
    }
  }

  DateTime _date = DateTime(2020, 11, 17);

  void _selectDate() async {
    final DateTime? newDate = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2017, 1),
      lastDate: DateTime(2022, 7),
      helpText: 'Select a date',
    );
    if (newDate != null) {
      setState(() {
        _date = newDate;
      });
    }
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void anasayfadon() {
    Get.offAll(const HomePage());
  }

  }
}
