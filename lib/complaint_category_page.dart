import 'package:flutter/material.dart';
import 'category.dart';

class ComplaintCategoryPage extends StatelessWidget {
  final Category category;

  ComplaintCategoryPage({required this.category});

  final List<String> governmentDepartments = [
    'Department of Public Works',
    'Department of Health',
    'Department of Education',
  ];

  final List<String> privateDepartments = [
    'Customer Service',
    'Technical Support',
    'Billing Department',
  ];

  @override
  Widget build(BuildContext context) {
    List<String> departments = category.title == 'Government'
        ? governmentDepartments
        : privateDepartments;

    return Scaffold(
      appBar: AppBar(
        title: Text('${category.title} Complaints'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Recommendations for ${category.title} complaints:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'Here are some departments you can complain to:',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: departments.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 3,
                    child: ListTile(
                      title: Text(
                        departments[index],
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      leading: Icon(
                        Icons.account_balance,
                        color: Colors.blueAccent,
                      ),
                      trailing: Icon(
                        Icons.arrow_forward,
                        color: Colors.blueAccent,
                      ),
                      onTap: () {
                        // Navigate to a detailed page or show more information
                      },
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
