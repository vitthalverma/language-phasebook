import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:saathi_assignment/core/app/app_colors.dart';
import 'package:saathi_assignment/core/utils/animated_snack_bar.dart';
import 'package:saathi_assignment/features/translate/domain/entities/language_entity.dart';
import 'package:saathi_assignment/features/translate/presentation/bloc/favourite_phase/bloc/favourite_phrase_bloc.dart';
import 'package:saathi_assignment/features/translate/presentation/bloc/language/language_bloc.dart';
import 'package:saathi_assignment/features/translate/presentation/bloc/translate/translate_bloc.dart';
import 'package:saathi_assignment/features/translate/presentation/widgets/custom_button.dart';

class TextTranslateScreen extends StatefulWidget {
  const TextTranslateScreen({super.key});

  @override
  State<TextTranslateScreen> createState() => _TextTranslateScreenState();
}

class _TextTranslateScreenState extends State<TextTranslateScreen> {
  final TextEditingController _textController = TextEditingController();
  List<LanguageEntity> _languages = [];
  LanguageEntity? _selectedSourceLanguage;
  LanguageEntity? _selectedTargetLanguage;
  bool isFavourite = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final phrase = ModalRoute.of(context)?.settings.arguments as String?;
    if (phrase != null) {
      _textController.text = phrase;
    }
  }

  @override
  void initState() {
    super.initState();
    context.read<LanguageBloc>().add(FetchAllLanguagesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                isFavourite = !isFavourite;
              });
              // pass the current text to home screen and add it to favorites list
              context.read<FavouritePhraseBloc>().add(
                  AddFavouritePhraseEvent(phrase: _textController.text.trim()));
              //   Navigator.pop(context);
            },
            icon: Icon(
              Icons.bookmark_add,
              color: isFavourite ? AppColors.green400 : AppColors.white,
            ),
          ),
        ],
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<LanguageBloc, LanguageState>(
            listener: (context, state) {
              if (state is LanguageLoaded) {
                setState(() {
                  _languages = state.languages;
                  _selectedSourceLanguage = _languages.first;
                  _selectedTargetLanguage = _languages.first.targets.isNotEmpty
                      ? _languages.firstWhere(
                          (lang) => lang.code == _languages.first.targets.first)
                      : _languages.first;
                });
              } else if (state is LanguageError) {
                return AppSnack.error(context, state.errorMessage);
              }
            },
          ),
          BlocListener<TranslateBloc, TranslateState>(
            listener: (context, state) {
              if (state is TranslateError) {
                return AppSnack.error(context, state.errorMessage);
              } else if (state is TranslateTextSuccess) {
                return AppSnack.success(context, 'Tanslation success!');
              }
            },
          ),
        ],
        child: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
          child: Padding(
            padding: EdgeInsets.all(5.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (_languages.isNotEmpty) ...[
                  // Dropdown for Source Language

                  Flexible(
                    child: DropdownButtonFormField<LanguageEntity>(
                      value: _selectedSourceLanguage,
                      hint: const Text('Select Source Language'),
                      onChanged: (LanguageEntity? newValue) {
                        setState(() {
                          _selectedSourceLanguage = newValue!;
                          // Update target language options based on selected source language
                          _selectedTargetLanguage = _languages.firstWhere(
                              (lang) =>
                                  lang.code ==
                                  _selectedSourceLanguage!.targets.first);
                        });
                      },
                      items: _languages.map<DropdownMenuItem<LanguageEntity>>(
                          (LanguageEntity lang) {
                        return DropdownMenuItem<LanguageEntity>(
                          value: lang,
                          child: Text(lang.name),
                        );
                      }).toList(),
                      decoration: InputDecoration(
                        labelText: 'Select Source Language',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 2.h),

                  // Dropdown for Target Language
                  Flexible(
                    child: DropdownButtonFormField<LanguageEntity>(
                      value: _selectedTargetLanguage,
                      hint: const Text('Select Target Language'),
                      onChanged: (LanguageEntity? newValue) {
                        setState(() {
                          _selectedTargetLanguage = newValue!;
                        });
                      },
                      items: _selectedSourceLanguage?.targets
                              .map<DropdownMenuItem<LanguageEntity>>(
                                  (String targetLangCode) {
                            final lang = _languages.firstWhere(
                                (lang) => lang.code == targetLangCode);
                            return DropdownMenuItem<LanguageEntity>(
                              value: lang,
                              child: Text(lang.name),
                            );
                          }).toList() ??
                          [],
                      decoration: InputDecoration(
                        labelText: 'Select target Language',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ],
                SizedBox(height: 5.h),
                Container(
                  height: 25.h,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                      hintText: 'Text to translate..',
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
                  name: 'Translate',
                  onTap: () {
                    context.read<TranslateBloc>().add(TextTotextTranslateEvent(
                          text: _textController.text.trim(),
                          sourceCode: _selectedSourceLanguage!.code,
                          targetCode: _selectedTargetLanguage!.code,
                        ));
                  },
                ),
                SizedBox(height: 5.h),
                BlocBuilder<TranslateBloc, TranslateState>(
                  builder: (context, state) {
                    if (state is TranslateTextSuccess) {
                      return Text(
                        state.translatedText,
                        style: TextStyle(
                          fontSize: 22.sp,
                          color: AppColors.white,
                        ),
                      );
                    }
                    if (state is TranslateLoading) {
                      return const Text('Loading...');
                    } else {
                      return Container();
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
