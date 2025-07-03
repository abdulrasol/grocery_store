import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:get/get.dart';
import 'package:grocery_store/layouts/authenticate/sign_in.dart';
import 'package:grocery_store/layouts/home/pages/orders.dart';
import 'package:grocery_store/layouts/home/pages/profile.dart';
import 'package:grocery_store/layouts/widgets/final_var.dart';
import 'package:grocery_store/layouts/widgets/more_card.dart';
import 'package:grocery_store/services/database.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:http/http.dart' as http;

class More extends StatelessWidget {
  More({Key? key}) : super(key: key);
  final _databaseController = Get.put(DatabaseController());
  final _btnController = RoundedLoadingButtonController();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: _databaseController.user['id'] != null
            ? [
                sizedBox,
                Center(
                  child: CircleAvatar(
                    child: Image.network(
                        _databaseController.user.value['picture'] ??
                            'assets/images/user.png'),
                    radius: 70,
                  ),
                ),
                sizedBox,
                Obx(
                  () => Text.rich(
                    TextSpan(
                      children: [
                        const TextSpan(
                          text: 'Welcome ',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: color,
                          ),
                        ),
                        TextSpan(
                          text: '${_databaseController.user.value['name']}',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                sizedBox,
                sizedBox,
                MoreCard(
                  icon: Boxicons.bxs_shopping_bags,
                  title: 'My Orders',
                  route: Orders(),
                ),
                MoreCard(
                  icon: Boxicons.bx_cog,
                  title: 'Profile',
                  route: Profile(user: _databaseController.user),
                ),
                MoreCard(
                  icon: Icons.info,
                  title: 'About',
                  route: Orders(),
                ),
                sizedBox,
                RoundedLoadingButton(
                  color: Colors.black87,
                  controller: _btnController,
                  onPressed: () async {},
                  child: const Text('Logout'),
                )
              ]
            : [
                sizedBox,
                Center(
                  child: CircleAvatar(
                    child: Image.asset('assets/images/user.png'),
                    radius: 70,
                  ),
                ),
                sizedBox,
                ElevatedButton(
                  // ignore: prefer_const_constructors
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.black),
                  ),
                  onPressed: () async {
                    Get.to(() => const SignIn());
                    /*  Uri register_url = Uri.parse(
                        'http://aynbooks.local/wp-json/wp/v2/flutter/register');
                    var body = jsonEncode({
                      'username': 'rasol1',
                      'password': '123456',
                      'email': 'wr@gs1.com'
                    });

                    var a = await http.post(
                      register_url,
                      headers: {"Content-Type": "application/json"},
                      body: body,
                    );
                    _btnController.reset();

                    var b = jsonDecode(
                      a.body
                          .replaceAll(RegExp(r''), '')
                          .replaceAll(RegExp(r'Array'), '')
                          .replaceAll(RegExp(r''), ''),
                    ); */
                    //print(b['message']);
                  },
                  child: const Text('Login / Register'),
                ),
              ],
      ),
    );
  }
}
