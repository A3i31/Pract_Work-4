import 'dart:io';

import 'package:translator/translator.dart';

void main() async {
  translate();
}

void translate() async {
  print(
      'Добро пожаловать в переводчик!\nВыберите язык который нужно перевести!\nВозможные варианты:\nEN - Английский\nKY - Кыргызский\nUZ - Узбекский\nTR - Турецкий');
  String targetLanguage = stdin.readLineSync() ?? '';
  while (checkTargetLanguage(targetLanguage)) {
    print(
        'Введите язык который присутствует в списке:\nEN - Английский\nKY - Кыргызский\nUZ - Узбекский\nTR - Турецкий');
    targetLanguage = stdin.readLineSync() ?? '';
  }
  print(
      'Выберите язык на который нужно перевести:\nВозможные варианты:\nEN - Английский\nKY - Кыргызский\nUZ - Узбекский\nTR - Турецкий');
  String sourceLanguage = stdin.readLineSync() ?? '';
  while (checkSourceLanguage(sourceLanguage)) {
    print(
        'Введите язык который присутствует в списке:\nEN - Английский\nKY - Кыргызский\nUZ - Узбекский\nTR - Турецкий');
    sourceLanguage = stdin.readLineSync() ?? '';
  }
  final GoogleTranslator googleTranslator = GoogleTranslator();
  print('Введите слово или текст для перевода:');
  String text = stdin.readLineSync().toString();
  while (text == null) {
    print('Введите слово или предложение!');
    text = stdin.readLineSync().toString();
  }
  Translation translation = await googleTranslator.translate(text,
      from: targetLanguage.toLowerCase(), to: sourceLanguage.toLowerCase());
  print(translation);
  print(
      'Выбранные ранее языки перевода с ${targetLanguage.toUpperCase()} на ${sourceLanguage.toUpperCase()}');
  String choice = '';
  do {
    print('Хотите продолжить с выбранными ${targetLanguage.toUpperCase()},${sourceLanguage.toUpperCase()} языками? Y/N');
    choice = stdin.readLineSync() ?? ''.toLowerCase();

    if (choice != 'n') { 
      print(
          'Введите слово или текст для перевода\nНажмите "N" для выхода или смены языков');
      String text = stdin.readLineSync().toString();
      while (text == null) {
        print('Введите слово или предложение!');
        text = stdin.readLineSync().toString();
      }
      Translation translation = await googleTranslator.translate(text,
          from: targetLanguage.toLowerCase(), to: sourceLanguage.toLowerCase());
      print(translation);
    }
  } while (choice != 'n');
  print('Хотите сменить языки и продолжить? Y/N');
  String callOne = stdin.readLineSync() ?? '';
  if (callOne.toLowerCase() == 'y') {
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
