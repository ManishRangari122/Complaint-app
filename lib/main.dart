import 'package:flutter/material.dart';
import 'category.dart';
import 'home_page.dart';
import 'login_page.dart';
import 'complaint_form_page.dart';
import 'complaint_list_page.dart';
import 'complaint_category_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Complaint App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
        '/home': (context) => HomePage(),
        '/complaint_form': (context) => ComplaintFormPage(),
        '/complaint_list': (context) => ComplaintListPage(),
        '/category': (context) => ComplaintCategoryPage(category: ModalRoute.of(context)!.settings.arguments as Category),
      },
    );
  }
}
