import 'package:flutter/material.dart';
import 'package:flutter_app_etab/islemler/islemler.dart';

/*
class AyarlariGetir {
  String _ipadress;

 ipadressGetir() async{
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
   await _prefs.then((SharedPreferences prefs) {
      debugPrint(prefs.get('ipadres' ?? null));
      _ipadress = prefs.get('ipadres' ?? null);
    });
    return _ipadress.toString();
  }
}
*/



class AtaWidget extends InheritedWidget{
  final String baslik = 'Ata başlık';
  final Islemler islem;


  const AtaWidget({
    Key key,
    @required Widget child,
    this.islem,
  }): super(key: key, child: child);


  static AtaWidget of(BuildContext context) {
   return context.dependOnInheritedWidgetOfExactType<AtaWidget>();
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

}
