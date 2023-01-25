
import 'dart:convert';
import 'package:my_expense_flutter/year_modal.dart';
import 'LoginRequest.dart';
import 'UpdateModal.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

class NetworkApi {
  static String baseUrl = 'http://192.168.1.8:8084/android/';

  //************************************************login******************************************************
  static Future<LoginRequest> login(String phone, String pass) async {
    Map data = {'phone': phone, 'password': pass};
    final response = await http.post(Uri.parse('${baseUrl}Login'),
        headers: <String, String>{
          'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
        },
        body: data);
    if (response.statusCode == 200) {
      return LoginRequest.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(response.body);
    }
  }

  //*********************************registration**************************************************************
  static Future<LoginRequest> registration(
    String name,
    String phone,
    String email,
    String address,
    String pass,
  ) async {
    Map data = {
      'phone': phone,
      'password': pass,
      'name': name,
      'email': email,
      'address': address
    };
    final response = await http.post(Uri.parse('${baseUrl}Registration'),
        headers: <String, String>{
          'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
        },
        body: data);
    if (response.statusCode == 200) {
      var v = LoginRequest.fromJson(jsonDecode(response.body));
      return v;
    } else {
      throw Exception(response.body);
    }
  }

  //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%get category#####################################################
  static Future<List<String>> getCategory() async {
    final response = await http
        .get(Uri.parse('${baseUrl}GetCategory'), headers: <String, String>{
      'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
    }); // body: data);
    if (response.statusCode == 200) {
      List<String> category = [];
      var list = jsonDecode(response.body);
      for (var element in list) {
        var i = Years.fromJson(element);
        category.add(i.year);
      }
      return category;
    } else {
      throw Exception(response.body);
    }
  }

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    update       %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  static Future<UpdateModal> updateExpense(String amount, String date,
      String month, String cat, String des, String year) async {
    Map data = {
      'amount': amount,
      'date': date,
      'month': month,
      'cat': cat,
      'des': des,
      'year': year,
    };
    final response = await http.post(Uri.parse('${baseUrl}DailyExpense'),
        headers: <String, String>{
          'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
        },
        body: data);
    if (response.statusCode == 200) {
      return UpdateModal.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(response.body);
    }
  }
}
//############################################# report ########################################################
static Future<ReportModal>
