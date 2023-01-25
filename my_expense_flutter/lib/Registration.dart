
import 'package:flutter/material.dart';
import 'package:my_expense_flutter/network_api.dart';
import 'LoginRequest.dart';
import 'main.dart';

class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  RegistrationState createState() => RegistrationState();
}


class RegistrationState extends State<Registration> {
  Future<LoginRequest>? future;

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  myCheck(BuildContext context) {
    if (nameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please Enter a Valid Name')));
    } else if (phoneController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please Enter a Valid Phone Number')));
    } else if (passController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please Enter a Valid Password')));
    } else if (addController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please Enter a Valid Address')));
    } else if (emailController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please Enter a Valid email')));
    } else {
      future = NetworkApi.registration(
          nameController.text,
          phoneController.text,
          emailController.text,
          addController.text,
          passController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(104, 178, 252, 0.95),
        title: const Text(
          'REGISTRATION',
          style: TextStyle(fontFamily: 'Georgia'),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 30, 10, 30),
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
                  topEnd: Radius.circular(50),
                  bottomEnd: Radius.circular(50),
                  bottomStart: Radius.circular(50))),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 40, 20, 40),
            child: ListView(children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 30),
                    child: RichText(
                      text: const TextSpan(
                          text: 'CREATE A NEW ACCOUNT',
                          style: TextStyle(
                              letterSpacing: 1.5,
                              fontSize: 20.0,
                              fontFamily: 'Georgia',
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    ),
                  ),
                  TextFormField(
                      maxLength: 20,
                      controller: nameController,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.account_box_outlined),
                        labelText: 'Name',
                        labelStyle: TextStyle(
                          letterSpacing: 2.0,
                          color: Color.fromRGBO(225, 225, 225, 1),
                        ),
                        helperText: 'Enter your Name',
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromRGBO(225, 225, 225, 1),
                          ),
                        ),
                      )),
                  TextFormField(
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
                      helperText: 'Enter your Phone Number',
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromRGBO(225, 225, 225, 1),
                        ),
                      ),
                    ),
                  ),
                  TextFormField(
                    maxLength: 10,
                    controller: passController,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.password_sharp),
                      labelText: 'Password',
                      labelStyle: TextStyle(
                        letterSpacing: 2.0,
                        color: Color.fromRGBO(225, 225, 225, 1),
                      ),
                      helperText: 'Create a new Password',
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromRGBO(225, 225, 225, 1),
                        ),
                      ),
                    ),
                  ),
                  TextFormField(
                    maxLength: 20,
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.email_outlined),
                      labelText: 'Email',
                      labelStyle: TextStyle(
                        letterSpacing: 2.0,
                        color: Color.fromRGBO(225, 225, 225, 1),
                      ),
                      helperText: 'Enter your Email',
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromRGBO(225, 225, 225, 1),
                        ),
                      ),
                    ),
                  ),
                  TextFormField(
                    maxLength: 50,
                    controller: addController,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.location_on_rounded),
                      labelText: 'Address',
                      labelStyle: TextStyle(
                        letterSpacing: 2.0,
                        color: Color.fromRGBO(225, 225, 225, 1),
                      ),
                      helperText: 'Enter your Address',
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromRGBO(225, 225, 225, 1),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 50, 8.0, 30.0),
                    child: SizedBox(
                      height: 50,
                      width: 200,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            myCheck(context);
                          });
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
                    child: (future == null)
                        ? const SizedBox(
                            height: 30,
                            width: 10,
                          )
                        : buildFutureBuilder(),
                  ),
                ],
              ),
            ]),
          ),
        ),
      ),
    );
  }

  FutureBuilder<LoginRequest> buildFutureBuilder() {
    return FutureBuilder<LoginRequest>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.status == 'success') {
            return const GoBack();
          } else {
            return Container(
                padding: const EdgeInsets.all(10),
                child: const Text('Something Went Wrong'));
          }
        } else if (snapshot.hasError) {
          return Text(snapshot.data.toString());
        }
        return const CircularProgressIndicator();
      },
    );
  }
}

class GoBack extends StatefulWidget {
  const GoBack({super.key});

  @override
  GoBackState createState() => GoBackState();
}

class GoBackState extends State<GoBack> {
  myFun(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const Home()));
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => myFun(context));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: const Text('Registration Successful'),
    );
  }
}
