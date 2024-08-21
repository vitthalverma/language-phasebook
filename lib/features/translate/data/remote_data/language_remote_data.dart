import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:saathi_assignment/core/network/network_exceptions.dart';
import 'package:saathi_assignment/features/translate/data/models/language_model.dart';

abstract interface class LanguageRemoteData {
  Future<List<LanguageModel>> fetchAllLanguages();
}

class LanguageRemoteDataImpl implements LanguageRemoteData {
  final http.Client client;

  LanguageRemoteDataImpl(this.client);
  @override
  Future<List<LanguageModel>> fetchAllLanguages() async {
    try {
      final response =
          await http.get(Uri.parse('https://libretranslate.com/languages'));

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((lang) => LanguageModel.fromJson(lang)).toList();
      } else {
        throw NtwkExceptions('Failed to load languages');
      }
    } catch (e) {
      throw NtwkExceptions(e.toString());
    }
  }
}
