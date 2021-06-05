import 'package:flutter/services.dart';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'package:stegnographer/constants.dart';
import 'package:stegnographer/main.dart';

class DecryptPage extends StatefulWidget {
  DecryptPage(this.decryptedMsg);

  final decryptedMsg;

  @override
  _DecryptPageState createState() => _DecryptPageState();
}

class _DecryptPageState extends State<DecryptPage> {
  Future<void> _showMyDialog(String txt) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: kScaffoldColor,
            title: Text(
              'Success',
              style: TextStyle(
                fontSize: 18.0.sp,
                color: kAccentColor,
              ),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(
                    txt,
                    style: TextStyle(
                      fontSize: 15.0.sp,
                      fontFamily: kFontFamily,
                      color: kAccentColor,
                    ),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text(
                  'OK',
                  style: TextStyle(
                    fontSize: 15.0.sp,
                    fontFamily: kFontFamily,
                    color: kAccentColor,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return HomePage();
                    }),
                  );
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            'StegnoGrapher',
            style: TextStyle(
              fontFamily: kFontFamily,
              fontSize: 20.0.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    alignment: Alignment.center,
                    width: double.maxFinite,
                    margin: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                      border: Border.all(
                        color: kAccentColor,
                        width: 2.0,
                      ),
                    ),
                    child: Text(
                      'Hello Flutter',
                      // widget.decryptedMsg == '' ? 'No Text Found' : widget.decryptedMsg,
                      style: TextStyle(
                        fontFamily: kFontFamily,
                        fontSize: 20.0.sp,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ActionButtonContainer(
                    margin: 10.0,
                    icn: Icons.copy,
                    btnLabel: 'Copy to Clipboard',
                    w: 25.0.h,
                    h: 15.0.h,
                    backgroundColor: Color(0xFF170633),
                    onPressed: () async {
                      ClipboardData data =
                          ClipboardData(text: widget.decryptedMsg);
                      await Clipboard.setData(data);

                      _showMyDialog('Message copied to Clipboard');
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
