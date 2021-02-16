import 'package:flutter/material.dart';
import 'package:flutter_app_etab/api/ayarlarGetir.dart';
import 'package:flutter_app_etab/islemler/islemler.dart';
import 'package:flutter_app_etab/kamera.dart';
import 'package:flutter_app_etab/ui/ayarui.dart';
import 'package:flutter_app_etab/ui/login_form.dart';
import 'package:flutter_app_etab/ui/webui.dart';
import 'gonder.dart';
import 'package:flutter_app_etab/models/user.dart';

void main() => runApp(
    AtaWidget(
      islem: IslemDetay(),
      child: MyApp(),
    ));

class MyApp extends StatelessWidget {
  User kullanici = null;
  String testno = "";

  @override
  Widget build(BuildContext context) {
    AtaWidget.of(context).islem.istek();
    return MaterialApp(
      title: 'Test Okur v1',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.red[700],
      ),
      initialRoute: "webarayuz",
      routes: {
        '/': (context) => GonderWidget(),
        GonderWidget.pageRoute: (context) => GonderWidget(),
        KameraWidget.pageRoute: (context) => KameraWidget("kamera", testno),
        //TestEkle.pageRoute:(context)=>TestEkle(),
        LoginForm.pageRoute: (context) => LoginForm(),
        AyarlarUI.pageRoute: (context) => AyarlarUI(),
        //WebArayuz.pageRoute: (context) => WebArayuz(),
      },
    );
  }
}
