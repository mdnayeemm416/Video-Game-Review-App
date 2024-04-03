import 'package:flutter/material.dart';
import 'package:videogame_review_app/App_Constant/app_constant.dart';
import 'package:videogame_review_app/View/Authentication/sign_up.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    final Height = MediaQuery.of(context).size.height;
    final Width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        height: Height,
        width: Width,
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
          Color.fromARGB(255, 75, 2, 104),
          Color.fromARGB(255, 138, 68, 150)
        ])),
        child: SingleChildScrollView(
          child: Column(children: [
            Container(
              margin: EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "images/signup.png",
                    height: AppSize.height(context) * .55,
                  ),
                ],
              ),
            ),
            const SignUpPage()
          ]),
        ),
      ),
    );
  }
}
