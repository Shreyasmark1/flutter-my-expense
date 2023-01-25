import 'dart:core';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:my_expense_flutter/network_api.dart';
import 'Drawer.dart';
import 'UpdateModal.dart';

class UpdateExpense extends StatefulWidget {
  const UpdateExpense({super.key});

  @override
  UpdateExpenseState createState() => UpdateExpenseState();
}

class UpdateExpenseState extends State<UpdateExpense> {


 // final FirebaseMessaging fcm = FirebaseMessaging.instance;


  String myMonth = '';
  String myYear = '';
  String myDate = '';
  String myCat = '';
  String myAmount = '';
  String myDes = '';
  Future<List<String>> future = NetworkApi.getCategory();

  String dateDisplayed = 'Pick a Date';
  Future<UpdateModal>? future2;

  myShowDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2022),
            lastDate: DateTime.now())
        .then((value) {
      setState(() {
        var data = value!;
        dateDisplayed = "${data.day}/${data.month}/${data.year}";
        myMonth = data.month.toString();
        myYear = data.year.toString();
        myDate = data.day.toString();
      });
    });
  }

  TextEditingController amountController = TextEditingController();
  TextEditingController desController = TextEditingController();

  List<String> category = [];
  String display = 'Select Category';

  check() {
    if (amountController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please enter a valid amount')));
    } else if (desController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please give a short description')));
    } else if (myMonth == '') {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Select a Date')));
    } else if (myCat.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Select a Select a Category')));
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
                'You cannot update this value for the day are you sure?',
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancel')),
                TextButton(
                    onPressed: () {
                      myAmount=amountController.text.toString();
                      myDes = desController.text.toString();
                      future2 = NetworkApi.updateExpense(
                          myAmount, myDate, myMonth, myCat, myDes, myYear);
                      Navigator.of(context).pop();
                    },
                    child: const Text('Ok'))
              ],
            );
          });
    }
  }




  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
        return false;
      },
      child: Scaffold(
        //resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(104, 178, 252, 0.95),
          title: const Text(
            'Expense Limit',
            style: TextStyle(fontFamily: 'Georgia'),
          ),
          centerTitle: true,
        ),
        drawer: const CustomDrawer(),
        body: Center(
          child: FractionallySizedBox(
            widthFactor: 0.9,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(4, 40, 4, 0),
              child: ListView(children: [
                Container(
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
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 30, 10, 10),
                        child: RichText(
                          text: const TextSpan(
                              text: 'Update Today\'s Expense',
                              style: TextStyle(
                                  letterSpacing: 1.5,
                                  fontSize: 20.0,
                                  fontFamily: 'Georgia',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                        ),
                      ),
                      buildFutureBuilder(),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            myShowDatePicker();
                          });
                        },
                        style: ElevatedButton.styleFrom(
                            elevation: 0,
                            backgroundColor:
                                const Color.fromRGBO(104, 178, 252, 0.95),
                            shape: const StadiumBorder()),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              dateDisplayed,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2.0,
                              ),
                            ),
                            const Icon(Icons.arrow_drop_down)
                          ],
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
                          helperText: 'Enter Today\'s Expense',
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromRGBO(225, 225, 225, 1),
                            ),
                          ),
                        ),
                      ),
                      TextFormField(
                        maxLength: 100,
                        controller: desController,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          icon: Icon(Icons.description),
                          labelText: 'Description',
                          labelStyle: TextStyle(
                            letterSpacing: 2.0,
                            color: Color.fromRGBO(225, 225, 225, 1),
                          ),
                          helperText: 'Enter a short Description',
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
                              'UPDATE',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: (future2 == null)
                            ? const SizedBox(
                                height: 30,
                                width: 10,
                              )
                            : response(),
                      ),
                    ],
                  ),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }

  FutureBuilder<List<String>> buildFutureBuilder() {
    return FutureBuilder<List<String>>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          category = snapshot.data!;
          return DropdownButton<String>(
            hint: Text(display),
            items: category.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String? value) {
              setState(() {
                myCat = value!;
                display = value!;
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

  FutureBuilder<UpdateModal> response() {
    return FutureBuilder<UpdateModal>(
        future: future2,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data?.response == 'success') {
              if (snapshot.data?.note == 'notify') {
                notification(1);
              } else if (snapshot.data?.note == 'donothing') {
                notification(0);
              }
              return const Text('Successfully updated');

            } else if (snapshot.data?.response == 'AlreadySet') {
              return const Text('Already Set');
            }
          } else if (snapshot.hasError) {
            return Text(snapshot.data.toString());
          }
          return const CircularProgressIndicator();
        });
  }

  notification(int i) {
    if (i == 0) {
    } else if (i == 1) {}
  }
}


