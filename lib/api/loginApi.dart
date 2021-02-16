import 'dart:convert';
import 'package:flutter_app_etab/models/test.dart';
import 'package:flutter_app_etab/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';





Future<User> LoginOl(String siteUrl, String username, String password) async {
  debugPrint('loginol '+siteUrl + "loginm");
  var response = await http.post(siteUrl + "/loginm",
      body: {'username': username, 'password': password});
  if (response.statusCode == 200) {
    debugPrint(response.body);
    return User.fromJson(json.decode(response.body));
  } else {
    throw Exception("Bağlanamadık ${response.statusCode}");
  }
}


Future<List<Test>> TestleriGetir(String siteUrl,User kullanici) async {
  var response = await http.post(siteUrl + "/testlerm",
      body: {'username': kullanici.username, 'password': kullanici.password});
  if (response.statusCode == 200) {
    debugPrint(response.body);
    //return Test.fromJson(json.decode(response.body));
    return (json.decode(response.body) as List).map((tekgonderi)=>Test.fromJson(tekgonderi)).toList();
  } else {
    throw Exception("Bağlanamadık ${response.statusCode}");
  }
}


Future<Test> TestEkleDb(String siteUrl,User user,String name,String cevaplar) async {
  var response = await http.post(siteUrl + "/testeklem",
      body: {"id": user.id,"password": user.password,"username": user.username,'cevaplar':cevaplar, 'name':name});
  if (response.statusCode == 200) {
    debugPrint(response.body);
    return Test.fromJson(json.decode(response.body));
  } else {
    throw Exception("Bağlanamadık ${response.statusCode}");
  }
}

Future<List<Test>> TestSilDb(String siteUrl,User user,String testid) async {
  var response = await http.post(siteUrl + "/testsilm",
      body: {"id": user.id,"password": user.password,"username": user.username,'testid':testid});
  if (response.statusCode == 200) {
    debugPrint(response.body);
    return (json.decode(response.body) as List).map((tekgonderi)=>Test.fromJson(tekgonderi)).toList();
  } else {
    throw Exception("Bağlanamadık ${response.statusCode}");
  }
}
Future<Test> TestEditDb(String siteUrl,User user,String testid,String name,String cevaplar) async {
  var response = await http.post(siteUrl + "/testeditm",
      body: {"id": user.id,"password": user.password,"username": user.username,'cevaplar':cevaplar, 'name':name,'testid':testid});
  if (response.statusCode == 200) {
    debugPrint(response.body);
    return Test.fromJson(json.decode(response.body));
  } else {
    throw Exception("Bağlanamadık ${response.statusCode}");
  }
}