import 'package:saathi_assignment/features/translate/domain/entities/language_entity.dart';

class AppUtils {
  String? findLanguageCode(List<LanguageEntity> languages, String lang) {
    for (var language in languages) {
      if (language.name.toLowerCase() == lang.toLowerCase()) {
        return language.code;
      }
    }
    return null;
  }
}
