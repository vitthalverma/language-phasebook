import 'package:saathi_assignment/features/translate/domain/entities/language_entity.dart';

class LanguageModel extends LanguageEntity {
  LanguageModel(
      {required super.name, required super.code, required super.targets});

  factory LanguageModel.fromJson(Map<String, dynamic> json) {
    return LanguageModel(
      name: json['name'] ?? '',
      code: json['code'] ?? '',
      targets: (json['targets'] as List<dynamic>)
          .map((target) => target as String)
          .toList(),
    );
  }
}
