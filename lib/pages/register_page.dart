import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:ogrenciden_canli_egitim_uygulamasi/alerts/alert_succes.dart';
// import 'package:ogrenciden_canli_egitim_uygulamasi/constants/color_constants.dart';
// import 'package:ogrenciden_canli_egitim_uygulamasi/constants/sizedbox_constants.dart';
// import 'package:ogrenciden_canli_egitim_uygulamasi/alerts/alert_error.dart';
// import 'package:ogrenciden_canli_egitim_uygulamasi/pages/sign_in.dart';
// import 'package:ogrenciden_canli_egitim_uygulamasi/service/auth_register.dart';
// import 'package:rive/rive.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _controllerMail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerPasswordAgain = TextEditingController();

  final _formkey = GlobalKey<FormState>();
  final bool _butState = false;

  AuthService authService = AuthService();

  @override
  void dispose() {
    _controllerMail.dispose();
    _controllerName.dispose();
    _controllerPassword.dispose();
    _controllerPasswordAgain.dispose();
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
                  height: Get.height * 0.05,
                ),
                Image.asset("assets/images/ogrenciden_logo_png.png", height: SizedboxConstans.instance.spaceNormal),
                SizedBox(
                  height: Get.height * 0.1,
                ),
                SizedBox(
                  width: Get.width * 0.8,
                  child: TextFormField(
                    controller: _controllerName,
                    style: TextStyle(fontSize: Get.width * 0.04),
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.person),
                        contentPadding: EdgeInsets.symmetric(horizontal: Get.width * 0.04, vertical: Get.width * 0.04),
                        labelText: "İsim Soyisim",
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "İsim alanı boş bırakılamaz.";
                      }
                      return null;
                    },
                  ),
                ),
}
