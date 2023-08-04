import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

var beApi = "https://koperasi.onrender.com";

class HomeProvider extends ChangeNotifier {
  HomeProvider(this.ref) : super();
  final Ref ref;
  String name = "";
  bool initialPrefCall = false;
  List<dynamic> list = [];

  Future getAllParcelByStudent(phoneNumber) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var client = http.Client();
    var phone = await sharedPreferences.getString('phoneNumber');
    if (phoneNumber) {
      phone = phoneNumber;
    }
    print("phone");
    print(phone);
    var uri = Uri.parse(
        "$beApi/parcel?phone_number=${sharedPreferences.getString('phoneNumber')}");

    var response = await client.get(uri);
    var res = jsonDecode(response.body);
    if (response.statusCode == 200) {
      list = res;
      print(res);
    }
    notifyListeners();
    return;
  }
}

final homeProvider = ChangeNotifierProvider<HomeProvider>((ref) {
  return HomeProvider(ref);
});
