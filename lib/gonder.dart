import 'package:flutter/material.dart';
import 'package:flutter_app_etab/api/ayarlarGetir.dart';
import 'package:flutter_app_etab/api/connection_api.dart';
import 'package:flutter_app_etab/kamera.dart';
import 'package:flutter_app_etab/models/test.dart';
import 'package:flutter_app_etab/ui/ayarui.dart';
import 'package:flutter_app_etab/ui/login_form.dart';
import 'package:flutter_app_etab/ui/testekle_ui.dart';
import 'package:flutter_app_etab/widgets/buton_widget.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_app_etab/models/user.dart';

class GonderWidget extends StatefulWidget {
  static final String pageRoute = 'gonder';

  @override
  _GonderWidgetState createState() => _GonderWidgetState();
}

class _GonderWidgetState extends State<GonderWidget> {
  User _kullanici;
  Test _secilenTest;
  bool _enabled = false;
  String _testNo;

  //AtaWidget.of(context).islem.istek();
  String serverAdres;

  //Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  //String _ipadres;

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    //debugPrint('did çalıştı');
    AtaWidget.of(context).islem.istek().then((value) {
      debugPrint('did çalıştı' + value);

      setState(() {
        serverAdres = value;
      });
    });

    //debugPrint('did çalıştı'+serverAdres);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Test Okur"),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.settings), onPressed: ayarlar)
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          //color: Colors.indigo.shade200,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              //verticalDirection: VerticalDirection.up,
              //crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          buildServercard(),
                          kullaniciCard(),
                          testbilgisiCard(),
                          SizedBox(
                            height: 10,
                          ),
                          _kullanici != null
                              ? kameraResimCek(context)
                              : Container(),
                          SizedBox(
                            height: 10,
                          ),
                          _kullanici != null
                              ? galeridenResimAc(context)
                              : Container(),
                          SizedBox(
                            height: 10,
                          ),
                          _kullanici != null ? testEkle(context) : Container(),
                          SizedBox(
                            height: 10,
                          ),
                          _kullanici == null ? loginForm(context) : Container(),
                          SizedBox(
                            height: 10,
                          ),
                          _kullanici == null
                              ? Container()
                              : loginOutForm(context),
                          //htmltest(context),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container buildServercard() {
    //serverAdres ??=AtaWidget.of(context).islem.adres;
    return Container(
      child: serverAdres != null
          ? Container(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
              height: 60,
              width: double.maxFinite,
              child: Card(
                color: Colors.red,
                elevation: 5,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(width: 2.0, color: Colors.red),
                    ),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: <Widget>[
                      Text('Server Bilgileri',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.red)),
                      Text("${serverAdres}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black)),
                    ],
                  ),
                ),
              ),
            )
          : Container(
              child: Text('server bilgilerine ulaşılamadı'),
            ),
    );
  }

  Container testbilgisiCard() {
    return Container(
      child: _kullanici != null
          ? Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  height: 60,
                  width: double.maxFinite,
                  child: Card(
                    color: Colors.red,
                    elevation: 5,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(width: 2.0, color: Colors.red),
                        ),
                        color: Colors.white,
                      ),
                      child: _secilenTest != null
                          ? Column(
                              children: <Widget>[
                                Text(
                                  'Test Bilgileri',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red),
                                ),
                                Text(
                                  "${_secilenTest.id} nolu ${_secilenTest.name.toUpperCase()} seçildi",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                              ],
                            )
                          : Row(
                              children: <Widget>[
                                Icon(
                                  Icons.block,
                                  color: Colors.red,
                                  size: 32,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  'Test seçilmedi',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                              ],
                            ),
                    ),
                  ),
                ),
              ],
            )
          : Container(),
    );
  }

  Center kullaniciCard() {
    return Center(
      child: _kullanici != null
          ? Container(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
              height: 60,
              width: double.maxFinite,
              child: Card(
                color: Colors.red,
                elevation: 5,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(width: 2.0, color: Colors.red),
                    ),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: <Widget>[
                      Text('Kullanıcı Bilgileri',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.red)),
                      Text("${_kullanici.username.toString()}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black)),
                    ],
                  ),
                ),
              ),
            )
          : Container(),
    );
  }

  ButtonWidget loginForm(BuildContext context) {
    return ButtonWidget(
      butonText: "Login ",
      butonIcon: Icon(
        Icons.account_box,
        color: Colors.white,
        size: 32,
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginForm()),
        ).then((gelenKullanici) {
          _kullanici = gelenKullanici;

          setState(() {
            debugPrint('loginden gelen kullanıcı' + gelenKullanici.toString());
          });
        });
      },
    );
  }

  ButtonWidget loginOutForm(BuildContext context) {
    return ButtonWidget(
      butonText: "Log Out",
      butonIcon: Icon(
        Icons.close,
        color: Colors.white,
        size: 32,
      ),
      onPressed: () {
        setState(() {
          _kullanici = null;
          _secilenTest = null;
          _enabled = false;
        });
      },
    );
  }

  ButtonWidget testEkle(BuildContext context) {
    return ButtonWidget(
      butonText: "Testler",
      butonIcon: Icon(
        MaterialIcons.question_answer,
        color: Colors.white,
        size: 32,
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TestEkle(_kullanici),
          ),
        ).then((gelenTest) {
          Test _gelenTest = gelenTest;
          //_testNo = _gelenTest.id.toString();
          //debugPrint('burası '+_testNo.toString());
          setState(() {
            if (_gelenTest != null) {
              _enabled = true;
              _secilenTest = _gelenTest;
              _testNo = _gelenTest.id.toString();
              //_testNo = '${_gelenTest.id} nolu ${_gelenTest.name} seçildi';
              //debugPrint(_enabled.toString());
            } else {
              _enabled = false;
              _secilenTest = null;
              //debugPrint(_enabled.toString());
            }
          });
        });
      },
    );
  }

  ButtonWidget galeridenResimAc(BuildContext context) {
    //debugPrint("buton yeniden çizild2" + _enabled.toString());
    var _onPressed;
    if (_enabled) {
      _onPressed = () {
        debugPrint('galeri seçilen test' + _testNo);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => KameraWidget("galeri", _testNo),
          ),
        );
      };
    }
    return ButtonWidget(
      butonText: "Galeriden resim seç",
      butonIcon: Icon(
        MaterialIcons.image,
        color: Colors.white,
        size: 32,
      ),
      onPressed: _onPressed,
    );
  }

  ButtonWidget kameraResimCek(BuildContext context) {
    //debugPrint("buton yeniden çizild" + _enabled.toString());
    var _onPressed;
    if (_enabled) {
      _onPressed = () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => KameraWidget("kamera", _testNo),
          ),
        );
      };
    }
    return ButtonWidget(
      butonText: "Kameradan resim çek",
      butonIcon: Icon(
        MaterialIcons.camera,
        color: Colors.white,
        size: 32,
      ),
      onPressed: _onPressed,
    );
  }

  ButtonWidget htmltest(BuildContext context) {
    return ButtonWidget(
      butonText: "RemoteApiKullanimi resim çek",
      butonIcon: Icon(
        MaterialIcons.camera,
        color: Colors.white,
        size: 32,
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RemoteApiKullanimi(),
          ),
        );
      },
    );
  }

  void ayarlar() {
    Navigator.push(
            context, MaterialPageRoute(builder: (context) => AyarlarUI()))
        .then((value) {
      debugPrint('gelen data' + value.toString());
      setState(() {
        yenile();
      });
    });
  }

  void yenile() async {
    await AtaWidget.of(context).islem.istek();
    serverAdres = AtaWidget.of(context).islem.adres;
    debugPrint('server adres' + serverAdres);
  }
}

//MyAppImage
