import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_app_etab/api/ayarlarGetir.dart';
import 'package:flutter_app_etab/widgets/buton_widget.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'dart:convert';
import 'package:http_parser/http_parser.dart';
import 'package:toast/toast.dart';
import 'package:flutter_native_image/flutter_native_image.dart';

class KameraWidget extends StatefulWidget {
  static final String pageRoute = "kamera";
  String yer = "";
  String testno;

  KameraWidget(this.yer, this.testno);

  @override
  _KameraWidgetState createState() => _KameraWidgetState(testno);
}

class _KameraWidgetState extends State<KameraWidget> {
  String testno;

  _KameraWidgetState(this.testno);

  bool _isButtonDisabled = false;
  File _imageFile;
  String sonuc = "";

  String ogrenciNo = "";
  String puan = "";
  String cevapAnahtari = "";
  String ogrenciCevaplari = "";
  String cevapDurumu = "";

  String _testSonuc;

  File sonucresimurl = null;

  static double opacity = 0;

  Color c1 = const Color(0xFFF263A6);
  Color c2 = const Color(0xFF403E8C);
  Color c3 = const Color(0xFF03A6A6);
  Color c4 = const Color(0xFFF29F05);
  Color c5 = const Color(0xFFD93D3D);
  String siteUrl;
  String resimUrl;
  String baseUrls;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      // _kameradanFotoCek();
      debugPrint('init ');
      sonuc = "";
      //_galeridenResimSec();
      widget.yer == "kamera" ? _kameradanFotoCek() : _galeridenResimSec();
    });
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    siteUrl = AtaWidget.of(context).islem.adres;
  }

  @override
  Widget build(BuildContext context) {
    resimUrl = "$siteUrl/static/sonuc/";
    baseUrls = "$siteUrl/yukle";
    debugPrint(testno);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Görüntü Aktar"),
      ),
      //backgroundColor: Colors.lightBlueAccent,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            sonuc = "";
            sonucresimurl = null;
          });
          debugPrint(widget.yer);
          widget.yer == "kamera" ? _kameradanFotoCek() : _galeridenResimSec();
        },
        child: Icon(Icons.add),
      ),
      body: buildOrientationBuilder(),
    );
  }

  OrientationBuilder buildOrientationBuilder() {
    return OrientationBuilder(builder: (context, orientation) {
      if (orientation == Orientation.portrait) {
        return ListView(
          children: <Widget>[
            Container(
              color: c1,
              padding: EdgeInsets.all(30),
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image(
                        height: (MediaQuery.of(context).size.height / 2) - 20,
                        width: MediaQuery.of(context).size.width - 20,
                        image: _imageFile == null
                            ? AssetImage('images/TEST.jpg')
                            : FileImage(_imageFile),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  ButtonWidget(
                    butonText: "Testi Gönder",
                    butonIcon: Icon(
                      MaterialIcons.send,
                      color: Colors.white,
                      size: 24,
                    ),
                    onPressed: _isButtonDisabled == false
                        ? null
                        : () async {
                            _startUploading();
                          },
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  buildOpacity(context),
                  SizedBox(
                    height: 15,
                  ),
                  Opacity(
                    opacity: sonuc == "" ? 0 : 1,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SonucGoster,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        );
      } else {//cihaz yan cevrilmiştir
        return Container(
          child: GridView.extent(
            //childAspectRatio: 1.2,
            maxCrossAxisExtent: (MediaQuery.of(context).size.width / 2),
            mainAxisSpacing: 5,
            crossAxisSpacing: 5.0,
            //crossAxisCount: 2,
            padding: EdgeInsets.all(5),
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image(
                        height: (MediaQuery.of(context).size.height / 2) - 20,
                        width: MediaQuery.of(context).size.width - 20,
                        image: _imageFile == null
                            ? AssetImage('images/TEST.jpg')
                            : FileImage(_imageFile),
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 2, 20, 0),
                    child: ButtonWidget(
                      butonText: "Testi Gönder",
                      butonIcon: Icon(
                        MaterialIcons.send,
                        color: Colors.white,
                        size: 24,
                      ),
                      onPressed: _isButtonDisabled == false
                          ? null
                          : () async {
                              _startUploading();
                            },
                    ),
                  ),
                ],
              ),
              SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Opacity(
                      opacity: sonucresimurl == null ? 0 : 1,
                      child: GestureDetector(
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.network(
                                //'http://10.0.3.2:5000/static/sonuc/0d9f18ca746b489d8a3fffd355cce0dc.jpg',
                                sonucresimurl == null
                                    ? AssetImage('images/TEST.jpg').toString()
                                    : _testSonuc,
                                fit: BoxFit.scaleDown,
                                height:
                                    (MediaQuery.of(context).size.height / 2) - 35,
                                width: MediaQuery.of(context).size.width - 20,
                                loadingBuilder: (BuildContext context,
                                    Widget child,
                                    ImageChunkEvent loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return Center(
                                    child: CircularProgressIndicator(
                                      value: loadingProgress.expectedTotalBytes !=
                                              null
                                          ? loadingProgress
                                                  .cumulativeBytesLoaded /
                                              loadingProgress.expectedTotalBytes
                                          : null,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          onTap: () {}),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Opacity(
                      opacity: sonuc == "" ? 0 : 1,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SonucGoster,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ], // manuel girilen children widgetler
          ),
        );
      }
    });
  }

  Opacity buildOpacity(BuildContext context) {
    return Opacity(
      opacity: sonucresimurl == null ? 0 : 1,
      child: GestureDetector(
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.network(
                //'http://10.0.3.2:5000/static/sonuc/0d9f18ca746b489d8a3fffd355cce0dc.jpg',
                sonucresimurl == null
                    ? AssetImage('images/TEST.jpg').toString()
                    : _testSonuc,
                fit: BoxFit.cover,
                height: (MediaQuery.of(context).size.height / 2) ,
                width: MediaQuery.of(context).size.width - 20,
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes
                          : null,
                    ),
                  );
                },
              ),
            ),
          ),
          onTap: () {}),
    );
  }

  Widget get SonucGoster => SingleChildScrollView(
        //scrollDirection: Axis.vertical,
        child: Container(
          height: 300,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Sonuç:",
                      style: TextStyle(fontSize: 16),
                    ),
                    SelectableText(
                      "Öğrenci No: " + ogrenciNo + "   Puan: " + puan,
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                Divider(height: 5,thickness: 2,),
                Theme(
                  data:Theme.of(context).copyWith(dividerColor: Colors.red),
                  child: DataTable(
                    //Theme.of(context).copyWith(headingRowHeight=45)
                    dividerThickness: 1,
                    headingRowHeight: 60,
                    columns: [
                      DataColumn(
                        label: RotatedBox(
                          child: Text("SıraNo"),
                          quarterTurns: 3,
                        ),
                        numeric: false,
                      ),
                      DataColumn(
                        label: RotatedBox(
                          child: Text("Doğru \nCevaplar"),
                          quarterTurns: 3,
                        ),
                        numeric: false,
                      ),
                      DataColumn(
                        label: RotatedBox(
                          child: Text("Öğrenci \nCevaplar"),
                          quarterTurns: 3,
                        ),
                        numeric: false,
                      ),
                      DataColumn(
                        label: RotatedBox(
                          child: Text("Cevap \nDurumu"),
                          quarterTurns: 3,
                        ),
                        numeric: false,
                      ),
                    ],
                    rows: rowList(),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

//Theme.of(context).copyWith(dividerColor: Colors.red)
  rowList() {
    List<DataRow> _rowList = [];
    for (var i = 0; i < cevapAnahtari.length; i++) {
      _rowList.add(DataRow(selected: true,
        cells: <DataCell>[
          DataCell(Text((i + 1).toString())),
          DataCell(Text(cevapAnahtari[i])),
          DataCell(Text(ogrenciCevaplari[i])),
          DataCell(Container(
            child: CircleAvatar(
              radius: 10,
              backgroundColor:
                  cevapDurumu[i] == 'D' ? Colors.green : Colors.red,
              child: Text(cevapDurumu[i]),
            ),
          )),
        ],
      ));
    }
    return _rowList;
  }

  Future<Map<String, dynamic>> _uploadImage(File image) async {
    debugPrint('upload image' + image.toString());
    // Find the mime type of the selected file by looking at the header bytes of the file
    final mimeTypeData =
        lookupMimeType(_imageFile.path, headerBytes: [0xFF, 0xD8]).split('/');
    // Intilize the multipart request
    final imageUploadRequest =
        http.MultipartRequest('POST', Uri.parse(baseUrls))
          ..fields['testno'] = testno;
    debugPrint('baseUrls image' + testno.toString());
    // Attach the file in the request
    final file = await http.MultipartFile.fromPath('file', _imageFile.path,
        contentType: MediaType(mimeTypeData[0], mimeTypeData[1]));
    imageUploadRequest.files.add(file);

    try {
      final streamedResponse = await imageUploadRequest.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode != 200) {
        print(response.statusCode.toString());
        return null;
      }
      final Map<String, dynamic> responseData = json.decode(response.body);
      ogrenciNo = responseData['ogrno'].toString();
      puan = responseData['puan'].toString();
      cevapAnahtari = responseData['cevapanahtari'].toString();
      ogrenciCevaplari = responseData['ogrencicevaplar'].toString();
      cevapDurumu = responseData['cevapdurum'].toString();

      sonuc = "\nÖğrenci Nu : " +
          responseData['ogrno'].toString() +
          "   Puan : " +
          responseData['puan'].toString() +
          "\nCevap Anahtarı :     " +
          responseData['cevapanahtari'].toString() +
          "\nÖğrenci Cevapları : " +
          responseData['ogrencicevaplar'].toString() +
          "\nCevap Durumu :      " +
          responseData['cevapdurum'].toString() +
          "\n";

      _testSonuc = resimUrl + responseData['resim'];
      _resetState();

      setState(() {
        debugPrint(responseData.toString());
      });
      return responseData;
    } catch (e) {
      print(e);
      return null;
    }
  }

  void _startUploading() async {
    debugPrint('start upload');
    final Map<String, dynamic> response = await _uploadImage(_imageFile);
    print(response);
    // Check if any error occured
    if (response == null || response.containsKey("error")) {
      Toast.show("Resim yükleme hatası!!!", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    } else {
      Toast.show("Resim yükleme başarılı!!!", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    }
  }

  void _kameradanFotoCek() async {
    var gelenresim = await ImagePicker.pickImage(source: ImageSource.camera);
    ImageProperties properties =
        await FlutterNativeImage.getImageProperties(gelenresim.path);
    debugPrint('Resim yuk'+properties.height.toString());
    debugPrint('Resim gen'+properties.width.toString());
    File _yeniResim = await FlutterNativeImage.compressImage(gelenresim.path,
        quality: 100, targetWidth: 752, targetHeight: 647);
    setState(() {
      _imageFile = _yeniResim;
      _isButtonDisabled = true;
    });
  }

  void _galeridenResimSec() async {
    var gelenresim = await ImagePicker.pickImage(source: ImageSource.gallery);
    //debugPrint('Gelenresim :'+gelenresim..toString());
    ImageProperties properties =
        await FlutterNativeImage.getImageProperties(gelenresim.path);
    debugPrint('Resim yuk'+properties.height.toString());
    debugPrint('Resim gen'+properties.width.toString());
    File _yeniResim = await FlutterNativeImage.compressImage(gelenresim.path,
        quality: 100, targetWidth: 752, targetHeight: 647);

    setState(() {
      _imageFile = _yeniResim;
      _isButtonDisabled = true;
      debugPrint('_isButtonDisabled $_isButtonDisabled');
    });
  }

  void _resetState() {
    debugPrint('_isButtonDisabled $_isButtonDisabled');

    _isButtonDisabled = false;
    sonucresimurl = File(_testSonuc);
    debugPrint(_testSonuc);
  }
}
