import 'package:flutter/material.dart';
import 'package:ogrenciden_canli_egitim_uygulamasi/service/auth_register.dart';

class JoinScreen extends StatefulWidget {
  final void Function() onCreateMeetingButtonPressed;
  final void Function() onJoinMeetingButtonPressed;
  final void Function(String) onMeetingIdChanged;
  final String ogretmenid;
  final String dersid;

  const JoinScreen({
    Key? key,
    required this.onCreateMeetingButtonPressed,
    required this.onJoinMeetingButtonPressed,
    required this.onMeetingIdChanged,
    required this.ogretmenid,
    required this.dersid,
  }) : super(key: key);

  @override
  State<JoinScreen> createState() => _JoinScreenState();
}

class _JoinScreenState extends State<JoinScreen> {
  AuthService authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          widget.ogretmenid == authService.infouser()
              ? ElevatedButton(onPressed: widget.onCreateMeetingButtonPressed, child: const Text("Create Meeting"))
              : const SizedBox.shrink(),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
