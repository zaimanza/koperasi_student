import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_parcel/providers/student_provider.dart';

var beApi = "https://koperasi.onrender.com";

class AuthenticationProvider extends ChangeNotifier {
  AuthenticationProvider(this.ref) : super();
  final Ref ref;
  String name = "";
  String studentId = "";
  String password = "";
  String token = "";
  String phoneNumber = "";
  bool initialPrefCall = false;

  setName(name) async {
    this.name = name;
  }

  setStudentId(studentId) async {
    this.studentId = studentId;
  }

  setPassword(password) async {
    this.password = password;
  }

  setPhoneNumber(phoneNumber) async {
    this.phoneNumber = phoneNumber;
  }

  Future getSharedPreference() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getString('name') != null) {
      name = sharedPreferences.getString('name')!;
    }
    if (sharedPreferences.getString('studentId') != null) {
      studentId = sharedPreferences.getString('studentId')!;
    }
    if (sharedPreferences.getString('password') != null) {
      password = sharedPreferences.getString('password')!;
    }
    if (sharedPreferences.getString('phoneNumber') != null) {
      phoneNumber = sharedPreferences.getString('phoneNumber')!;
    }

    initialPrefCall = true;
    notifyListeners();
  }

  postStudentLogin() async {
    var client = http.Client();

    var uri = Uri.parse("$beApi/user/login");
    var response = await client.post(
      uri,
      body: {"studentId": studentId, "password": password},
    );

    var res = jsonDecode(response.body);

    if (response.statusCode == 200) {
      print(res);
      ref.read(studentProvider).setAuthenticationToken(res);

      return true;
    }

    var responded = res["message"] ?? "There is an error in the server";
    return responded;
  }

  postStudentRegister() async {
    var client = http.Client();

    var uri = Uri.parse("$beApi/user/register");
    var newPhoneNumber = phoneNumber;
    if (newPhoneNumber.startsWith("0")) {
      newPhoneNumber = "6" + newPhoneNumber;
    }
    print({
      "name": name,
      "studentId": studentId,
      "password": password,
      "phoneNumber": newPhoneNumber
    });
    var response = await client.post(
      uri,
      body: {
        "name": name,
        "studentId": studentId,
        "password": password,
        "phoneNumber": newPhoneNumber
      },
    );
    var res = jsonDecode(response.body);

    if (response.statusCode == 200) {
      print(res);
      ref.read(studentProvider).setAuthenticationToken(res);
      return true;
    }

    var responded = res["message"] ?? "There is an error in the server";
    return responded;
  }
}

final authenticationProvider =
    ChangeNotifierProvider<AuthenticationProvider>((ref) {
  return AuthenticationProvider(ref);
});
