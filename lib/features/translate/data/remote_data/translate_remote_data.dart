import 'dart:io';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:saathi_assignment/core/network/network_exceptions.dart';

abstract interface class TranslateRemoteData {
  Future<String> translateTextToText(
      String sourceCode, String targetCode, String text);
  Future<String> translateToSpeech(String sourceText, String languageCode);
}

class TranslateRemoteDataImpl implements TranslateRemoteData {
  final http.Client client;

  TranslateRemoteDataImpl(this.client);

  @override
  Future<String> translateTextToText(
      String sourceCode, String targetCode, String text) async {
    try {
      final model = GenerativeModel(
        model: 'gemini-1.5-flash-latest',
        apiKey: "AIzaSyDksgVHf85qyABHx3705-3gvDLoKudR2x4",
      );
      final prompt =
          'I want to translate the following text: "$text". The source language is "$sourceCode" and the target language is "$targetCode". Just give the translated text nothing else.';

      final content = [Content.text(prompt)];
      final response = await model.generateContent(content);
      return response.text!;
    } catch (e) {
      throw NtwkExceptions(e.toString());
    }
  }

  @override
  Future<String> translateToSpeech(
      String sourceText, String languageCode) async {
    try {
      final Uri uri = Uri.http(
        'api.voicerss.org',
        '/',
        {
          'key': '0dd9fb355a4d4159a697ad9b923ffec9',
          'hl': languageCode,
          'v': 'Amy',
          'src': sourceText,
        },
      );
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final tempDir = await getTemporaryDirectory();
        final file = File('${tempDir.path}/audio.wav');
        await file.writeAsBytes(response.bodyBytes);
        return file.path;
      } else {
        print('Request failed with status: ${response.statusCode}.');
        throw NtwkExceptions('failedddd');
      }
    } catch (e) {
      print(e.toString());
      throw NtwkExceptions(e.toString());
    }
  }
}
