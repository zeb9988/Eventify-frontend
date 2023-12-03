import 'package:eventify/Language/language.dart';
import 'package:eventify/Language/language_constants.dart';
import 'package:eventify/constant/Theme_constant.dart';
import 'package:eventify/main.dart';
import 'package:flutter/material.dart';

class LanguageMenu extends StatefulWidget {
  @override
  _LanguageMenuState createState() => _LanguageMenuState();
}

class _LanguageMenuState extends State<LanguageMenu> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton<Language>(
      underline: const SizedBox(),
      icon: const Icon(
        Icons.language,
        color: COLOR_ACCENT,
      ),
      onChanged: (Language? language) async {
        if (language != null) {
          Locale _locale = await setLocale(language.languageCode);
          MyApp.setLocale(context, _locale);
        }
      },
      items: Language.languageList()
          .map<DropdownMenuItem<Language>>(
            (e) => DropdownMenuItem<Language>(
              value: e,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(
                    e.flag,
                    style: const TextStyle(fontSize: 20),
                  ),
                  Text(e.name)
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}
