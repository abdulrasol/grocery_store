import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/state_manager.dart';

class AuthController extends GetxController {
  // Showing correct Page
  // auth page
  var selectedAuthPage = 0.obs;

  setSelectedAuthPage(int index) {
    selectedAuthPage.value = index;
  }

  final _auth = FirebaseAuth.instance;
  late Rx<User?> user;
  Rx<String> signInBtnText = 'Next'.obs;
  Rx<bool> textActive = false.obs;

  @override
  void onInit() {
    user = Rx<User?>(_auth.currentUser);
    user.bindStream(_auth.userChanges());
    super.onInit();
  }

  // users
  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');

  saveUserInfo() async {
    await user.value!.updatePhotoURL('photoURL');
  }

  // logout
  static Future signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
