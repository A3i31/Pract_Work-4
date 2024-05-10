import 'dart:convert';
import 'dart:io';

import 'package:translator/translator.dart';

void main() async {
  translate();
}

void translate() async {
  print(
      'Добро пожаловать в переводчик!\nВыберите язык который нужно перевести!\nВозможные варианты:\nEN - Английский\nKY - Кыргызский\nUZ - Узбекский\nTR - Турецкий');
  String targetLanguage =
      stdin.readLineSync(encoding: Encoding.getByName('utf-8')!)!;
  while (checkTargetLanguage(targetLanguage)) {
    print(
        'Введите язык который присутствует в списке:\nEN - Английский\nKY - Кыргызский\nUZ - Узбекский\nTR - Турецкий');
    targetLanguage =
        stdin.readLineSync(encoding: Encoding.getByName('utf-8')!)!;
  }

  print(
      'Выберите язык на который нужно перевести:\nВозможные варианты:\nEN - Английский\nKY - Кыргызский\nUZ - Узбекский\nTR - Турецкий');
  String sourceLanguage =
      stdin.readLineSync(encoding: Encoding.getByName('utf-8')!)!;
  while (checkSourceLanguage(sourceLanguage)) {
    print(
        'Введите язык который присутствует в списке:\nEN - Английский\nKY - Кыргызский\nUZ - Узбекский\nTR - Турецкий');
    sourceLanguage = stdin.readLineSync() ?? '';
  }

  final GoogleTranslator googleTranslator = GoogleTranslator();
  print('Введите текст для перевода:');
  String text = stdin.readLineSync(encoding: Encoding.getByName('utf-8')!)!;
  while (text == null || text.isEmpty || containsDigits(text)) {
    print('Введите слово или предложение!');
    text = stdin.readLineSync() ?? '';
  }
  Translation translation = await googleTranslator.translate(text,
      from: targetLanguage.toLowerCase(), to: sourceLanguage.toLowerCase());
  print(translation);
  print('Хотите продолжить? Y N');

  String call = stdin.readLineSync() ?? '';
  if (call.toLowerCase() == 'y') {
    translate();
  } else {
    print('Спасибо!');
  }
}

bool checkTargetLanguage(String targetLanguage) {
  switch (targetLanguage.toLowerCase()) {
    case 'en':
    case 'ky':
    case 'uz':
    case 'tr':
      return false;
    default:
      return true;
  }
}

bool checkSourceLanguage(String sourceLanguage) {
  switch (sourceLanguage.toLowerCase()) {
    case 'en':
    case 'ky':
    case 'uz':
    case 'tr':
      return false;
    default:
      return true;
  }
}

bool containsDigits(String text) {
  return RegExp(r'\d').hasMatch(text);
}

