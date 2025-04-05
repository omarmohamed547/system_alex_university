import 'package:flutter/material.dart';

class LectureTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Lecture Table', style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: Icon(Icons.menu, color: Colors.white),
          onPressed: () {},
        ),
      ),
      body: Column(
        children: [
          Container(
            color: Colors.blue,
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('8:30 AM', style: TextStyle(color: Colors.white)),
                Text('10:30 AM', style: TextStyle(color: Colors.white)),
              ],
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(8),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 3,
              ),
              itemCount: lectures.length,
              itemBuilder: (context, index) {
                final lecture = lectures[index];
                return Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: lecture['color'],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        lecture['subject'],
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                      SizedBox(height: 4),
                      Text(
                        lecture['professor'],
                        style: TextStyle(fontSize: 12, color: Colors.black54),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

final List<Map<String, dynamic>> lectures = [
  {
    'subject': 'Multivariate Statistics (101)',
    'professor': 'صبري محمد احمد',
    'color': Colors.red[100]
  },
  {
    'subject': 'Operating Systems (425)',
    'professor': 'د.حازم عبد الحميد محمد',
    'color': Colors.orange[100]
  },
  {
    'subject': 'S.Operating Systems (425)',
    'professor': 'د.ماجد محارب',
    'color': Colors.red[100]
  },
  {
    'subject': 'Introduction to Network (425)',
    'professor': 'امام الدين ابراهيم',
    'color': Colors.yellow[100]
  },
];
