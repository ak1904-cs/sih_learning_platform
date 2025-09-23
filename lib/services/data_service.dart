import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class DataService {
  static Map? _data;

  // Load JSON once
  static Future<void> loadJson() async {
    if (_data == null) {
      final jsonString = await rootBundle.loadString('assets/data.json');
      _data = jsonDecode(jsonString);
    }
  }

  // Validate Student login
  static Future<Map?> validateStudent(int id, String password) async {
    await loadJson();
    final students = _data?['students'] ?? [];
    try {
      return students.firstWhere(
        (s) => s['id'] == id && s['password'] == password,
      );
    } catch (e) {
      return null;
    }
  }

  // Validate Teacher login
  static Future<Map?> validateTeacher(int id, String password) async {
    await loadJson();
    final teachers = _data?['teachers'] ?? [];
    try {
      return teachers.firstWhere(
        (t) => t['id'] == id && t['password'] == password,
      );
    } catch (e) {
      return null;
    }
  }

  // Get courses for a student
  static Future<List> getStudentCourses(int studentId) async {
    await loadJson();
    final students = _data?['students'] ?? [];
    final student = students.firstWhere(
      (s) => s['id'] == studentId,
      orElse: () => null,
    );
    if (student == null) return [];
    final studentCourseIds = student['courses'] ?? [];
    final courses = _data?['courses'] ?? [];
    return courses
        .where((c) => studentCourseIds.contains(c['id']))
        .toList();
  }

  // Get course details for a student
  static Future<Map?> getCourseDetails(String courseId) async {
    await loadJson();
    final courses = _data?['courses'] ?? [];
    try {
      return courses.firstWhere(
        (c) => c['id'].toString() == courseId,
      );
    } catch (e) {
      return null;
    }
  }

  // Get courses for a teacher
  static Future<List> getTeacherCourses(String teacherId) async {
    await loadJson();
    final teachers = _data?['teachers'] ?? [];
    final teacher = teachers.firstWhere(
      (t) => t['id'].toString() == teacherId,
      orElse: () => null,
    );
    if (teacher == null) return [];
    final teacherCourseIds = teacher['courses'] ?? [];
    final courses = _data?['courses'] ?? [];
    return courses
        .where((c) => teacherCourseIds.contains(c['id']))
        .toList();
  }

  // Get course details for a teacher
  static Future<Map?> getTeacherCourseDetails(String courseId) async {
    return getCourseDetails(courseId);
  }

  // Mark lesson complete (UI-only)
  static Future<void> markLessonComplete(
      String lessonId, String studentId) async {
    await Future.delayed(const Duration(milliseconds: 200));
  }

  // Submit assignment (UI-only)
  static Future<void> submitAssignment(
      String assignmentId, String studentId, String filePath) async {
    await Future.delayed(const Duration(milliseconds: 200));
  }

  // Add assignment (teacher UI-only)
  static Future<void> addAssignment(
      String courseId, String title, String dueDate) async {
    await Future.delayed(const Duration(milliseconds: 200));
  }
}
