import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:weight_tracker/core/model/record_model.dart';
import 'package:weight_tracker/core/model/user_model.dart';
import 'package:weight_tracker/product/extension/duration.dart';

import 'product/cache/record_manager.dart';
import 'product/cache/user_manager.dart';
import 'product/constants/hive_constants.dart';
import 'product/theme/theme.dart';
import 'view/add_record_view.dart';
import 'view/bmi_view.dart';
import 'view/chart_view.dart';
import 'view/history_view.dart';
import 'view/home_view.dart';
import 'view/onboard/onboarding.dart';

Future<void> _hiveInit() async {
  await Hive.initFlutter();
  Hive
    ..registerAdapter(RecordAdapter())
    ..registerAdapter(UserAdapter());
  await Hive.openBox<Record>(HiveConstants.recordBoxname);
  await Hive.openBox<User>(HiveConstants.userBoxName);
}

Future<void> appInit() async {
  await _hiveInit();
  const SystemUiOverlayStyle(statusBarColor: Colors.transparent);
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await appInit();
  final darkTheme = await ProjectTheme().darkThemeInit();
  final lightTheme = await ProjectTheme().lightThemeInit();
  runApp(
    ChangeNotifierProvider<RecordManager>(
      create: (context) => RecordManager.getInstance(),
      child: MyApp(
        darkTheme: darkTheme,
        lightTheme: lightTheme,
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({
    required ThemeData darkTheme,
    required ThemeData lightTheme,
    super.key,
  }) {
    _darkTheme = darkTheme;
    _lightTheme = lightTheme;
  }
  bool get isUserNew => UserManager.getInstance().user == null;
  late final ThemeData _lightTheme;
  late final ThemeData _darkTheme;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeAnimationDuration: DurationExtension.lowDuration,
      theme: _lightTheme,
      darkTheme: _darkTheme,
      routes: {
        '/': (context) => isUserNew ? OnBoardingView() : HomeView(),
        'Chart': (context) => const ChartView(),
        'History': (context) => const HistoryView(),
        'AddRecord': (context) => const AddRecordView(),
        'Bmi': (context) => const BmiView(),
      },
    );
  }
}
