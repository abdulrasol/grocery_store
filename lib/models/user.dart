import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class User {
  final String id;
  final String? name;
  final List? location;
  final String? email;
  final List? orders;
  late final String mobile;
  late final String picture;

  User({
    required this.id,
    this.name,
    this.location,
    this.orders,
    this.email,
  }) {
    mobile = FirebaseAuth.instance.currentUser!.phoneNumber!;

    picture =
        "https://www.shareicon.net/data/512x512/2016/09/01/822711_user_512x512.png";
  }

  User.fromJson(Map<String, dynamic> json)
      : this(
          id: json['id']! as String,
          name: json['name']! as String,
          location: json['location']! as List,
          orders: json['orders']! as List,
          email: json['email']! as String,
        );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'orders': orders,
      'location': location,
      'email': email,
    };
  }

  Future updateName(String name) async {
    FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .update({'name': name});
  }

  Future updateEmail(String email) async {
    FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .update({'email': email});
  }

  Future updatemobile(String name) async {
    FirebaseAuth.instance.currentUser!.delete();
  }

  Future updateAddress(LatLng latLng) async {
    dynamic a =
        await placemarkFromCoordinates(latLng.latitude, latLng.longitude);
    a = a.first.street!;
    FirebaseFirestore.instance.collection('users').doc(id).update({
      'location': [a, GeoPoint(latLng.latitude, latLng.longitude)]
    });
  }
}
