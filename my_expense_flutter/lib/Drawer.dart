import 'package:flutter/material.dart';
import 'package:my_expense_flutter/homeScreen.dart';
import 'package:my_expense_flutter/updateExpense.dart';
import 'Report.dart';
import 'SetExpenseLimit.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  CustomDrawerState createState() => CustomDrawerState();
}

class CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color.fromRGBO(104, 178, 252, 0.95),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(child: Icon(Icons.flutter_dash_rounded)),
          ListTile(
              title: const Text('home'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
              }),
          ListTile(
              title: const Text('Update Expense'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamedAndRemoveUntil(context, '/update', (route) => false);
              }),
          ListTile(
            title: const Text('Report'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamedAndRemoveUntil(context, '/report', (route) => false);

              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => const Report()),
              // );
            },
          ),
          ListTile(
            title: const Text('Set Expense'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamedAndRemoveUntil(context, '/set', (route) => false);

            },
          ),
        ],
      ),
    );
  }
}
