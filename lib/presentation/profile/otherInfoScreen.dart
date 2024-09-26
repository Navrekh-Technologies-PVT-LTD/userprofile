import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:yoursportz/core/extension.dart';
import 'package:yoursportz/routing/app_router.gr.dart';
import 'package:yoursportz/utils/color.dart';
import 'package:yoursportz/utils/famcyDatepicker.dart';

import '../../gen/locale_keys.g.dart';
import '../../utils/size_config.dart';

class OtherInfoScreen extends StatefulWidget {
  const OtherInfoScreen({super.key});

  @override
  State<OtherInfoScreen> createState() => _OtherInfoScreenState();
}

class _OtherInfoScreenState extends State<OtherInfoScreen> {
  String? _selectedGender, selecteddate;
  TextEditingController cityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leadingWidth: 0,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              Icons.arrow_back_outlined,
              color: Colors.black,
            ),
            const SizedBox(
              width: 10,
            ),
            RichText(
              // textAlign: TextAlign.center,
              text: TextSpan(
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: kPrimaryColor, // Default color for the text
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: tr(LocaleKeys.your),
                    //'Your',
                    style: const TextStyle(color: kPrimaryColor),
                  ),
                  TextSpan(
                      text: tr(LocaleKeys.sportz),
                      //'Sportz',
                      style: const TextStyle(color: Colors.red)),
                ],
              ),
            ),
          ],
        ),
        leading: Container(),
      ),
      body: Container(
        height: SizeConfig.screenH,
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 18),
            Text(
              tr(LocaleKeys.date_of_birth),
              //'Date of Birth',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            FancyDateInput(
              onDateSelected: (DateTime selectedDate) {
                // Use the selected date here
                log('Selected Date: $selectedDate');

                selecteddate = selectedDate.toString();
                // You can assign it to a variable, pass it to another function, etc.
              },
            ),
            const SizedBox(height: 18),
            Text(
              tr(LocaleKeys.gender),
              // 'Gender',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: _selectedGender,
              icon: Image.asset("assets/images/arrow_down.png"),
              onChanged: (newValue) {
                setState(() {
                  _selectedGender = newValue;
                });
              },
              items: <String>[
                'Male',
                'Female',
                'Other'
              ] // Replace this with your own list of genders
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 1, horizontal: 10),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              tr(LocaleKeys.where_do_you_live),
              //'Where do you live?',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: cityController,
              decoration: InputDecoration(
                labelText: tr(LocaleKeys.enter_your_city),
                //"Enter your city",
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 1, horizontal: 10),
              ),
            ),
            const SizedBox(height: 30),
            GestureDetector(
              onTap: () {
                context.navigate(AppBaseRoute(phone: "null"));
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.circular(10.0)),
                child: Text(
                  tr(LocaleKeys.create_account),
                  // 'Create Account',
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
