import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../core/model/record_model.dart';
import '../product/base/state/base_stepper.dart';
import '../product/cache/record_manager.dart';
import '../product/components/lottie_button.dart';
import '../product/enums/edge_insets.dart';
import '../product/extension/context_extension.dart';
import '../product/extension/duration.dart';

class AddRecordView extends StatefulWidget {
  const AddRecordView({super.key});
  @override
  State<AddRecordView> createState() => _AddRecordViewState();
}

class _AddRecordViewState extends StepperState<AddRecordView> {
  _AddRecordViewState() : super(manager: RecordManager.getInstance());

  final ImagePicker _imagePicker = ImagePicker();
  double _weight = RecordManager.getInstance().recordList.isNotEmpty
      ? RecordManager.getInstance().recordList.last.weight
      : 70;
  DateTime _date = DateTime.now();
  String? _image;
  String? _note;

  void _onStepContinue() {
    setState(incStep);
  }

  void _onStepCancel() {
    setState(decStep);
  }

  Future<void> _saveRecord() async {
    await saveAndToHome(
      Record(date: _date, weight: _weight, image: _image, note: _note),
    );
  }

  bool get isLastStep => currentStep == _steps.length - 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stepper(
          controlsBuilder: (context, details) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _stepButtons,
            );
          },
          currentStep: currentStep,
          onStepContinue: _onStepContinue,
          onStepCancel: isFirstStep ? null : _onStepCancel,
          steps: _steps,
        ),
      ),
    );
  }

  List<Widget> get _stepButtons {
    const continueText = 'Continue';
    const saveText = 'Save';
    const backText = 'Back';
    return [
      OutlinedButton(
        onPressed: isLastStep ? _saveRecord : _onStepContinue,
        child: isLastStep ? const Text(saveText) : const Text(continueText),
      ),
      if (!isFirstStep)
        Padding(
          padding: EdgeInsetsValues.listTileContentPadding.value(),
          child: OutlinedButton(
            onPressed: _onStepCancel,
            child: const Text(backText),
          ),
        ),
    ];
  }

  List<Step> get _steps {
    const weightText = 'Weight';
    const dateText = 'Date';
    const noteText = 'Note';
    const imageText = 'Image';
    const optinalText = 'optional';
    void onWeightChanged(double weight) {
      setState(() {
        _weight = weight;
      });
    }

    return [
      Step(
        isActive: currentStep >= 0,
        state: currentStep > 0 ? StepState.complete : StepState.indexed,
        title: const Text(weightText),
        content: doublePicker(
          minValue: 0,
          maxValue: 600,
          onChanged: onWeightChanged,
          value: _weight,
        ),
      ),
      Step(
        isActive: currentStep >= 1,
        state: currentStep > 1 ? StepState.complete : StepState.indexed,
        title: const Text(dateText),
        content: Row(children: _datePicker(context)),
      ),
      Step(
        isActive: currentStep >= 2,
        state: currentStep > 2 ? StepState.complete : StepState.indexed,
        subtitle: const Text(optinalText),
        title: const Text(noteText),
        content: _noteField(context),
      ),
      Step(
        isActive: currentStep >= 3,
        state: currentStep > 3 ? StepState.complete : StepState.indexed,
        subtitle: const Text(optinalText),
        title: const Text(imageText),
        content: Row(children: _imagePickRow(context)),
      ),
    ];
  }

  TextField _noteField(BuildContext context) {
    void onChanged(String value) {
      _note = value;
    }

    const noteText = 'Note';
    return noteField(context: context, onChanged: onChanged, label: noteText);
  }

  List<Widget> _imagePickRow(BuildContext context) {
    Future<void> onTap() async {
      _image = await _imagePicker
          .pickImage(
            source: ImageSource.gallery,
            imageQuality: 100,
            maxHeight: 2048,
            maxWidth: 2048,
          )
          .then((value) => value?.path);
      setState(() {});
    }

    final Widget image = _image != null
        ? SizedBox(
            width: context.dynamicWidth(context, 0.25),
            height: context.dynamicHeight(context, 0.25),
            child: Image.file(File(_image!)),
          )
        : const SizedBox();

    const lottiePath = 'assets/lottie/image-icon.json';
    return [
      LottieButton(
        duration: DurationExtension.extraLowDuration,
        onTap: onTap,
        lottiePath: lottiePath,
        height: .05,
      ),
      image
    ];
  }

  List<Widget> _datePicker(BuildContext context) {
    Future<void> onTap() async {
      _date = await pickDate(context);
      setState(() {});
    }

    const lottiePath = 'assets/lottie/calendar.json';
    return [
      LottieButton(
        duration: DurationExtension.extraLowDuration,
        onTap: onTap,
        lottiePath: lottiePath,
        height: .1,
      ),
      Text(DateFormat('yyy MMM d').format(_date))
    ];
  }

  Future<DateTime> pickDate(BuildContext context) async {
    return await showDatePicker(
          context: context,
          firstDate: DateTime.now().subtract(const Duration(days: 30)),
          initialDate: DateTime.now(),
          lastDate: DateTime.now(),
        ) ??
        DateTime.now();
  }
}
