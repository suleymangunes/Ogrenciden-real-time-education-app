import 'package:flutter/material.dart';
import 'package:ogrenciden_canli_egitim_uygulamasi/constants/color_constants.dart';
import 'package:ogrenciden_canli_egitim_uygulamasi/intro_screens/intro_screen_1.dart';

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
    return Text("Deneme");
  }
}
