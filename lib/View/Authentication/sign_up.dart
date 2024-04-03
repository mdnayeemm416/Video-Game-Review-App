import 'package:flutter/material.dart';
import 'package:videogame_review_app/App_Constant/app_constant.dart';
import 'package:videogame_review_app/View/Authentication/Auth/firebase_function.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formkey = GlobalKey<FormState>();
  String username = "";
  var password = "";
  var email = "";

  bool islogin = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Form(
            key: _formkey,
            child: SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.only(left: 30, right: 30),
                child: Column(
                  children: [
                    !islogin
                        ? TextFormField(
                            style: wColor,
                            cursorColor: Colors.white54,
                            key: const ValueKey("User Name"),
                            validator: (value) {
                              if (value.toString().length <= 3) {
                                return "Please insert a proper user name";
                              } else {
                                return null;
                              }
                            },
                            onSaved: (newValue) {
                              username = newValue!;
                            },
                            decoration: InputDecoration(
                                hintText: "User Name",
                                hintStyle:
                                    const TextStyle(color: Colors.white54),
                                icon: const Icon(Icons.person),
                                iconColor: Colors.white,
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide:
                                        const BorderSide(color: Colors.white)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide:
                                        const BorderSide(color: Colors.white))))
                        : Container(),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                        key: const ValueKey("Email"),
                        style: wColor,
                        cursorColor: Colors.white54,
                        validator: (value) {
                          if (!(value.toString().contains("@"))) {
                            return "Please insert a proper Wmail";
                          } else {
                            return null;
                          }
                        },
                        onSaved: (newValue) {
                          email = newValue!;
                        },
                        decoration: InputDecoration(
                            hintText: "Email",
                            hintStyle: const TextStyle(color: Colors.white54),
                            icon: const Icon(Icons.email_rounded),
                            iconColor: Colors.white,
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide:
                                    const BorderSide(color: Colors.white)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide:
                                    const BorderSide(color: Colors.white)))),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                        key: const ValueKey("password"),
                        style: wColor,
                        cursorColor: Colors.white54,
                        validator: (value) {
                          if (value.toString().length <= 4) {
                            return "Please insert a proper password";
                          } else {
                            return null;
                          }
                        },
                        onSaved: (newValue) {
                          password = newValue!;
                        },
                        decoration: InputDecoration(
                            hintText: "Password",
                            hintStyle: const TextStyle(color: Colors.white54),
                            icon: const Icon(Icons.password),
                            iconColor: Colors.white,
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide:
                                    const BorderSide(color: Colors.white)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide:
                                    const BorderSide(color: Colors.white)))),
                  ],
                ),
              ),
            )),
        const SizedBox(
          height: 20,
        ),
        SizedBox(
          width: 200,
          height: 50,
          child: ElevatedButton(
            onPressed: () {
              if (_formkey.currentState!.validate()) {
                _formkey.currentState!.save();
                islogin
                    ? Login(email, password)
                    : signUp(email, password, username);
              }
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 226, 132, 243),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                textStyle:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            child: const Text(
              "Sign Up",
              style: wColor,
            ),
          ),
        ),
        TextButton(
            onPressed: () {
              setState(() {
                islogin = !islogin;
              });
            },
            child: Text.rich(!islogin
                ? const TextSpan(
                    text: "Already Have An Account| ",
                    style: wColor,
                    children: [
                      TextSpan(
                          text: "Sign In!",
                          style: TextStyle(color: Colors.blue)),
                    ],
                  )
                : const TextSpan(
                    text: "Create an new Account |",
                    style: wColor,
                    children: [
                      TextSpan(
                          text: "Sign UP",
                          style: TextStyle(color: Colors.blue)),
                    ],
                  )))
      ],
    );
  }
}
