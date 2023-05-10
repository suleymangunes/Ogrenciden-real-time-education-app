import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ogrenciden_canli_egitim_uygulamasi/pages/sign_in.dart';
import '../constants/string_detail_constants.dart';
import 'package:rive/rive.dart';
import 'new_password_page.dart';

class RegisterCheck extends StatefulWidget {
  const RegisterCheck({super.key});

  @override
  State<RegisterCheck> createState() => _RegisterCheckState();
}

class _RegisterCheckState extends State<RegisterCheck> {
  final _formkey = GlobalKey<FormState>();
  final TextEditingController _controllerMail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  bool _butstate = false;

  @override
  void dispose() {
    _controllerMail.dispose();
    _controllerPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: SizedboxConstans.instance.spaceBottom,
                ),
                    Image.asset("assets/images/ogrenciden_logo_png.png", height: SizedboxConstans.instance.spaceNormal),
                SizedBox(
                  height: SizedboxConstans.instance.spaceNormal,
                ),
                SizedBox(
                  width: SizedboxConstans.instance.textFieldNormal,
                  child: TextFormField(
                    controller: _controllerMail,
                    style: TextStyle(fontSize: StringDetailConstants.instance.textFieldSize),
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.mail_outline_rounded),
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: StringDetailConstants.instance.textFieldSize,
                            vertical: StringDetailConstants.instance.textFieldSize),
                        labelText: "Doğrulama Kodu",
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
          
                  ),
                ),
           
              ],
            ),
          ),
        ),
      ),
    );
  }
}
