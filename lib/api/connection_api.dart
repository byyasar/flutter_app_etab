import 'dart:convert';

import 'package:flutter_app_etab/api/ayarlarGetir.dart';
import 'package:flutter_app_etab/models/user.dart';
import 'package:flutter_app_etab/sabitler.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class RemoteApiKullanimi extends StatefulWidget {
  @override
  _RemoteApiKullanimiState createState() => _RemoteApiKullanimiState();
}

class _RemoteApiKullanimiState extends State<RemoteApiKullanimi> {
  String siteUrl;
  User kullanici;
  Future<User> _kullaniciGetir() async {
    var response = await http.post(siteUrl + "/loginm",
        body: {'username': 'admin@gmail.com', 'password': '12345'});

    if (response.statusCode == 200) {
      debugPrint(response.body);
      return User.fromJson(json.decode(response.body));
    }else{throw Exception("Bağlanamadık ${response.statusCode}");}
  }



  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    siteUrl=AtaWidget.of(context).islem.adres;

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _kullaniciGetir().then((okunankullanici) {
      kullanici = okunankullanici;
      debugPrint("gelen:" + kullanici.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kShadowColor,
      child: Text("Gelen kullanıcı\n" + kullanici.toString()),
    );
  }
}
