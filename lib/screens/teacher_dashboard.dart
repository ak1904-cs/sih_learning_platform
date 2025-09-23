import 'dart:convert';
import 'package:flutter/material.dart';
import 'teacher_course_page.dart';

class TeacherDashboard extends StatefulWidget {
  final String teacherId;
  const TeacherDashboard({super.key, required this.teacherId});

  @override
  State<TeacherDashboard> createState() => _TeacherDashboardState();
}

class _TeacherDashboardState extends State<TeacherDashboard> {
  List courses = [];

  @override
  void initState() {
    super.initState();
    loadCourses();
  }

  Future<void> loadCourses() async {
    try {
      final String response =
          await DefaultAssetBundle.of(context).loadString('assets/data.json');
      final data = json.decode(response);

      setState(() {
        courses = data['courses']
            .where((course) => course['teacherId'] == widget.teacherId)
            .toList();
      });
    } catch (e) {
      print("Error loading courses: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("Teacher Dashboard"),
        backgroundColor: Colors.blueAccent,
      ),
      body: courses.isEmpty
          ? const Center(
              child: Text(
                "No courses assigned",
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: courses.length,
              itemBuilder: (context, index) {
                final course = courses[index];
                return Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    title: Text(
                      course['title'] ?? 'No Title',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        course['description'] ?? '',
                        style: const TextStyle(color: Colors.black87),
                      ),
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios,
                        color: Colors.blueAccent),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => TeacherCoursePage(
                            courseId: course['id'],
                            teacherId: widget.teacherId,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}
