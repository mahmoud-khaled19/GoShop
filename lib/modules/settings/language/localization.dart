import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/app_constance/strings_manager.dart';

class LocalizationTheme extends StatefulWidget {
  const LocalizationTheme({Key? key}) : super(key: key);

  @override
  State<LocalizationTheme> createState() => _HomeState();
}

class _HomeState extends State<LocalizationTheme> {
  String? value = AppStrings.arabic;

  @override
  Widget build(BuildContext context) {
    final languages = [
      AppStrings.arabic,
      'english',
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          value: value,
          isExpanded: true,
          iconSize: 30,
          icon:  Icon(Icons.arrow_drop_down, color: Theme.of(context).splashColor),
          items: languages.map(buildMenuLanguages).toList(),
          onChanged: (value) => setState(() {
            this.value = value;
            if (value ==  AppStrings.arabic) {
              context.setLocale(const Locale('ar'));
            } else {
              context.setLocale(const Locale('en'));
            }
          }),
        ),
      ),
    );
  }

  DropdownMenuItem<String> buildMenuLanguages(String language) =>
      DropdownMenuItem(
        value: language,
        child: Text(
          language,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      );
}
