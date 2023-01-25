import 'package:flutter/material.dart';
import 'package:my_expense_flutter/LoginRequest.dart';
import 'package:my_expense_flutter/Registration.dart';
import 'package:my_expense_flutter/network_api.dart';
import 'package:my_expense_flutter/updateExpense.dart';

import 'Report.dart';
import 'SetExpenseLimit.dart';
import 'homeScreen.dart';

// Future<LoginRequest> login(String phone, String pass) async {
//   Map data = {'phone': phone, 'password': pass};
//   final response =
//       await http.post(Uri.parse('http://192.168.1.7:8084/android/Login'),
//           headers: <String, String>{
//             'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
//           },
//           body: data);
//
//   if (response.statusCode >= 200 && response.statusCode <= 299) {
//     // If the server did return a 201 CREATED response,
//     // then parse the JSON.
//     return LoginRequest.fromJson(jsonDecode(response.body));
//   } else {
//     // If the server did not return a 201 CREATED response,
//     // then throw an exception.
//     throw Exception(response.body);
//   }
// }

void main() => runApp(
      MaterialApp(
        title: 'Flutter expense app',
        theme: ThemeData(
          // Define the default brightness and colors.
          brightness: Brightness.dark,
          primaryColor: const Color.fromRGBO(104, 178, 252, 1),
          canvasColor: const Color.fromRGBO(252, 178, 104, 1),
          // Define the default font family.
          fontFamily: 'Georgia',
          // Define the default `TextTheme`. Use this to specify the default
          // text styling for headlines, titles, bodies of text, and more.
          textTheme: const TextTheme(
            headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
            headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
            bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
          ),
        ),
        home: const Home(),
        routes: {
          '/home': ((context) => const HomeScreen()),
          '/set':((context) => const ExpenseLimit()),
          '/update':((context) => const UpdateExpense()),
          '/report':((context) => const Report()),
        },
      ),
    );

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home>{
  TextEditingController phoneController = TextEditingController();
  TextEditingController passController = TextEditingController();
  Future<LoginRequest>? _future;
  bool loginStatus = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 95, 10, 10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30.0),
              child: const Image(
                image: AssetImage('images/4957136.jpg'),
              ),
            ),
          ),
          Column(mainAxisAlignment: MainAxisAlignment.end, children: [
            FractionallySizedBox(
              widthFactor: 1.0,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(2, 0, 2, 0),
                child: Container(
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
                          topEnd: Radius.circular(50))),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 40, 0, 10),
                        child: RichText(
                          text: const TextSpan(
                              text: 'LOGIN IN!',
                              style: TextStyle(
                                  letterSpacing: 1.5,
                                  fontSize: 40.0,
                                  fontFamily: 'Georgia',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                        ),
                      ),
                      FractionallySizedBox(
                        widthFactor: 0.8,
                        child: TextFormField(
                          maxLength: 10,
                          controller: phoneController,
                          keyboardType: TextInputType.phone,
                          decoration: const InputDecoration(
                            icon: Icon(Icons.phone),
                            labelText: 'Phone',
                            labelStyle: TextStyle(
                              letterSpacing: 2.0,
                              color: Color.fromRGBO(225, 225, 225, 1),
                            ),
                            helperText: 'Enter your phone number',
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromRGBO(225, 225, 225, 1),
                              ),
                            ),
                          ),
                        ),
                      ),
                      FractionallySizedBox(
                        widthFactor: 0.8,
                        child: TextFormField(
                          maxLength: 10,
                          keyboardType: TextInputType.text,
                          obscureText: true,
                          controller: passController,
                          decoration: const InputDecoration(
                            icon: Icon(Icons.password_sharp),
                            labelText: 'Password',
                            labelStyle: TextStyle(
                              letterSpacing: 2.0,
                              color: Color.fromRGBO(225, 225, 225, 1),
                            ),
                            helperText: 'Enter your Password',
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromRGBO(225, 225, 225, 1),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 85,
                        width: 250,
                        child: Padding(
                          padding:
                              const EdgeInsets.fromLTRB(8.0, 30.0, 8.0, 8.0),
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _future = NetworkApi.login(phoneController.text, passController.text);
                              });
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromRGBO(252, 178, 104, 1),
                                shape: const StadiumBorder()),
                            child: const Text('LOGIN',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 2.0,
                                )),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 85,
                        width: 250,
                        child: Padding(
                          padding:
                              const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 30.0),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Registration()),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromRGBO(252, 178, 104, 1),
                                shape: const StadiumBorder()),
                            child: const Text(
                              'REGISTER',
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
                        child: (_future == null)
                            ? const SizedBox(
                                height: 30,
                                width: 10,
                              )
                            : buildFutureBuilder(),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ]),
        ],
      ),
      //backgroundColor: Colors.white,
    );
  }

  FutureBuilder<LoginRequest> buildFutureBuilder() {
    return FutureBuilder<LoginRequest>(
      future: _future,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.status == 'success') {
            loginStatus = true;
            phoneController.clear();
            passController.clear();
            return const Login();

          } else if (snapshot.data!.status == 'failed') {
            return Container(
                padding: const EdgeInsets.all(10),
                child: const Text('Invalid Credentials'));
          }
        } else if (snapshot.hasError) {
          return Text(snapshot.data.toString());
        }
        return const CircularProgressIndicator();
      },
    );
  }
}

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {


  myFunction(BuildContext context){
    Navigator.push(
        context,
        MaterialPageRoute(
        builder: (context) => const HomeScreen()));
  }

@override
void initState() {
  super.initState();
  WidgetsBinding.instance
      .addPostFrameCallback((_) => myFunction(context));
}
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: const Text('Login Successful'),
    );
  }
}

