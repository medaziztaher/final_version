import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medilink_app/firebase_options.dart';
import 'package:medilink_app/locale/locale.dart';
import 'package:medilink_app/locale/locale_controller.dart';
import 'package:medilink_app/screens/language/intro/language_screen.dart';
import 'package:medilink_app/settings/fireabse_notifications.dart';
import 'package:medilink_app/settings/local_notifications.dart';
import 'package:medilink_app/settings/shared_prefs.dart';
import 'package:medilink_app/utils/constants.dart';
import 'package:uuid/uuid.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'screens/home/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseNotification().initNotification();
  NotificationService().initNotification();
  tz.initializeTimeZones();
  final pref = Pref();
  await pref.initPrefs();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late String uuid;
  @override
  void initState() {
    super.initState();
    _loadUuid();
  }

  Future<void> _loadUuid() async {
    String? storedUuid = Pref().prefs?.getString(kuuid);

    if (storedUuid == null) {
      final newUuid = const Uuid().v4();
      setState(() {
        uuid = newUuid;
      });
      Pref().prefs?.setString(kuuid, newUuid);
    } else {
      setState(() {
        uuid = storedUuid;
      });
    }
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MyLocaleController());
    final hasToken = Pref().prefs!.getString(kTokenSave) != null;

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return ScreenUtilInit(
        designSize: Size(screenWidth, screenHeight),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Medilink',
            locale: controller.initialLang,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
              textTheme: GoogleFonts.nunitoSansTextTheme(),
              useMaterial3: true,
              scaffoldBackgroundColor: scaffoldColor,
            ),
            translations: MyLocale(),
            defaultTransition: Transition.leftToRightWithFade,
            transitionDuration: const Duration(milliseconds: 500),
            home: hasToken ? const HomeScreen() : const LanguageScreen(),
          );
        });
  }
}
