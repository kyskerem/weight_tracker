import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:page_transition/page_transition.dart';

import '../../../core/model/record_model.dart';
import '../../../core/model/user_model.dart';
import '../../../view/home_view.dart';
import '../../cache/local_manager.dart';

abstract class StepperState<T extends StatefulWidget> extends State<T> {
  StepperState({required ILocalManager<HiveObject> manager}) {
    assert(manager.runtimeType != Record || manager.runtimeType != User);
    _manager = manager;
  }
  late ILocalManager<HiveObject> _manager;
  int currentStep = 0;
  String nameText = 'Name';
  String continueText = 'Continue';
  String backText = 'Back';

  void incStep() {
    currentStep++;
  }

  void decStep() {
    if (currentStep == 0) {
      return;
    }
    currentStep--;
  }

  bool get isFirstStep => currentStep == 0;

  Future<void> _toHomeView() {
    return Navigator.pushAndRemoveUntil(
      context,
      PageTransition(child: HomeView(), type: PageTransitionType.fade),
      (route) => false,
    );
  }

  Future<void> saveAndToHome(HiveObject item) async {
    assert(item.runtimeType != Record || item.runtimeType != User);
    currentStep = 0;
    await _manager.addItem(item).whenComplete(_toHomeView);
  }

  DecimalNumberPicker doublePicker({
    required double value,
    required void Function(double) onChanged,
    required int minValue,
    required int maxValue,
  }) {
    return DecimalNumberPicker(
      decimalPlaces: 2,
      minValue: minValue,
      maxValue: maxValue,
      value: value,
      onChanged: onChanged,
    );
  }

  TextField noteField({
    required BuildContext context,
    required void Function(String) onChanged,
    required String label,
  }) {
    return TextField(
      onTapOutside: (e) => FocusScope.of(context).unfocus(),
      onChanged: onChanged,
      decoration: InputDecoration(
        label: Text(label),
      ),
    );
  }
}
