import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../product/extension/text_styles.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    const welcomeText =
        // ignore: lines_longer_than_80_chars
        'Welcome you can track your weight with this application you can write notes and add some images for yourself';
    return Scaffold(
      body: Column(
        children: [
          const Spacer(
            flex: 3,
          ),
          _lottie,
          const Spacer(),
          Text(
            welcomeText,
            style: const TextStyle().poppinsw700,
            textAlign: TextAlign.center,
          ),
          const Spacer(
            flex: 6,
          ),
        ],
      ),
    );
  }

  LottieBuilder get _lottie {
    const lottiePath = 'assets/lottie/welcome.json';
    return Lottie.asset(lottiePath, repeat: false);
  }
}
