import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../extension/context_extension.dart';

class LottieButton extends StatefulWidget {
  const LottieButton({
    super.key,
    required this.duration,
    required this.lottiePath,
    required this.onTap,
    required this.height,
  });
  final String lottiePath;
  final double height;
  final Duration duration;
  final Future<void> Function() onTap;

  @override
  State<LottieButton> createState() => _LottieButtonState();
}

class _LottieButtonState extends State<LottieButton>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reset();
      }
      return;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      overlayColor: const MaterialStatePropertyAll(Colors.transparent),
      onTap: () async {
        await widget.onTap().whenComplete(() => _controller.forward());
      },
      child: Lottie.asset(
        widget.lottiePath,
        fit: BoxFit.cover,
        controller: _controller,
        height: context.dynamicHeight(
          context,
          widget.height,
        ),
        onLoaded: (composition) {
          _controller.duration = composition.duration;
        },
      ),
    );
  }
}
