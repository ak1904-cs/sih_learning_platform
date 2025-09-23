import 'package:flutter/material.dart';

class StudentDashboard extends StatefulWidget {
  final Function(Locale) onLocaleChange;
  final Map student;

  const StudentDashboard({
    super.key,
    required this.onLocaleChange,
    required this.student,
  });

  @override
  State<StudentDashboard> createState() => _StudentDashboardState();
}

class _StudentDashboardState extends State<StudentDashboard> {
  String language = 'pa';

  String getLabel(String en, String hi, String pa) {
    if (language == 'en') return en;
    if (language == 'hi') return hi;
    return pa;
  }

  @override
  Widget build(BuildContext context) {
    final student = widget.student;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(getLabel('Student Dashboard', 'विद्यार्थी डैशबोर्ड', 'ਵਿਦਿਆਰਥੀ ਡੈਸ਼ਬੋਰਡ')),
        backgroundColor: Colors.blueAccent,
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              setState(() {
                language = value.toLowerCase();
              });
              if (value == 'EN') widget.onLocaleChange(const Locale('en'));
              if (value == 'HI') widget.onLocaleChange(const Locale('hi'));
              if (value == 'PA') widget.onLocaleChange(const Locale('pa'));
            },
            itemBuilder: (context) => const [
              PopupMenuItem(value: 'EN', child: Text('English')),
              PopupMenuItem(value: 'HI', child: Text('हिन्दी')),
              PopupMenuItem(value: 'PA', child: Text('ਪੰਜਾਬੀ')),
            ],
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${getLabel("Name","नाम","ਨਾਂ")}: ${student["name"]}',
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Text('${getLabel("ID","आईडी","ਆਈ.ਡੀ.")}: ${student["id"]}',
                        style: const TextStyle(fontSize: 16)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              getLabel("Enrolled Courses", "नामांकित पाठ्यक्रम", "ਦਾਖਲ ਕੀਤੇ ਕੋਰਸ"),
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: student["courses"].length,
                itemBuilder: (context, index) {
                  final course = student["courses"][index];
                  return Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ExpansionTile(
                      title: Text(course["title"],
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                      subtitle: Text(
                        "${getLabel("Lectures","व्याख्यान","ਲੈਕਚਰ")}: ${course["lectures"].length}, "
                        "${getLabel("Assignments","असाइनमेंट","ਅਸਾਈਨਮੈਂਟ")}: ${course["assignments"].length}, "
                        "${getLabel("Quizzes","प्रश्नोत्तरी","ਕੁਇਜ਼")}: ${course["quizzes"].length}",
                      ),
                      childrenPadding: const EdgeInsets.symmetric(horizontal: 16),
                      children: [
                        if (course["lectures"].isNotEmpty) ...[
                          const Divider(),
                          ListTile(
                            title: Text(getLabel("Lectures", "व्याख्यान", "ਲੈਕਚਰ"),
                                style: const TextStyle(fontWeight: FontWeight.bold)),
                          ),
                          ...course["lectures"].map<Widget>((lec) => ListTile(
                                leading: const Icon(Icons.play_circle_fill, color: Colors.blueAccent),
                                title: Text(lec["title"]),
                              )),
                        ],
                        if (course["assignments"].isNotEmpty) ...[
                          const Divider(),
                          ListTile(
                            title: Text(getLabel("Assignments", "असाइनमेंट", "ਅਸਾਈਨਮੈਂਟ"),
                                style: const TextStyle(fontWeight: FontWeight.bold)),
                          ),
                          ...course["assignments"].map<Widget>((asg) => ListTile(
                                leading: const Icon(Icons.assignment, color: Colors.orange),
                                title: Text(asg["title"]),
                                subtitle: Text("Due: ${asg["due_date"]}"),
                              )),
                        ],
                        if (course["quizzes"].isNotEmpty) ...[
                          const Divider(),
                          ListTile(
                            title: Text(getLabel("Quizzes", "प्रश्नोत्तरी", "ਕੁਇਜ਼"),
                                style: const TextStyle(fontWeight: FontWeight.bold)),
                          ),
                          ...course["quizzes"].map<Widget>((quiz) => ListTile(
                                leading: const Icon(Icons.quiz, color: Colors.green),
                                title: Text(quiz["title"]),
                                subtitle: Text("Date: ${quiz["date"]}"),
                              )),
                        ],
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
