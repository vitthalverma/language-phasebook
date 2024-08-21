import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:saathi_assignment/core/app/app_colors.dart';
import 'package:saathi_assignment/features/translate/presentation/bloc/translate/translate_bloc.dart';
import 'package:saathi_assignment/features/translate/presentation/widgets/custom_button.dart';

class SpeechTranslateScreen extends StatefulWidget {
  const SpeechTranslateScreen({super.key});

  @override
  State<SpeechTranslateScreen> createState() => _SpeechTranslateScreenState();
}

class _SpeechTranslateScreenState extends State<SpeechTranslateScreen> {
  final _textController = TextEditingController();
  String _selectedLanguageCode = 'en-us'; // Default to English
  final List<Map<String, String>> languages = [
    {'name': 'English', 'code': 'en-us'},
    {'name': 'Russian', 'code': 'ru-ru'},
    {'name': 'Spanish', 'code': 'es-es'},
    // Add more languages as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.all(3.w),
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              value: _selectedLanguageCode,
              items: languages.map((language) {
                return DropdownMenuItem<String>(
                  value: language['code'],
                  child: Text(language['name']!),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedLanguageCode = value!;
                });
              },
              decoration: InputDecoration(
                labelText: 'Select Language',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 2.h),
            Container(
              height: 25.h,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey),
              ),
              child: TextField(
                style: const TextStyle(
                  color: AppColors.grey800,
                ),
                maxLines: 20,
                controller: _textController,
                decoration: const InputDecoration(
                  hintText: 'Text to speak out..',
                  hintStyle: TextStyle(
                    color: AppColors.grey300,
                  ),
                  border: InputBorder.none,
                ),
                obscureText: false,
              ),
            ),
            SizedBox(height: 2.h),
            CustomButton(
              height: 6.h,
              width: double.infinity,
              name: 'Speak out',
              onTap: () {
                context.read<TranslateBloc>().add(TextToSpeechTranslateEvent(
                      text: _textController.text.trim(),
                      languageCode: _selectedLanguageCode,
                    ));
              },
            ),
          ],
        ),
      ),
    );
  }
}
