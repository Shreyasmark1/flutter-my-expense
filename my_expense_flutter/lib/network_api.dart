import 'dart:async';
import 'dart:convert';
import 'package:my_expense_flutter/setlimitmodal.dart';
import 'package:my_expense_flutter/year_modal.dart';
import 'LoginRequest.dart';
import 'UpdateModal.dart';
import 'package:http/http.dart' as http;

class NetworkApi {
  static String baseUrl = 'http://192.168.1.6:8084/android/';
  static String? cookie;

  //************************************************login******************************************************
  static Future<LoginRequest> login(String phone, String pass) async {
    Map data = {'phone': phone, 'password': pass};
    final response = await http.post(Uri.parse('${baseUrl}Login'),
        headers: <String, String>{
          'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
        },
        body: data);
    if (response.statusCode == 200) {
      cookie = response.headers['set-cookie'];

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
    Map<String, String> header = {};
    String sendCookie = cookie.toString();
    if (sendCookie.isEmpty) {
      header = {
        'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
      };
    } else {
      header = {
        'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
        'cookie': sendCookie
      };
    }
    final response = await http.get(Uri.parse('${baseUrl}GetCategory'),
        headers: header); // body: data);
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
    Map<String, String> header = {};
    String sendCookie = cookie.toString();
    if (sendCookie.isEmpty) {
      header = {
        'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
      };
    } else {
      header = {
        'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
        'cookie': sendCookie
      };
    }
    Map data = {
      'amount': amount,
      'date': date,
      'month': month,
      'cat': cat,
      'des': des,
      'year': year,
    };

    final response = await http.post(Uri.parse('${baseUrl}DailyExpense'),
        headers: header, body: data);
    if (response.statusCode == 200) {
      return UpdateModal.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(response.body);
    }
  }

//############################################# report ########################################################
  static Future<Map<String, int>> getReport(String month, String year) async {
    var parameter = {"month": month, "year": year};
    Map<String, String> header = {};
    String sendCookie = cookie.toString();
    if (sendCookie.isEmpty) {
      header = {
        'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
      };
    } else {
      header = {
        'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
        'cookie': sendCookie
      };
    }
    Uri uri = Uri.parse('${baseUrl}Report');
    Uri newUri = uri.replace(queryParameters: parameter);

    final response = await http.get(newUri, headers: header);
    Map<String, int> list = {};
    if (response.statusCode == 200) {
      List<dynamic> c = jsonDecode(response.body);
      for (var elements in c) {
        int amount = elements["amount"];
        String category = elements["category"];
        list[category] = amount;
      }

      return list;
    } else {
      throw Exception(response.body);
    }
  }

  //############################################################set limit#######################################
  static Future<SetLimitModal> setLimit(
      String amount, String month, String year) async {
    Map<String, String> header = {};
    String sendCookie = cookie.toString();
    if (sendCookie.isEmpty) {
      header = {
        'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
      };
    } else {
      header = {
        'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
        'cookie': sendCookie
      };
    }
    Map data = {
      'amount': amount,
      'month': month,
      'year': year,
    };

    final response = await http.post(Uri.parse('${baseUrl}SetLimit'),
        headers: header, body: data);
    if (response.statusCode == 200) {
      return SetLimitModal.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(response.body);
    }
  }

//############################################get Years##################################################
  static Future<List<String>> getYears() async {
    var parameter = {"requested": "year"};
    Map<String, String> header = {};
    String sendCookie = cookie.toString();
    if (sendCookie.isEmpty) {
      header = {
        'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
      };
    } else {
      header = {
        'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
        'cookie': sendCookie
      };
    }
    Uri uri = Uri.parse('${baseUrl}Years');
    Uri newUri = uri.replace(queryParameters: parameter);
    final response = await http.get(newUri, headers: header); // body: data);
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
}
