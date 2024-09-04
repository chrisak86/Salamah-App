import 'package:get/get.dart';

import 'lang/en.dart';
import 'lang/es.dart';

class AppLanguages extends Translations {
  @override
  Map<String, Map<String, String>> get keys {
    return {
      "en_US": english,
      "de_DE": spanish,
      "fr_FR": spanish,
      "es_ES": spanish
    };
  }
}
