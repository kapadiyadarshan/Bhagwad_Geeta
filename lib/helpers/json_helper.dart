import 'dart:convert';

import 'package:flutter/services.dart';

class JSONHelper {
  JSONHelper._();

  static final JSONHelper jsonHelper = JSONHelper._();

  Future<List> getChapters() async {
    String data = await rootBundle.loadString("asset/json/chapters.json");

    List allChapters = jsonDecode(data);

    return allChapters;
  }

  Future<List> getVerses() async {
    String data = await rootBundle.loadString("asset/json/verse.json");

    List allVerses = jsonDecode(data);

    return allVerses;
  }
}
