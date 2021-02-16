import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AyarlarUI extends StatefulWidget {
  static final String pageRoute = 'ayarlar';

  @override
  _AyarlarUIState createState() => _AyarlarUIState();
}

class _AyarlarUIState extends State<AyarlarUI> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  var nameController = new TextEditingController();
  String _ipadres;
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _prefs.then((SharedPreferences prefs){
      debugPrint(prefs.get('ipadres'??null));
      _ipadres=prefs.get('ipadres'??null);
      nameController.text = _ipadres;
    });

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            Text('Ayarlar'),
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'İp adresi:',
                      hasFloatingPlaceholder: true,
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'test adı giriniz';
                      }
                      return null;
                    },
                    onSaved: (val) => _ipadres = val,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        RaisedButton(
                          color: Colors.red,
                          onPressed: () {
                            Navigator.pop(context,_ipadres);
                          },
                          child: Text('İptal'),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        RaisedButton(
                          color: Colors.green.shade500,
                          onPressed: () {
                            _kaydet();
                          },
                          child: Text('Kaydet'),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }

  void _kaydet() async {
    _formKey.currentState.save();
    //await (mySharedPrefences as SharedPreferences).setString('ipadres', _ipadres);
    _prefs.then((SharedPreferences prefs){
      prefs.setString('ipadres',_ipadres);
    });
    Navigator.pop(context,_ipadres);
  }

}
