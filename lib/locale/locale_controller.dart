import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:medilink_app/settings/shared_prefs.dart';
import 'package:medilink_app/utils/constants.dart';

class MyLocaleController extends GetxController {
  final pref = Pref();
  Locale? initialLang;

  @override
  void onInit() {
    super.onInit();
    initialLang = pref.prefs?.getString(kLangSave) == null
        ? Get.deviceLocale
        : Locale(pref.prefs!.getString(kLangSave)!);
  }

  void changeLang(String langCode) {
    Locale locale;
    switch (langCode) {
      case 'en':
        locale = const Locale('en', 'US');
        break;
      case 'fr':
        locale = const Locale('fr', 'FR');
        break;
      default:
        locale = Get.deviceLocale!;
    }
    pref.prefs!.setString(kLangSave, langCode);
    Get.updateLocale(locale);
  }
}
