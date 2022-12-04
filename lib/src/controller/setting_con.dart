import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class Setting extends ControllerMVC{
static final Model model = Model();
}

class Model{

  final height = 60.0;
  final height2 = -20.0;

  ScrollController scrollController = ScrollController();
  animateToIndex(i) => scrollController.animateTo(i == 0 ? height2* i : height * i, duration: Duration(seconds: 1), curve: Curves.fastOutSlowIn);

}