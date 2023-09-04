import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mainsenapatirajasthan/splashscreen.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:mainsenapatirajasthan/dashboard.dart';
import 'package:mainsenapatirajasthan/disclaimer.dart';
import 'package:mainsenapatirajasthan/privacypolicy.dart';
import 'package:mainsenapatirajasthan/providers/dashboardprovider.dart';
import 'package:mainsenapatirajasthan/utils/routes.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:firebase_analytics/observer.dart';

final FirebaseAnalytics analytics = FirebaseAnalytics.instance;
void main() async {
  setPathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();
  // Firebase.initializeApp();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
      apiKey: "AIzaSyD5Nk_h8zcURXw_J62niBdh7weiNx1CdFE",
      projectId: "mainsenapatirajasthan",
      authDomain: "mainsenapatirajasthan",
      messagingSenderId: "652413472184",
      appId: "1:652413472184:web:7aa24e3c8c271b9f4a534d",
    ));
  } else {
    Firebase.initializeApp();
  }

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  @override
  void initState() {
    analytics.logEvent(
      name: 'open website',
      parameters: {'isOpen': 'yes'},
    );
    super.initState();
  }

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
        navigatorObservers: [
          FirebaseAnalyticsObserver(analytics: analytics),
        ],
        onGenerateRoute: (settings) {
          if (settings.name == '/home') {
            return MaterialPageRoute(builder: (_) => Dashboard());
          }
          // if (settings.name == '/adminLogin') {
          //   return MaterialPageRoute(builder: (_) => AdminLogin());
          // }
          // if (settings.name == '/adminDashboard') {
          //   return MaterialPageRoute(builder: (_) => AdminDashboard());
          // }
          // if (settings.name == '/ViewData') {
          //   return MaterialPageRoute(builder: (_) => ViewData());
          // }
        },
        // initialRoute: '/splash',
        getPages: [
          GetPage(
              name: Routes.dashboard,
              page: () => const Dashboard(),
              transition: Transition.fade,
              transitionDuration: const Duration(milliseconds: 100),
              curve: Curves.easeInOut),
          // GetPage(
          //     name: Routes.adminLogin,
          //     page: () => const AdminLogin(),
          //     transition: Transition.fade,
          //     transitionDuration: const Duration(milliseconds: 100),
          //     curve: Curves.easeInOut),
          GetPage(
              name: Routes.privacy,
              page: () => const PrivacyPolicy(),
              transition: Transition.fade,
              transitionDuration: const Duration(milliseconds: 100),
              curve: Curves.easeInOut),
          GetPage(
              name: Routes.disclaimer,
              page: () => const Disclaimer(),
              transition: Transition.fade,
              transitionDuration: const Duration(milliseconds: 100),
              curve: Curves.easeInOut),
          // GetPage(
          //     name: Routes.adminDashboard,
          //     page: () => const AdminDashboard(),
          //     transition: Transition.fade,
          //     transitionDuration: const Duration(milliseconds: 100),
          //     curve: Curves.easeInOut),
          // GetPage(
          //     name: Routes.viewdata,
          //     page: () => const ViewData(),
          //     transition: Transition.fade,
          //     transitionDuration: const Duration(milliseconds: 100),
          //     curve: Curves.easeInOut),
        ],
        title: 'मैं सेनापति राजस्थान',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
