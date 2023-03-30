import 'package:flutter/material.dart';

import '../../product/enums/edge_insets.dart';
import 'informations_view.dart';
import 'welcome_view.dart';

class OnBoardingView extends StatelessWidget {
  OnBoardingView({super.key});
  final List<Widget> _onBoardViews = [
    const WelcomeView(),
    const InformationView()
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: Padding(
          padding: EdgeInsetsValues.appPadding.value(),
          child: Column(
            children: [
              Expanded(child: TabBarView(children: _onBoardViews)),
              TabPageSelector(
                color: Theme.of(context).primaryColorDark,
                selectedColor: Theme.of(context).colorScheme.secondary,
              )
            ],
          ),
        ),
      ),
    );
  }
}
