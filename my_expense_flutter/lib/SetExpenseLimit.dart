import 'package:flutter/material.dart';
import 'package:my_expense_flutter/Drawer.dart';
import 'package:my_expense_flutter/setlimitmodal.dart';
import 'network_api.dart';

class ExpenseLimit extends StatefulWidget {
  const ExpenseLimit({super.key});

  @override
  ExpenseLimitState createState() => ExpenseLimitState();
}

class ExpenseLimitState extends State<ExpenseLimit> {
  TextEditingController amountController = TextEditingController();
  Future<List<String>>? future;

  Future<SetLimitModal>? future2;
  String amount = '';
  String myYear = '';
  String myMonth = '';
  String displayYear = 'SELECT YEAR';
  String displayMonth = 'SELECT MONTH';
  List<String> category = [];
  List<String> monthCat = [
    'JAN',
    'FEB',
    'MAR',
    'APR',
    'MAY',
    'JUN',
    'JUL',
    'AUG',
    'SEP',
    'OCT',
    'NOV',
    'DES'
  ];

  check() {
    if (amountController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please enter a valid amount')));
    } else if (myMonth == '') {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Select a Month')));
    } else if (myYear == '') {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Select a Year')));
    } else {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Center(
                child: Text(
                  'ALERT',
                  style: TextStyle(
                    fontFamily: 'Georgia',
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              content: const Text(
                'You cannot You will not be able to change this limit are you sure?',
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancel')),
                TextButton(
                    onPressed: () {
                      amount = amountController.text.toString();
                      future2 = NetworkApi.setLimit(amount, myYear, myMonth);
                      Navigator.of(context).pop();
                    },
                    child: const Text('Ok'))
              ],
            );
          });
    }
  }

  @override
  void initState() {
    future = NetworkApi.getYears();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(104, 178, 252, 0.95),
          title: const Text(
            'Expense Limit',
            style: TextStyle(fontFamily: 'Georgia'),
          ),
          centerTitle: true,
        ),
        drawer: const CustomDrawer(),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(4, 40, 4, 0),
          child: FractionallySizedBox(
            heightFactor: 0.8,
            child: Container(
              padding: const EdgeInsets.all(30),
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color.fromRGBO(104, 178, 252, 0.95),
                      Color.fromRGBO(104, 178, 252, 0.95),
                    ],
                  ),
                  borderRadius: BorderRadiusDirectional.only(
                      topStart: Radius.circular(50),
                      topEnd: Radius.circular(50),
                      bottomEnd: Radius.circular(50),
                      bottomStart: Radius.circular(50))),
              child: ListView(children: [
                Column(
                  children: [
                    RichText(
                      text: const TextSpan(
                          text: 'Set Expense Limit',
                          style: TextStyle(
                              letterSpacing: 1.5,
                              fontSize: 35.0,
                              fontFamily: 'Georgia',
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: getYearList(),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: DropdownButton<String>(
                        hint: Text(displayMonth),
                        items: monthCat.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? value) {
                          setState(() {
                            myMonth = value!;
                            displayMonth = value!;
                          });
                        },
                      ),
                    ),
                    TextFormField(
                      maxLength: 10,
                      controller: amountController,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.currency_rupee_sharp),
                        labelText: 'Amount',
                        labelStyle: TextStyle(
                          letterSpacing: 2.0,
                          color: Color.fromRGBO(225, 225, 225, 1),
                        ),
                        helperText: 'Set Expense Limit',
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromRGBO(225, 225, 225, 1),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: SizedBox(
                        height: 50,
                        width: 200,
                        child: ElevatedButton(
                          onPressed: () {
                            check();
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromRGBO(252, 178, 104, 1),
                              shape: const StadiumBorder()),
                          child: const Text(
                            'SET',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  alignment: Alignment.center,
                  child: (future2 == null)
                      ? const SizedBox(
                          height: 30,
                          width: 10,
                          child: Text('hi'),
                        )
                      : response(),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }

  FutureBuilder<List<String>> getYearList() {
    return FutureBuilder<List<String>>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          category = snapshot.data!;
          return DropdownButton<String>(
            hint: Text(displayYear),
            items: category.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String? value) {
              setState(() {
                myYear = value!;
                displayYear = value!;
              });
            },
          );
        } else if (snapshot.hasError) {
          return Text(snapshot.data.toString());
        }
        return const CircularProgressIndicator();
      },
    );
  }

  FutureBuilder<SetLimitModal> response() {
    return FutureBuilder<SetLimitModal>(
        future: future2,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data?.response == 'success') {
              return const Text('Successfully updated');
            } else if (snapshot.data?.response == 'AlreadySet') {
              return const Text('Already Set');
            }
          } else if (snapshot.hasError) {
            return Text(snapshot.data.toString());
          }
          return const CircularProgressIndicator();
        }
        );
  }
}
