import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../product/enums/edge_insets.dart';
import '../product/extension/duration.dart';
import 'add_record_view.dart';
import 'bmi_view.dart';
import 'chart_view.dart';
import 'history_view.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});

  final List<Widget> views = <Widget>[
    const ChartView(),
    const HistoryView(),
    const BmiView()
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: views.length,
      child: SafeArea(
        child: Scaffold(
          body: Padding(
            padding: EdgeInsetsValues.appPadding.value(),
            child: _TabBarView(views),
          ),
          floatingActionButton: _FabButton(context),
          bottomNavigationBar: _BottomAppBar(context),
        ),
      ),
    );
  }
}

class _BottomAppBar extends BottomAppBar {
  _BottomAppBar(BuildContext context)
      : super(
          child: _Tabbar(context),
        );
}

class _TabBarView extends TabBarView {
  const _TabBarView(List<Widget> views) : super(children: views);
}

class _Tabbar extends TabBar {
  _Tabbar(BuildContext context)
      : super(
          labelColor: Theme.of(context).primaryColor,
          unselectedLabelColor: Theme.of(context).unselectedWidgetColor,
          tabs: <Widget>[
            Padding(
              padding: EdgeInsetsValues.bAppBarIconsPadding.value(),
              child: const Tab(icon: Icon(Icons.show_chart)),
            ),
            Padding(
              padding: EdgeInsetsValues.bAppBarIconsPadding.value(),
              child: const Tab(icon: Icon(Icons.history)),
            ),
            Padding(
              padding: EdgeInsetsValues.bAppBarIconsPadding.value(),
              child: const Tab(icon: Icon(Icons.speed)),
            ),
          ],
        );
}

class _FabButton extends FloatingActionButton {
  _FabButton(BuildContext context)
      : super(
          onPressed: () {
            Navigator.push(
              context,
              PageTransition<AddRecordView>(
                alignment: Alignment.center,
                type: PageTransitionType.scale,
                duration: DurationExtension.lowDuration,
                child: const AddRecordView(),
              ),
            );
          },
          child: const Icon(Icons.add),
        );
}
