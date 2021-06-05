import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

import 'package:stegnographer/screens/loading_screen.dart';
import 'package:stegnographer/constants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          title: 'StegnoGrapher',
          theme: ThemeData.dark().copyWith(
              primaryColor: kPrimaryColor,
              accentColor: kAccentColor,
              scaffoldBackgroundColor: kScaffoldColor,
              appBarTheme: kAppBarTheme,
              bottomNavigationBarTheme: kBottomBarTheme),
          home: HomePage(),
        );
      },
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  File? _image;
  PickedFile? pickedFile;
  final picker = ImagePicker();
  int _selectedIdx = 0;
  bool change = true, flag = true;
  String msgToEncrypt = '';
  bool isInvalid = false;

  Future getImage(int idx) async {
    setState(() {
      _selectedIdx = idx;
      if (idx == 0) _image = null;
    });
    if (_selectedIdx == 1) {
      pickedFile = await picker.getImage(
        maxWidth: double.maxFinite,
        source: ImageSource.camera,
      );
      setState(() {
        pickedFile != null ? _image = File(pickedFile!.path) : _image = null;
      });
    } else if (_selectedIdx == 2) {
      final pickedFile = await picker.getImage(
        maxWidth: double.maxFinite,
        source: ImageSource.gallery,
      );
      setState(() {
        pickedFile != null ? _image = File(pickedFile.path) : _image = null;
      });
    }
  }

  Future<void> _showMyDialog(String txt) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: kScaffoldColor,
            title: Text(
              'Ooops...',
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
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
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
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.camera,
            ),
            label: 'From Camera',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.photo,
            ),
            label: 'From Gallery',
          ),
        ],
        currentIndex: _selectedIdx,
        onTap: getImage,
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  margin: EdgeInsets.all(10.w),
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
                  child: _image != null
                      ? Image.file(_image!)
                      : Text(
                          'No Image Selected',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: kAccentColor,
                            fontFamily: kFontFamily,
                            fontSize: 35.0.sp,
                          ),
                        ),
                ),
              ),
              change == true
                  ? TextField(
                      onChanged: (value) {
                        setState(() {
                          msgToEncrypt = value;
                          if (_image == null || msgToEncrypt.length == 0) {
                            isInvalid = false;
                          } else {
                            isInvalid = true;
                          }
                        });
                      },
                      selectionWidthStyle: BoxWidthStyle.tight,
                      textAlign: TextAlign.center,
                      maxLength: 25, // Number of chars in TextField
                      style: TextStyle(
                        fontSize: 15.0.sp,
                        fontFamily: kFontFamily,
                        color: kAccentColor,
                      ),
                      cursorColor: kAccentColor,
                      decoration: InputDecoration(
                        hintText: 'Your message goes here...',
                        hintStyle: TextStyle(
                          fontSize: 12.0.sp,
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: kAccentColor,
                            width: 2.0,
                          ),
                        ),
                        isDense: true,
                      ),
                    )
                  : Container(decoration: null),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ActionButtonContainer(
                      icn: Icons.lock,
                      onPressed: () {
                        isInvalid
                            ? Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (context) {
                                return LoadingScreen(
                                  imgFile: _image,
                                  msg: msgToEncrypt,
                                  sendRequest: true,
                                );
                              }))
                            : _showMyDialog(
                                'Please select an image & type a message to embed');
                      },
                      btnLabel: 'Encrypt',
                      w: kActionButtonContainerSide,
                      h: kActionButtonContainerSide,
                      backgroundColor: Color(0xFF170633),
                    ),
                    ActionButtonContainer(
                      icn: Icons.lock_open_outlined,
                      onPressed: () {
                        _image != null
                            ? Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (context) {
                                return LoadingScreen(
                                  imgFile: _image,
                                  msg: msgToEncrypt,
                                  sendRequest: false,
                                );
                              }))
                            : _showMyDialog('No Image Selected!');
                      },
                      btnLabel: 'Decrypt',
                      w: kActionButtonContainerSide,
                      h: kActionButtonContainerSide,
                      backgroundColor: Color(0xFF170633),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// Custom Widgets
class ActionButtonContainer extends StatelessWidget {
  ActionButtonContainer(
      {required this.icn,
      required this.onPressed,
      required this.btnLabel,
      required this.w,
      required this.h,
      required this.backgroundColor,
      this.margin = 5.0});

  final IconData icn;
  final VoidCallback onPressed;
  final String btnLabel;
  final double w, h;
  final Color backgroundColor;
  final double margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: w,
      height: h,
      margin: EdgeInsets.all(margin),
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        children: [
          Expanded(
            flex: 2,
            child: IconButton(
              onPressed: onPressed,
              icon: Icon(
                icn,
                color: Colors.white,
              ),
              iconSize: 10.w,
            ),
          ),
          Expanded(
            child: Text(
              btnLabel,
              style: TextStyle(
                fontFamily: kFontFamily,
                fontSize: 15.0.sp,
              ),
            ),
          ),
        ],
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
        color: backgroundColor,
      ),
    );
  }
}
