import 'package:flutter/material.dart';


class ButtonWidget extends StatelessWidget {

  final String butonText;
  final Color butonColor;
  final Color butonTextColor;
  final double radius;
  final double yukseklik;
  final Widget butonIcon;
  final VoidCallback onPressed;
  final FocusNode focusNode;
  final Color disableColor;


  const ButtonWidget({Key key,
    @required this.butonText,
    this.butonColor:Colors.red,
    this.butonTextColor:Colors.white,
    this.radius:10,
    this.yukseklik:32,
    this.butonIcon,
    this.focusNode,
    this.disableColor:Colors.brown,
    this.onPressed,
  }) :assert(butonText!=null), super(key: key);





  @override
  Widget build(BuildContext context) {
    return RaisedButton(

      focusNode: focusNode,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(radius))
      ),
      color:butonColor,
      disabledColor: disableColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
         butonIcon,
         Text(butonText, style: TextStyle(fontSize: 18,color: butonTextColor),),
          Opacity(opacity:0,child: butonIcon),
        ],
      ),
      onPressed: onPressed,
    );
  }
}
