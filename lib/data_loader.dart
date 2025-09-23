import 'dart:convert';
import 'package:flutter/services.dart';
import 'data_loader.dart';
import 'package:http/http.dart' as http;

Future<List> loadCourses(int studentId) async {
  String jsonString = await rootBundle.loadString('assets/data.json');
  List allData = jsonDecode(jsonString);
  // Filter courses by student ID
  return allData.where((item) => item['id'] == studentId).toList();
}
