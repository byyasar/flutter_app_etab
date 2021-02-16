import 'package:flutter/material.dart';
import 'package:flutter_app_etab/api/ayarlarGetir.dart';
import 'package:flutter_app_etab/models/test.dart';
import 'package:flutter_app_etab/models/user.dart';
import 'package:flutter_app_etab/api/loginApi.dart';
import 'package:flutter_app_etab/sabitler.dart';
import 'package:flutter_app_etab/ui/testekle.dart';


class TestEkle extends StatefulWidget {
  static final String pageRoute = "testekle";
  User _kullanici;

  TestEkle(this._kullanici);

  @override
  _TestEkleState createState() => _TestEkleState(_kullanici);
}

class _TestEkleState extends State<TestEkle> {
  User _kullanici;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  _TestEkleState(this._kullanici);
  String siteUrl;
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    siteUrl=AtaWidget.of(context).islem.adres;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      floatingActionButton: _floatactButton,
      resizeToAvoidBottomPadding: false, //klavye hatası
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Container(
            width: double.infinity,
            color: Colors.white70,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[

                Center(
                    child: Text("Kayıtlı Testler",
                        style: TextStyle(
                          fontSize: 24,
                        ))),
                SizedBox(height: 10),
                TestListesi(_kullanici, _scaffoldKey),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget get _floatactButton => FloatingActionButton.extended(
    label: Text('Test Ekle',style: TextStyle(fontWeight: FontWeight.bold),),
        icon: Icon(Icons.add),
        onPressed: fabPressed2,
      );

  void fabPressed() {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
        context: context,
        builder: (context) => bottomSheet);
  }

  void fabPressed2() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => Container(child: TestEkleM(_kullanici, null))));
  }

  Widget get bottomSheet => Container(
        height: 150,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Divider(
              thickness: 3,
              indent: 100,
              endIndent: 100,
              //color: Colors.red,
            ),
            RaisedButton(
                child: Text('Test Ekle'),
                onPressed: () {
                  debugPrint("Testekle");
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => TestEkleM(_kullanici, null)));
                })
          ],
        ),
      );
}

class TestListesi extends StatefulWidget {
  User kullanici;
  var _scaffoldKey = GlobalKey<ScaffoldState>();

  TestListesi(this.kullanici, this._scaffoldKey);

  @override
  _TestListesiState createState() => _TestListesiState(kullanici, _scaffoldKey);
}

class _TestListesiState extends State<TestListesi> {
  User _user;
  var _scaffoldKey = GlobalKey<ScaffoldState>();

  _TestListesiState(this._user, this._scaffoldKey);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //TestleriGetir(_user);
  }
  String siteUrl;
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    siteUrl=AtaWidget.of(context).islem.adres;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.amber,
      height: MediaQuery.of(context).size.height * .8,
      child: _futurebuilder(),
    );
  }

  ListTile buildListTile(AsyncSnapshot<List<Test>> snapshot, int index) {
    return ListTile(
        onTap: () {
          //debugPrint("list tıklandı $index");
          //debugPrint( snapshot.data[index].toString());
        },
        contentPadding: EdgeInsets.all(1),
        leading: Container(
          height: MediaQuery.of(context).size.height * .8,
          width: MediaQuery.of(context).size.width * .9,
          //color: Colors.lightBlue,
          child: Row(
            children: <Widget>[
              Container(
                  width: 32,
                  height: 32,
                  //alignment: Alignment.center,
                  child: CircleAvatar(
                    child: Text(snapshot.data[index].id.toString()),
                  )),
              SizedBox(
                width: 5,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Test Adı :${snapshot.data[index].name}",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width * .5,
                      child: Text(
                        snapshot.data[index].cevaplar,
                        style: TextStyle(),
                        softWrap: true,
                      )),
                ],
              ),
              SizedBox(
                width: 5,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.edit,
                      color: Colors.lightBlue,
                    ),
                    onPressed: () {
                      var _test = snapshot.data[index];
                      TestEkleformAc(_test);
                    },
                  )      ,
                  IconButton(
                    icon: Icon(
                      Icons.check_circle_outline,
                      color: Colors.lightBlue,
                    ),
                    onPressed: () {
                      Test _secilenTest = snapshot.data[index];
                      debugPrint("seçilen test"+_secilenTest.id.toString());
                      //TestEkleformAc(_test);
                      Navigator.pop(context,_secilenTest);
                    },
                  ),
                ],
              ),
            ],
          ),
        ));
  }

  Widget _customCard(snapshot, index) => Card(
        //color: Colors.red,
        child: Container(
          height: 60,
          child: Column(mainAxisSize: MainAxisSize.max, children: <Widget>[
            buildListTile(snapshot, index),
          ]),
        ),
      );

  Widget _dismiss(Widget child, String key) {
    return Dismissible(
      key: UniqueKey(),
      child: child,
      secondaryBackground: Padding(
        padding: const EdgeInsets.fromLTRB(8.0, 0, 50, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Icon(Icons.delete, color: Colors.red),
            Text('Sil'),
          ],
        ),
      ),
      direction: DismissDirection.endToStart,
      background: Container(color: Colors.red),
      onDismissed: (dismissDirection) {
        debugPrint(dismissDirection.toString());
        AlertDialog dialog = new AlertDialog(
          title: new Text("Silme işlemi"),
          content: new Text(
            "Silmek istediğinize emin misiniz? Bu işlemi geri alamazsınız.",
            style: new TextStyle(fontSize: 12.0),
          ),
          actions: <Widget>[
            new FlatButton(
                color:Colors.red,
                onPressed: () async {
                  await TestSilDb(siteUrl,_user, key).then((onValue) {});
                  setState(() {});
                  Navigator.of(context).pop();
                },
                child: new Text('Evet')),
            new FlatButton(
              color: Colors.green,
                onPressed: () {
                  setState(() {
                    _futurebuilder();
                  });
                  Navigator.of(context).pop();
                },
                child: new Text('Hayır')),
          ],
        );
        showDialog(context: context, child: dialog);
      },
    );
  }

  Widget _futurebuilder() => FutureBuilder(
      future: TestleriGetir(siteUrl,_user),
      builder: (BuildContext context, AsyncSnapshot<List<Test>> snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return Container(
                  //color: Colors.amber,
                  child: _dismiss(_customCard(snapshot, index),
                      snapshot.data[index].id.toString()),
                );
              });
        } else {
          return Center(child: CircularProgressIndicator());
        }
      });

  void TestEkleformAc(Test _test) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => Container(child: TestEkleM(_user, _test))));
  }
}
