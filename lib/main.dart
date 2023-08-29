import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_breakpoints.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:sarkar/dashboard.dart';
import 'package:sarkar/providers/dashboardprovider.dart';
import 'package:url_strategy/url_strategy.dart';

void main() async {
  setPathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();
  // Firebase.initializeApp();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
      apiKey: "AIzaSyB28s2HqhlF_oELdTVKc-p4Xlmkv_iREZ0",
      projectId: "senapati-d469d",
      messagingSenderId: "645048266432",
      appId: "1:645048266432:web:bd67a1ce74c73abcf34725",
    ));
  } else {
    Firebase.initializeApp();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => DashboardProvider())],
      child: GetMaterialApp(
        scrollBehavior: MaterialScrollBehavior().copyWith(
          dragDevices: {
            PointerDeviceKind.mouse,
            PointerDeviceKind.touch,
            PointerDeviceKind.stylus,
            PointerDeviceKind.unknown
          },
        ),
        builder: (context, child) => ResponsiveBreakpoints.builder(
          child: child!,
          breakpoints: [
            const Breakpoint(start: 0, end: 450, name: MOBILE),
            const Breakpoint(start: 451, end: 800, name: TABLET),
            const Breakpoint(start: 801, end: 1920, name: DESKTOP),
            const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
          ],
        ),
        debugShowCheckedModeBanner: false,
        title: 'मैं सेनापति राजस्थान',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Dashboard(),
      ),
    );
  }
}
