import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_etab/api/ayarlarGetir.dart';
import 'package:flutter_app_etab/models/test.dart';
import 'package:flutter_app_etab/models/user.dart';
import 'package:flutter_app_etab/sabitler.dart';
import 'package:flutter_app_etab/api/loginApi.dart';

class TestEkleM extends StatefulWidget {
  static final String pageRoute = "testeklem";
  Test _test;
  User _kullanici;


  TestEkleM(this._kullanici, this._test);

  @override
  _TestEkleMState createState() => _TestEkleMState(_kullanici, _test);
}

class _TestEkleMState extends State<TestEkleM> {
  Test _test;
  User _kullanici;

  _TestEkleMState(this._kullanici, this._test);

  String _name;
  String _cevaplar;
  String _testid;

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  int maxlength = 30;
  int currentLength = 0;
  var nameController = new TextEditingController();
  var cevaplarController = new TextEditingController();
  var formislem = "testekle";
  String siteUrl;

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
    _test == null ? formislem = "testekle" : formislem = "testduzenle";
    debugPrint(formislem);
    formislem == "testduzenle"
        ? nameController.text = _test.name.toString()
        : null;
    formislem == "testduzenle"
        ? cevaplarController.text = _test.cevaplar.toString()
        : null;
    formislem == "testduzenle" ? _testid = _test.id.toString() : null;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          key: _scaffoldKey,
          body: Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height * .35,
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          height: (MediaQuery.of(context).size.height * .3),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(0, 2),
                                blurRadius: 50,
                                color: kShadowColor,
                              )
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: 5,
                        left: 15,
                        right: 15,
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: <Widget>[
                              TextFormField(
                                controller: nameController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Test Adı:',
                                  hasFloatingPlaceholder: true,
                                ),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'test adı giriniz';
                                  }
                                  return null;
                                },
                                onSaved: (val) => _name = val,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              TextFormField(
                                controller: cevaplarController,
                                onChanged: (value) {
                                  cevaplarController.value = TextEditingValue(
                                      text: value.toUpperCase(),
                                      selection: cevaplarController.selection);
                                },
                                keyboardType: TextInputType.text,
                                maxLength: maxlength,
                                decoration: InputDecoration(
                                  labelText: 'Cevaplar:',
                                  border: OutlineInputBorder(),
                                  hasFloatingPlaceholder: true,
                                ),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'cevapları giriniz';
                                  }
                                  return null;
                                },
                                onSaved: (val) => _cevaplar = val,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    RaisedButton(
                                      color: Colors.red,
                                      onPressed: () {Navigator.pop(context);},
                                      child: Text('İptal'),
                                    ),
                                    SizedBox(width: 5,),
                                    RaisedButton(
                                      color: Colors.green.shade500,
                                      onPressed: () {
                                        FocusScope.of(context).unfocus();
                                        if (_formKey.currentState.validate()) {
                                          _formKey.currentState.save();
                                          //_showCircularProgressIndicator=true;

                                          formislem == "testduzenle"
                                              ? TestEditDb(siteUrl,_kullanici, _testid,
                                                      _name, _cevaplar)
                                                  .then((duzenlenentest) {
                                                  _test = duzenlenentest;
                                                  debugPrint("gelen:" +
                                                      _test.toString());
                                                  final snackBar = SnackBar(
                                                    content: Text(
                                                        'Kayıt Düzenlendi!'),
                                                    action: SnackBarAction(
                                                      label: 'Kapat',
                                                      onPressed: () {
                                                        // Some code to undo the change.
                                                        Navigator.pop(context);
                                                      },
                                                    ),
                                                  );
                                                  _scaffoldKey.currentState
                                                      .showSnackBar(snackBar);
                                                })
                                              : TestEkleDb(siteUrl,_kullanici, _name,
                                                      _cevaplar)
                                                  .then((eklenenTest) {
                                                  _test = eklenenTest;
                                                  debugPrint("gelen:" +
                                                      _test.toString());
                                                  final snackBar = SnackBar(
                                                    content:
                                                        Text('Kayıt Eklendi!'),
                                                    action: SnackBarAction(
                                                      label: 'Kapat',
                                                      onPressed: () {
                                                        // Some code to undo the change.
                                                        Navigator.pop(context);
                                                      },
                                                    ),
                                                  );
                                                  _scaffoldKey.currentState
                                                      .showSnackBar(snackBar);
                                                });

                                          // Find the Scaffold in the widget tree and use
                                          // it to show a SnackBar.

                                          // Process data.

                                        }
                                      },
                                      child: Text('Kaydet'),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
