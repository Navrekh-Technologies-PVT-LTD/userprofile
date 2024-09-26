// ignore_for_file: prefer_typing_uninitialized_variables, use_build_context_synchronously

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../gen/locale_keys.g.dart';

class ChangeLanguage extends StatefulWidget {
  const ChangeLanguage({super.key, required this.phone});

  final String phone;

  @override
  State<ChangeLanguage> createState() => _ChangeLanguageState();
}

class _ChangeLanguageState extends State<ChangeLanguage> {
  var dropdownValue;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(LocaleKeys.choose_language.tr(),
                style: const TextStyle(fontSize: 20),
                textAlign: TextAlign.start),
            Padding(
                padding: const EdgeInsets.fromLTRB(0, 8, 0, 16),
                child: Text(LocaleKeys.choose_language_desc.tr(),
                    style: const TextStyle(fontSize: 12),
                    textAlign: TextAlign.start)),
            Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 240, 240, 240),
                border:
                    Border.all(color: const Color.fromARGB(255, 240, 240, 240)),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 8, 0),
                child: Row(
                  children: [
                    Expanded(
                      child: DropdownButton<String>(
                        hint: Text(LocaleKeys.select_lang.tr(),
                            style:
                                const TextStyle(fontWeight: FontWeight.normal)),
                        value: dropdownValue,
                        icon: const SizedBox(),
                        underline: const SizedBox(),
                        onChanged: (String? newValue) async {
                          if (newValue != null) {
                            setState(() {
                              _isLoading = true;
                            });

                            await _changeLanguage(newValue);

                            if (mounted) {
                              setState(() {
                                dropdownValue = newValue;
                                _isLoading = false;
                              });
                              Navigator.pop(context);
                            }
                          }
                        },
                        items: <String>[
                          'عربي',
                          'Brasileiro',
                          'English',
                          'Français',
                          'हिंदी',
                          'Português',
                          'Español',
                          'اردو'
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Row(
                              children: [
                                Text(value),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    const Icon(Icons.keyboard_arrow_down,
                        color: Color(0xff554585))
                  ],
                ),
              ),
            ),
            if (_isLoading)
              const Center(
                child: CircularProgressIndicator(),
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _changeLanguage(String language) async {
    Locale newLocale;

    switch (language) {
      case 'عربي':
        newLocale = const Locale('ar');
        break;
      case 'Brasileiro':
      case 'Português':
        newLocale = const Locale('pt', 'BR');
        break;
      case 'English':
        newLocale = const Locale('en');
        break;
      case 'Français':
        newLocale = const Locale('fr');
        break;
      case 'हिंदी':
        newLocale = const Locale('hi');
        break;
      case 'Español':
        newLocale = const Locale('es');
        break;
      case 'اردو':
        newLocale = const Locale('ur');
        break;
      default:
        newLocale = const Locale('en');
    }

    await context.setLocale(newLocale);
  }
}
