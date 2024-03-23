import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:thegrandemarche/main.dart';
import 'package:thegrandemarche/screens/home.dart';

class TgmLogin extends StatefulWidget {
  const TgmLogin({super.key});

  @override
  State<TgmLogin> createState() => _TgmLoginState();
}

class _TgmLoginState extends State<TgmLogin> {
  @override
  Widget build(BuildContext context) {
    bool? _foo = false;
    final _formKey = GlobalKey<FormState>();
    final namecontroller = TextEditingController();
    final passwordcontroller = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.only(left: 20, right: 20, top: 8, bottom: 8),
          child: Form(
             key: _formKey,
            child: Column(
              children: [
                CircleAvatar(radius: 150, child: Image.asset('assets/logo.png')),
                Text(
                  "Log in your account",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                ),
                Gap(10),
                TextFormField(
                  controller: namecontroller,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return " please enter your name";
                    } else if (value.isNotEmpty) {
                      String exp = r'';
                      RegExp regex = RegExp(exp);
                      String userId = namecontroller.text;
                      if (!regex.hasMatch(userId)) {
                        return " please enter a valid name";
                      } else {
                        return null;
                      }
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xff04516f)),
                    ),
                    hintText: 'user name',
                    labelStyle: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
                Gap(10),
                TextFormField(
                  controller: passwordcontroller,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter a valid data";
                    } else if (value.isNotEmpty) {
                      String pattern =
                          r'';
                      String password = passwordcontroller.text;
                      RegExp regExp = RegExp(pattern);
                      if (!regExp.hasMatch(password)) {
                        return "Password must be at least 8 characters long ";
                      }
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xff04516f)),
                    ),
                    hintText: 'Password',
                    labelStyle: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
                Gap(10),
                Row(
                  children: [
                    Checkbox(
                        checkColor: Colors.blue,
                        value: _foo,
                        onChanged: (newvalue) {
                          setState(() {
                            _foo = newvalue!;
                          });
                        }),
                    Text("Remember me"),
                    Gap(200),
                    Text(
                      "forgot password",
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    )
                  ],
                ),
                Gap(10),
                ElevatedButton(
                    onPressed: () async {
                      {
                         final _sharedpref =
                                  await SharedPreferences.getInstance();
                              await _sharedpref.setBool(
                                  sharedPreferenceKey, true);
            
                        if (_formKey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              backgroundColor: Colors.red,
                              behavior: SnackBarBehavior.floating,
                              margin: EdgeInsets.all(20),
                              content: Text("login....."),
                            ),
                          );
            
                          // route
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) {
                                return HomeScreen();
                              },
                            ),
                          );
                        } else {}
                      }
                      ;
                    },
                    child: Text("Login"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
