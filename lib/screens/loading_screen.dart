import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:sizer/sizer.dart';

import 'package:stegnographer/constants.dart';
import 'package:stegnographer/screens/decrypt_screen.dart';
import 'package:stegnographer/screens/encrypt_screen.dart';

class LoadingScreen extends StatefulWidget {
  LoadingScreen({required this.imgFile, this.msg, required this.sendRequest});

  final imgFile;
  final msg;
  final sendRequest;

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  String encryptUrl = 'http://192.168.1.2:5000/encrypt';
  String decryptUrl = 'http://192.168.1.2:5000/decrypt';

  @override
  void initState() {
    super.initState();
    widget.sendRequest ? getEncryptedImg() : getDecryptedImg();
  }

  Future sendRequest(String url, bool toEncrypt, {File? imgFile}) async {
    String base64Image = base64Encode(widget.imgFile.readAsBytesSync());

    final postResponse = await http.post(
      Uri.parse(url),
      body: jsonEncode(
        {
          'image': base64Image,
          'msg': widget.msg,
        },
      ),
      headers: {'Content-Type': "application/json"},
    );

    final getResponse = await http.get(Uri.parse(url));

    var getResponseData = json.decode(getResponse.body);

    var imgData, imgToDisplay, decodedMsg;

    if (toEncrypt) {
      imgData = Base64Decoder().convert(getResponseData['img']);
      imgToDisplay = Image.memory(imgData).image;
    } else {
      decodedMsg = getResponseData['decrypted_msg'];
    }

    if (toEncrypt) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) {
          return EncryptPage(encryptedImg: imgToDisplay, imgData: imgData);
        }),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) {
          return DecryptPage(decodedMsg);
        }),
      );
    }
  }

  Future getEncryptedImg() async {
    sendRequest(encryptUrl, true, imgFile: widget.imgFile);
  }

  Future getDecryptedImg() async {
    sendRequest(decryptUrl, false);
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return Scaffold(
        backgroundColor: kScaffoldColor,
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SpinKitDoubleBounce(
                  color: kAccentColor,
                  size: 25.0.w,
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  'Please wait...',
                  style: TextStyle(
                      fontFamily: kFontFamily,
                      fontSize: 18.0.sp,
                      color: kAccentColor),
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
