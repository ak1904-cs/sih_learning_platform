import 'package:flutter/material.dart';

class CourseScreen extends StatelessWidget {
  final Map course;
  final String language;

  const CourseScreen({super.key, required this.course, required this.language});

  String getLabel(String en, String hi, String pa) {
    if (language == 'en') return en;
    if (language == 'hi') return hi;
    return pa;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(course["title"]),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            if (course["lectures"].isNotEmpty) ...[
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(getLabel("Lectures", "व्याख्यान", "ਲੈਕਚਰ"),
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      ...course["lectures"].map<Widget>((lec) => ListTile(
                            leading: const Icon(Icons.play_circle_fill,
                                color: Colors.blueAccent),
                            title: Text(lec["title"]),
                          )),
                    ],
                  ),
                ),
              ),
            ],
            if (course["assignments"].isNotEmpty) ...[
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(getLabel("Assignments", "असाइनमेंट", "ਅਸਾਈਨਮੈਂਟ"),
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      ...course["assignments"].map<Widget>((asg) => ListTile(
                            leading: const Icon(Icons.assignment,
                                color: Colors.orange),
                            title: Text(asg["title"]),
                            subtitle: Text(
                                "${getLabel("Due","नियत तिथि","ਅੰਤਿਮ ਮਿਤੀ")}: ${asg["due_date"]}"),
                          )),
                    ],
                  ),
                ),
              ),
            ],
            if (course["quizzes"].isNotEmpty) ...[
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(getLabel("Quizzes", "प्रश्नोत्तरी", "ਕੁਇਜ਼"),
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      ...course["quizzes"].map<Widget>((quiz) => ListTile(
                            leading: const Icon(Icons.quiz, color: Colors.green),
                            title: Text(quiz["title"]),
                            subtitle: Text(
                                "${getLabel("Date","तिथि","ਮਿਤੀ")}: ${quiz["date"]}"),
                          )),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
