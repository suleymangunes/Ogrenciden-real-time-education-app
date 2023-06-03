import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ogrenciden_canli_egitim_uygulamasi/canli_video/video_sdk_main.dart';
import 'package:ogrenciden_canli_egitim_uygulamasi/constants/color_constants.dart';
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
  AuthService authService = AuthService();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Future? dersler;
  derslerial() async {
    return await firestore.collection('Person').doc(authService.infouser()).collection('alinacakdersler').get();
  }

  @override
  void initState() {
    authService.derslerimiGoster().then((value) {
      alinandersler = value.docs;
    });
    print(alinandersler);
    dersler = derslerial();
    super.initState();
  }

  void bak() {
    _firestore.collection('Person').doc(authService.infouser()).collection('alinacakdersler').get().then((value) {
      print(value.docs);
    });
  }

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
                      Padding(
                        padding: EdgeInsets.only(left: Get.width * 0.01),
                        child: const Text(
                          "Search something...",
                          style: TextStyle(color: Colors.grey),
                        ),
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
            print('******************');
            print(snapshot.data.docs[0].data()['ders']);
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

                    print('*************');
                    print(snapshot.data.docs[0].data());
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
class SelectedCardDesign extends StatefulWidget {
  const SelectedCardDesign(
      {super.key, required this.dersadi, required this.ogretmenisim, required this.dersid, required this.ogretmenid});

  final String dersadi;
  final String ogretmenisim;
  final String dersid;
  final String ogretmenid;
  @override
  State<SelectedCardDesign> createState() => _SelectedCardDesignState();
}

class _SelectedCardDesignState extends State<SelectedCardDesign> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  AuthService authService = AuthService();
  @override
  void initState() {
    super.initState();
    print('Zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz');
    print(widget.ogretmenid);
    print(widget.dersid);
    print('Zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz');
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: ColorConstants.instance.hippieGreenLight8x,
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
        child: ListTile(
          title: Row(
            children: [
              SizedBox(
                width: Get.width * 0.75,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.ogretmenisim,
                      style: TextStyle(
                        fontWeight: StringDetailConstants.instance.textWeightBold,
                        fontSize: StringDetailConstants.instance.buttonBigSize,
                      ),
                    ),
                    SizedBox(
                      height: SizedboxConstans.instance.spaceSmall / 1.2,
                    ),
                    Text(
                      widget.dersadi,
                      style: TextStyle(
                        fontWeight: StringDetailConstants.instance.textWeightSemiBold,
                        fontSize: StringDetailConstants.instance.textFieldSize,
                      ),
                    ),
                    SizedBox(
                      height: SizedboxConstans.instance.spaceSmall / 3,
                    ),
                    Text(
                      "10.08.2022   17:30 - 18.30",
                      style: TextStyle(
                        fontWeight: StringDetailConstants.instance.titleWeight,
                        fontSize: StringDetailConstants.instance.textFieldSize / 1.1,
                      ),
                    ),
                    SizedBox(
                      height: SizedboxConstans.instance.spaceSmall / 2,
                    ),
                    Row(
                      children: [
                        ElevatedButton(
                          style: ButtonStyle(
                              elevation: MaterialStateProperty.all(3),
                              backgroundColor: MaterialStateProperty.all(ColorConstants.instance.hippieGreen),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)))),
                          onPressed: (() {
                            Get.to(VideoSDKQuickStart(
                              dersid: widget.dersid,
                              ogretmenid: widget.ogretmenid,
                            ));
                             var meetid = createMeeting();
                             print(meetid.then((value) {
                               print(value);
                             }));
                             Get.to(const CanliYayin());
                          }),
                          child: Padding(
                            padding: const EdgeInsets.all(2),
                            child: Text(
                              "Derse Katıl",
                              style: TextStyle(fontSize: Get.width * 0.04, letterSpacing: 2),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: Get.width * 0.03,
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                              elevation: MaterialStateProperty.all(3),
                              backgroundColor: MaterialStateProperty.all(ColorConstants.instance.crimson),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)))),
                          onPressed: (() {
                            .onError((error, stackTrace) {
                              print('erro oldu');
                            });
                          }),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
