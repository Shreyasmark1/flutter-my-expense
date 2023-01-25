import 'package:flutter/material.dart';
import 'package:my_expense_flutter/Drawer.dart';
import 'package:my_expense_flutter/Report.dart';
import 'Registration.dart';
import 'SetExpenseLimit.dart';
import 'updateExpense.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(104, 178, 252, 0.95),
        title: const Text(
          'Home',
          style: TextStyle(fontFamily: 'Georgia'),
        ),
        centerTitle: true,
      ),
      drawer: const CustomDrawer(),
      body: Container(),
    );
  }
}
