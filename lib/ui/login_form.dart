import 'package:flutter/material.dart';
import 'package:flutter_app_etab/api/ayarlarGetir.dart';
import 'package:flutter_app_etab/api/loginApi.dart';
import 'package:flutter_app_etab/models/user.dart';
import 'package:flutter_app_etab/widgets/buton_widget.dart';
import 'package:flutter_icons/flutter_icons.dart';

class LoginForm extends StatefulWidget {
  static final String pageRoute = "loginform";

  LoginForm({Key key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  var _formKey = GlobalKey<FormState>();
  String _kullaniciadi;
  String _password;

  User _kullanici;
  var passwordController = new TextEditingController();
  var usernameController = new TextEditingController();
  final FocusNode _usernameFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _logibbutonFocus = FocusNode();
  var _showCircularProgressIndicator = false;
  String siteUrl;

@override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    siteUrl=AtaWidget.of(context).islem.adres;
    debugPrint('login'+siteUrl);

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _kullanici = null;
    _showCircularProgressIndicator = false;
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
            padding: EdgeInsets.all(20),
            width: double.infinity,
            color: Colors.white,
            child: Form(
              key: _formKey,
              child: Column(
                //rossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextFormField(
                    focusNode: _usernameFocus,
                    controller: usernameController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      hintText: 'kullanıcı adını giriniz',
                    ),
                    onFieldSubmitted: (term) {
                      _fieldFocusChange(
                          context, _usernameFocus, _passwordFocus);
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'kullanıcı adını  giriniz';
                      }
                      return null; // _formKey.currentState.save();
                    },
                    onSaved: (val) => _kullaniciadi = val,
                  ),
                  TextFormField(
                    obscureText: true,
                    keyboardType: TextInputType.number,
                    focusNode: _passwordFocus,
                    controller: passwordController,
                    decoration: const InputDecoration(
                      hintText: 'parola',
                    ),
                    onFieldSubmitted: (term) {
                      _fieldFocusChange(
                          context, _usernameFocus, _logibbutonFocus);
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'parolanızı giriniz';
                      }
                      return null;
                    },
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: buildLoginbuton(_formKey)),
                  _showCircularProgressIndicator? CircularProgressIndicator(): Container(),
                ],
              ),
            )),
      ),
    );
  }

  buildLoginbuton(_formKey) => ButtonWidget(
      focusNode: _logibbutonFocus,
      butonText: "Login Ol",
      butonIcon: Icon(MaterialIcons.camera, color: Colors.white, size: 32),
      onPressed: () {
        if (_formKey.currentState.validate()) {
          _formKey.currentState.save();
          _showCircularProgressIndicator=true;
          _kullaniciadi = usernameController.text;
          _password = passwordController.text;
          debugPrint(_kullaniciadi + " " + _password+""+siteUrl);
          LoginOl(siteUrl,_kullaniciadi, _password).then((okunankullanici) {
            _kullanici = okunankullanici;
            debugPrint("gelen:" + _kullanici.toString());

            _showCircularProgressIndicator=false;
            Navigator.pop(context,_kullanici);

          });

        }

          //Navigator.pop(context,_kullanici);

      });


}

_fieldFocusChange(
    BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
  currentFocus.unfocus();
  FocusScope.of(context).requestFocus(nextFocus);
}
