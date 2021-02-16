import 'package:shared_preferences/shared_preferences.dart';

abstract class Islemler {

  Future<String> istek();
  String adres;
}

class IslemDetay implements Islemler {

  @override
  String adres;

  @override

  Future<String> istek() async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    await _prefs.then((SharedPreferences prefs) {
      adres= prefs.get('ipadres' ?? null);
      //print(adres);
    });
    return adres;
  }



}
