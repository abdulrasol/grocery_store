import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:get/get.dart';
import 'package:grocery_store/layouts/home/pages/select_location.dart';
import 'package:grocery_store/layouts/widgets/final_var.dart';
import 'package:grocery_store/services/database.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:image_picker/image_picker.dart';

// ignore: must_be_immutable
class Profile extends StatelessWidget {
  Profile({Key? key, required this.user}) : super(key: key);
  final GlobalKey _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> user;

  final _btncontroller = RoundedLoadingButtonController();
  final _dataBaseController = Get.put(DatabaseController);
  XFile? image;
  String? img;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        centerTitle: true,
        title: const Text(
          'Profile',
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
                  child: CircleAvatar(
                    child: user['image'].isEmpty
                        ? Image.network(user['image'])
                        : Image.asset('assets/images/user.png'),
                    radius: 70,
                  ),
                ),
                sizedBox,
                Obx(
                  () => profileRow(
                    value: user['name'],
                    icon: Boxicons.bx_user,
                    action: () async {},
                    field: 'name',
                  ),
                ),
                sizedBox,
                Obx(
                  () => profileRow(
                    value: user['mobile'],
                    icon: Icons.phone_android,
                    action: () async {},
                    field: 'mobile',
                  ),
                ),
                sizedBox,
                Obx(
                  () => profileRow(
                    value: user['email'],
                    icon: Boxicons.bx_at,
                    action: () async {},
                    field: 'email',
                  ),
                ),
                sizedBox,
                Obx(
                  () => profileRow(
                    value: '${user['location']['address']}',
                    icon: Boxicons.bx_location_plus,
                    action: () async {},
                    field: 'location',
                  ),
                ),
                sizedBox,
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget profileRow({
    String? value,
    String? field,
    required IconData icon,
    Function()? action,
  }) {
    value = value!.isEmpty ? 'not set yet' : value;
    return Row(
      children: [
        Icon(icon),
        const VerticalDivider(),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 24,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        IconButton(
          onPressed: () async {
            final _textController = TextEditingController(text: value);
            if (field == 'location') {
              await Get.dialog(
                const SelectLocation(),
              ).then((value) {}
                  //await _dataBaseController.user.value.updateAddress(value),
                  );
            } else {
              await Get.bottomSheet(
                SizedBox(
                  width: Get.width,
                  height: 200,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 0.1 * Get.width),
                    child: Form(
                      child: Column(
                        children: [
                          sizedBox,
                          TextFormField(
                            controller: _textController,
                            decoration: inputDecoration.copyWith(
                              prefixIcon: Icon(
                                icon,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          sizedBox,
                          RoundedLoadingButton(
                            color: color,
                            controller: _btncontroller,
                            onPressed: () async {
                              switch (field) {
                                case 'name':
                                  /* await _dataBaseController.user.value
                                      .updateName(_textController.text.trim())
                                      .then((value) => Get.back()); */
                                  break;
                                case 'email':
                                  /* await _dataBaseController.user.value
                                      .updateEmail(_textController.text.trim())
                                      .then((value) => Get.back()); */
                                  break;
                                case 'mobile':
                                  /*  await _dataBaseController.user.value
                                      .updatemobile(_textController.text)
                                      .then((value) => Get.back()); */
                                  break;
                                case 'location':
                                  Get.snackbar('title', 'message');
                                  break;
                              }
                            },
                            child: const Text(
                              'Save',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          sizedBox,
                        ],
                      ),
                    ),
                  ),
                ),
                backgroundColor: Colors.white,
              );
            }
          },
          icon: const Icon(Boxicons.bx_edit_alt),
        )
      ],
    );
  }
}
