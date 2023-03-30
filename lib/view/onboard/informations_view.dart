import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:numberpicker/numberpicker.dart';

import '../../core/model/user_model.dart';
import '../../product/base/state/base_stepper.dart';
import '../../product/cache/user_manager.dart';
import '../../product/enums/edge_insets.dart';

class InformationView extends StatefulWidget {
  const InformationView({super.key});

  @override
  State<InformationView> createState() => _InformationViewState();
}

class _InformationViewState extends StepperState<InformationView> {
  _InformationViewState() : super(manager: UserManager.getInstance());

  String? name;
  int _goal = 70;
  double _height = 1.70;
  final _lottiePath = 'assets/lottie/hello.json';

  Future<void> _onStepContinue() async {
    if (name == null) {
      return;
    }
    if (name!.replaceAll(' ', '').isEmpty) {
      return;
    }
    if (currentStep == steps.length - 1) {
      await saveAndToHome(User(name: name!, goal: _goal, height: _height));
    }
    setState(incStep);
  }

  void _onCancel() {
    setState(decStep);
  }

  void _onHeightChanged(double height) {
    setState(() {
      _height = height;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Lottie.asset(_lottiePath),
            Expanded(
              child: Stepper(
                controlsBuilder: (context, details) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: _stepButtons,
                  );
                },
                onStepContinue: _onStepContinue,
                onStepCancel: isFirstStep ? null : _onCancel,
                currentStep: super.currentStep,
                steps: steps,
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> get _stepButtons {
    return [
      OutlinedButton(onPressed: _onStepContinue, child: Text(continueText)),
      if (!isFirstStep)
        Padding(
          padding: EdgeInsetsValues.listTileContentPadding.value(),
          child: OutlinedButton(onPressed: _onCancel, child: Text(backText)),
        ),
    ];
  }

  List<Step> get steps {
    const goalText = 'Goal';
    const heightText = 'Height';

    return [
      Step(
        isActive: super.currentStep >= 0,
        title: Text(nameText),
        content: _nameField,
      ),
      Step(
        isActive: super.currentStep >= 1,
        title: const Text(goalText),
        content: _goalPicker(),
      ),
      Step(
        isActive: super.currentStep >= 2,
        title: const Text(heightText),
        content: doublePicker(
          minValue: 1,
          maxValue: 3,
          onChanged: _onHeightChanged,
          value: _height,
        ),
      ),
    ];
  }

  Widget get _nameField {
    void onNameChanged(String value) {
      name = value;
    }

    return Padding(
      padding: EdgeInsetsValues.recordNotePadding.value(),
      child: noteField(
        context: context,
        onChanged: onNameChanged,
        label: nameText,
      ),
    );
  }

  NumberPicker _goalPicker() {
    return NumberPicker(
      axis: Axis.horizontal,
      minValue: 0,
      maxValue: 600,
      value: _goal,
      onChanged: (e) {
        setState(() {
          _goal = e;
        });
      },
    );
  }
}
