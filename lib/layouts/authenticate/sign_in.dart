import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:get/get.dart';
import 'package:grocery_store/layouts/widgets/final_var.dart';
import 'package:grocery_store/services/auth_controller.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

// ignore: must_be_immutable
class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final GlobalKey<FormState> _numberKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _codeKey = GlobalKey<FormState>();
  final _mobile = TextEditingController();
  final _sms = TextEditingController();
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();
  String? _verificationId;
  //final AuthController _authController = Get.find();
  //final _auth = FirebaseAuth.instance;

  bool smsCodeActice = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(CupertinoIcons.back, color: Colors.black),
          onPressed: () {
            Get.back();
          },
        ),
        actions: [
          //const CartIcon(),
          IconButton(
            color: Colors.black,
            onPressed: () {},
            icon: const Icon(Boxicons.bx_search_alt),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 100),
              child: Column(
                children: [
                  SizedBox(
                    width: 150,
                    height: 150,
                    child: Image.asset('assets/images/logo.png'),
                  ),
                  sizedBox,
                  Container(
                    decoration: BoxDecoration(
                      border: const Border(
                        bottom: boxBorder,
                        top: boxBorder,
                        left: boxBorder,
                        right: boxBorder,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 40, horizontal: 20),
                    width: 300,
                    child: Column(
                      children: [
                        const Text(
                          'Welcome Back',
                          style: TextStyle(
                            fontSize: 24,
                          ),
                        ),
                        sizedBox,
                        Form(
                          key: _numberKey,
                          child: TextFormField(
                            controller: _mobile,
                            validator: (val) {
                              if (val!.isEmpty) {
                                return 'Enter your mobile number';
                              } else if (val.length < 11) {
                                return 'Phone number should be 11 numbers';
                              } else if (!val.isNum) {
                                return 'Enter valid phone number';
                              } else {
                                return null;
                              }
                            },
                            keyboardType: TextInputType.phone,
                            decoration: textEditField.copyWith(
                              prefixIcon:
                                  const Icon(Icons.phone_android, color: color),
                              label: const Text('Phone Number'),
                              hintText: '07xxxxxxxxx',
                              enabled: !smsCodeActice,
                            ),
                            onFieldSubmitted: (val) {},
                          ),
                        ),
                        sizedBox,
                        Form(
                          key: _codeKey,
                          child: TextFormField(
                            controller: _sms,
                            keyboardType: TextInputType.number,
                            validator: (val) {
                              if (val!.isEmpty) return 'enter sms PIN';
                            },
                            decoration: textEditField.copyWith(
                              prefixIcon: const Icon(
                                  Boxicons.bx_message_alt_dots,
                                  color: color),
                              label: const Text('SMS code'),
                              hintText: 'xxxxxx',
                              enabled: smsCodeActice,
                            ),
                          ),
                        ),
                        sizedBox,
                        RoundedLoadingButton(
                          borderRadius: 8,
                          color: Colors.black87,
                          onPressed: () {},
                          controller: _btnController,
                          child: Text(smsCodeActice ? 'Verfiy' : 'Next'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void verfiyNumber() async {
    if (_numberKey.currentState!.validate()) {
    } else {
      _btnController.reset();
    }
  }
}
