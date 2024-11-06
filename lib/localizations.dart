import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_example/main.dart';

class CustomLocalizationsDelegate
    extends LocalizationsDelegate<CustomLocalizations> {
  const CustomLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'zh'].contains(locale.languageCode);

  @override
  Future<CustomLocalizations> load(Locale locale) async {
    CustomLocalizations localizations = CustomLocalizations(locale: locale);
    await localizations.loadJson();
    return localizations;
  }

  @override
  bool shouldReload(CustomLocalizationsDelegate old) => false;
}

class CustomLocalizations {
  final Locale locale;
  CustomLocalizations({this.locale = const Locale("zh")});

  late Map<dynamic, dynamic> _localizedValues;

  Future<bool> loadJson() async {
    String jsonContent =
        await rootBundle.loadString("locale/${locale.languageCode}.json");
    Map<String, dynamic> jsonMap = json.decode(jsonContent);
    _localizedValues = jsonMap.map((key, value) {
      return MapEntry(key, value.toString());
    });
    _localizedValues = json.decode(jsonContent);
    return true;
  }

  static CustomLocalizations? of(BuildContext context) {
    return Localizations.of<CustomLocalizations>(context, CustomLocalizations);
  }

  void setLocale(BuildContext context, Locale locale) async {
    MyApp.setLocale(context, locale);
  }

  String text(String key) {
    return _localizedValues[key] ?? '** $key not found';
  }

  get currentLanguage => locale.languageCode;
}
