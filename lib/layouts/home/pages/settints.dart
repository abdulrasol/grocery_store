import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:get/get.dart';
import 'package:grocery_store/layouts/widgets/final_var.dart';
import 'package:grocery_store/services/database_dontroller.dart';
import 'package:grocery_store/services/local_controller.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:image_picker/image_picker.dart';

// ignore: must_be_immutable
class Settings extends StatelessWidget {
  Settings({Key? key, required this.user}) : super(key: key);
  final GlobalKey _formKey = GlobalKey<FormState>();
  final User user;
  final _name = TextEditingController();
  final _address = TextEditingController();
  final _email = TextEditingController();
  final _phone = TextEditingController();
  final _btncontroller = RoundedLoadingButtonController();
  final _dataBaseController = Get.put(DatabaseController());
  final LocalController _controller = Get.put(LocalController());
  XFile? image;
  String? img;

  @override
  Widget build(BuildContext context) {
    _name.text = _dataBaseController.user.value.name ?? '';
    _phone.text = user.phoneNumber!;
    _address.text = '${_dataBaseController.user.value.location![0]}';
    _email.text = user.email ?? '';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        centerTitle: true,
        title: const Text(
          'Settings',
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(CupertinoIcons.back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                sizedBox,
                Center(
                  child: Column(
                    children: [
                      Obx(
                        () => CircleAvatar(
                          backgroundImage:
                              FileImage(File(_controller.userImgae.value)),

                          /* CachedNetworkImage(
                          imageUrl:
                              "https://www.shareicon.net/data/512x512/2016/09/01/822711_user_512x512.png",
                          placeholder: (context, url) =>
                              const CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ), */
                          radius: 70,
                        ),
                      ),
                      sizedBox,
                      OutlinedButton(
                        onPressed: () async {
                          final ImagePicker _picker = ImagePicker();
                          image = await _picker.pickImage(
                              source: ImageSource.gallery);
                          _controller.userImgae.value = image!.path;
                        },
                        child: const Text('Select ',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ),
                sizedBox,
                TextFormField(
                  controller: _name,
                  decoration: inputDecoration.copyWith(
                    label: const Text('Your Name'),
                    prefixIcon: const Icon(
                      Boxicons.bx_user,
                      color: Colors.black,
                    ),
                  ),
                ),
                sizedBox,
                TextFormField(
                  controller: _phone,
                  decoration: inputDecoration.copyWith(
                    label: const Text('Your Phone'),
                    prefixIcon: const Icon(
                      Boxicons.bx_phone,
                      color: Colors.black,
                    ),
                  ),
                ),
                sizedBox,
                TextFormField(
                  controller: _email,
                  decoration: inputDecoration.copyWith(
                    label: const Text('Your Email'),
                    prefixIcon: const Icon(
                      Boxicons.bx_at,
                      color: Colors.black,
                    ),
                  ),
                ),
                sizedBox,
                TextFormField(
                  controller: _address,
                  decoration: inputDecoration.copyWith(
                    label: const Text('Your Address'),
                    prefixIcon: const Icon(
                      Boxicons.bx_location_plus,
                      color: Colors.black,
                    ),
                  ),
                ),
                sizedBox,
                RoundedLoadingButton(
                  color: color,
                  controller: _btncontroller,
                  onPressed: () {},
                  child: const Text(
                    'Save',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
