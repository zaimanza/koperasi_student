import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StudentProvider extends ChangeNotifier {
  StudentProvider(this.ref) : super();
  final Ref ref;
  String name = "";
  String studentId = "";
  String password = "";
  String phoneNumber = "";
  String token = "";
  bool initialPrefCall = false;

  initState() async {
    if (initialPrefCall == false) {
      getSharedPreference();
    }
  }

  // setStudent(name, studentId, password, token,) async {
  //   this.name = name;
  //   this.studentId = studentId;
  //   this.password = password;
  //   this.token = token;
  //   notifyListeners();
  //   syncSharedPreference();
  // }

  Future getSharedPreference() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getString('name') != null) {
      name = sharedPreferences.getString('name')!;
    }
    if (sharedPreferences.getString('studentId') != null) {
      studentId = sharedPreferences.getString('studentId')!;
    }
    if (sharedPreferences.getString('phoneNumber') != null) {
      phoneNumber = sharedPreferences.getString('phoneNumber')!;
    }
    if (sharedPreferences.getString('password') != null) {
      password = sharedPreferences.getString('password')!;
    }
    if (sharedPreferences.getString('token') != null) {
      token = sharedPreferences.getString('token')!;
    }

    initialPrefCall = true;
    notifyListeners();
  }

  syncSharedPreference() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    await sharedPreferences.setString('name', name);
    await sharedPreferences.setString('studentId', studentId);
    await sharedPreferences.setString('phoneNumber', phoneNumber);
    await sharedPreferences.setString('password', password);
    await sharedPreferences.setString('token', token);
  }

  Future setAuthenticationToken(res) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    await sharedPreferences.setString('name', res["name"]);
    name = res["name"];
    await sharedPreferences.setString('studentId', res["studentId"]);
    studentId = res["studentId"];
    await sharedPreferences.setString('phoneNumber', res["phoneNumber"]);
    phoneNumber = res["phoneNumber"];
    await sharedPreferences.setString('token', res["token"]);
    token = res["token"];
    initialPrefCall = true;
    notifyListeners();
  }

  Future deleteAuthenticationToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    await sharedPreferences.remove('token');
    token = "";
    initialPrefCall = true;
    notifyListeners();
  }
}

final studentProvider = ChangeNotifierProvider<StudentProvider>((ref) {
  return StudentProvider(ref);
});
