import 'package:flutter/material.dart';
import 'package:grocery_store/layouts/authenticate/sign_in.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class Authenticate extends StatefulWidget {
  Authenticate({Key? key}) : super(key: key);
  bool showSignIn = true;

  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => const SignIn(),
      ),
    );
  }
}
