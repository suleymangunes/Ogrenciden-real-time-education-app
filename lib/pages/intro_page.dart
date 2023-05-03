import 'package:flutter/material.dart';
import 'package:ogrenciden_canli_egitim_uygulamasi/constants/color_constants.dart';
import 'package:ogrenciden_canli_egitim_uygulamasi/intro_screens/intro_screen_1.dart';
import 'package:ogrenciden_canli_egitim_uygulamasi/intro_screens/intro_screen_2.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PageViewDesign extends StatefulWidget {
  const PageViewDesign({super.key});

  @override
  State<PageViewDesign> createState() => _PageViewDesignState();
}

class _PageViewDesignState extends State<PageViewDesign> {
  final PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            physics: const BouncingScrollPhysics(),
            controller: _controller,
            children: const <Widget>[IntroScreen(), IntroScreen2(), IntroScreen3()],
          ),
          Container(
              alignment: const Alignment(0, 0.65),
             )
        ],
      ),
    );
  }
}