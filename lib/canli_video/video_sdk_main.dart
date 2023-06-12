import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ogrenciden_canli_egitim_uygulamasi/service/auth_register.dart';
import 'api.dart';
import 'join_screen.dart';
import 'meeting_screen.dart';

class VideoSDKQuickStart extends StatefulWidget {
  const VideoSDKQuickStart({Key? key, required this.dersid, required this.ogretmenid}) : super(key: key);

  final String dersid;
  final String ogretmenid;
  @override
  State<VideoSDKQuickStart> createState() => _VideoSDKQuickStartState();
}

class _VideoSDKQuickStartState extends State<VideoSDKQuickStart> {
  String meetingId = "";
  bool isMeetingActive = false;

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  AuthService authService = AuthService();

  String canliid = '';

  Future<DocumentSnapshot<Map<String, dynamic>>> canliidal() async {
    return await firestore.collection('dersler').doc(widget.dersid).get();
  }

  @override
  void initState() {
    canliidal().then((value) {
      print(value.data()?['canliid']);
      setState(() {
        canliid = value.data()?['canliid'];
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("VideoSDK QuickStart"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: isMeetingActive
            ? MeetingScreen(
                meetingId: canliid,
                token: token,
                leaveMeeting: () {
                  firestore.collection('dersler').doc(widget.dersid).update({'canliid': ''});
                  setState(() => isMeetingActive = false);
                },
              )
            : JoinScreen(
                dersid: widget.dersid,
                ogretmenid: widget.ogretmenid,
                onMeetingIdChanged: (value) => canliid = value,
                onCreateMeetingButtonPressed: () async {
                  print("bu kisim calisiyor");
                  meetingId = await createMeeting();
                  print("ama bu kisim calistmiyor");
                  firestore.collection('dersler').doc(widget.dersid).update({'canliid': meetingId});
                  setState(() => isMeetingActive = true);
                },
                onJoinMeetingButtonPressed: () {
                  canliid == '' ? const Text('Hata') : setState(() => isMeetingActive = true);
                },
              ),
      ),
    );
  }
}
