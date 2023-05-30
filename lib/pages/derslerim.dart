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

Future<String> createMeeting() async {
  final http.Response httpResponse = await http.post(
    Uri.parse("https://api.videosdk.live/v2/rooms"),
    headers: {'Authorization': token},
  );

  return json.decode(httpResponse.body)['roomId'];
}
class DerslerimPage extends StatefulWidget {
  const DerslerimPage({
    super.key,
  });

  @override
  State<DerslerimPage> createState() => _DerslerimPageState();
}
class _DerslerimPageState extends State<DerslerimPage> {
  List alinandersler = [];
  static List listem = [];
  List listem2 = [];
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
                ElevatedButton(
                  style: ButtonStyle(
                      fixedSize: MaterialStateProperty.all(Size(Get.width * 0.7, Get.height * 0.05)),
                      elevation: MaterialStateProperty.all(3),
                      backgroundColor: MaterialStateProperty.all(Colors.white),
                      shape:
                          MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)))),
                  onPressed: (() {
                    print(alinandersler);
                    bak();
                  }),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.search,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: Get.width * 0.05,
                ),
                Image.asset(
                  "assets/images/ogrenciden_logo_png.png",
                  height: Get.height * 0.05,
                )
              ],
            ),
          )),
      body: FutureBuilder(
        future: dersler,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            listem = [];
            for (var element in snapshot.data.docs) {
              listem.add(element.data()['ders']);
            }
            print(listem);
          }
          return FutureBuilder(
            future: _firestore.collection('dersler').get(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return const Text('error');
                case ConnectionState.waiting:
                  return const Center(child: CircularProgressIndicator());
                case ConnectionState.active:
                  return const Center(child: CircularProgressIndicator());

                case ConnectionState.done:
                  if (snapshot.hasData) {
                    listem2 = [];
                    int a = 0;
                    for (var element in snapshot.data.docs) {
                      if (listem.contains(element.data()['dersid'])) {
                        listem2.add(element.data());
                      }
                    }
                    print(listem2);
                    print('data var');
                    return ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: listem2.length,
                      // itemCount: 0,
                      itemBuilder: ((context, index) {
                        return SelectedCardDesign(
                          dersadi: listem2[index]['dersadi'],
                          ogretmenisim: listem2[index]['ogretmenisim'],
                          dersid: listem2[index]['dersid'],
                          ogretmenid: listem2[index]['ogretmenid'],
                        );
                      }),
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
              }
            },
          );
        },
      ),
    );
  }
}