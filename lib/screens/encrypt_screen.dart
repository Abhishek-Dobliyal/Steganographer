import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:stegnographer/main.dart';

import '../constants.dart';

class EncryptPage extends StatefulWidget {
  EncryptPage({required this.encryptedImg, required this.imgData});

  final encryptedImg;
  final imgData;
  final isSuccessful = true;

  @override
  _EncryptPageState createState() => _EncryptPageState();
}

class _EncryptPageState extends State<EncryptPage> {
  Future<void> _showMyDialog(String header, String txt) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: kScaffoldColor,
            title: Text(
              header,
              style: TextStyle(fontSize: 18.0.sp, color: kAccentColor),
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
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) {
                    return HomePage();
                  }));
                },
              ),
            ],
          );
        });
  }

  void saveImgToGallery() async {
    Map<Permission, PermissionStatus> statuses =
        await [Permission.storage].request();

    try {
      final result = await ImageGallerySaver.saveImage(
        widget.imgData,
        quality: 100,
        name: 'Encrypted-Stegnographer',
      );
      _showMyDialog('Success', 'Image Saved Succesfully.');
      print(result);
    } catch (e) {
      _showMyDialog('Ooops...', 'Could not save Image!');
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
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
                    child: Container(
                      margin: EdgeInsets.all(10.0),
                      width: double.maxFinite,
                      height: 25.0.h,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                        border: Border.all(
                          color: kAccentColor,
                          width: 2.0,
                        ),
                      ),
                      child: Image(
                        image: widget.encryptedImg,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  ActionButtonContainer(
                    margin: 10.0,
                    icn: Icons.download,
                    btnLabel: 'Save to Gallery',
                    w: 22.0.h,
                    h: 25.0.h,
                    backgroundColor: Color(0xFF170633),
                    onPressed: saveImgToGallery,
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
