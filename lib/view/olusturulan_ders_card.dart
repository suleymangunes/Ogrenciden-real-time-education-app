import 'package:flutter/material.dart';
import 'package:ogrenciden_canli_egitim_uygulamasi/service/auth_register.dart';
import '../constants/string_detail_constants.dart';


class _OlusturulanDersCardState extends State<OlusturulanDersCard> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  AuthService authService = AuthService();
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: Get.width * 0.55,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.dersadi,
                      style: TextStyle(
                        fontWeight: StringDetailConstants.instance.textWeightSemiBold,
                        fontSize: StringDetailConstants.instance.textFieldSize,
                      ),
                    ),
                    SizedBox(
                      height: SizedboxConstans.instance.spaceSmall / 2,
                    ),
                    Text(widget.dersicerigi)
                  ],
                ),
              ),
              Column(
                children: [
                  Image.asset(
                    "assets/images/insan.png",
                    fit: BoxFit.cover,
                    height: 80,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
