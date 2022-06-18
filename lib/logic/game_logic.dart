import 'dart:async';

import 'package:flutter/material.dart';

class GameLogic extends ChangeNotifier {
  int selected = 0;
  int question = 1;
  bool answered = false;

  stopAnim(AnimationController control) {
    if (control.status.name == 'forward') {
          control.stop();
    }
    notifyListeners();
  }

  choose(index, PageController controller) async {
    selected = index;
    await Future.delayed(const Duration(milliseconds: 700), () {
      answered = true;
      notifyListeners();
    });
    await Future.delayed(const Duration(milliseconds: 2500), () {
      answered = false;
      controller.nextPage(
          duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
      notifyListeners();
    });
  }

}
