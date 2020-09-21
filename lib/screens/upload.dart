import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mediadrive_app/models/signinModel.dart';
import 'package:mediadrive_app/values/borders.dart';
import 'package:mediadrive_app/values/colors.dart';
import 'package:mediadrive_app/values/radii.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:file_picker/file_picker.dart';
import 'signin.dart';
import 'signup.dart';
import 'dart:convert' show json, base64, ascii;

class Upload extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<Upload> {

  SharedPreferences sharedPreferences;

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }






  checkLoginStatus() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if(sharedPreferences.getString('accessToken') == null) {
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => Signin()), (Route<dynamic> route) => false);
    }
  }










  SigninModel model;

  String _fileName;
  //String _path;
  Map<String, String> _paths;
  String _extension;
  //bool _multiPick = false;
  bool _hasValidMime = false;
  FileType _pickingType = FileType.any;
  TextEditingController _controller = new TextEditingController();

  get email => null;
  @override
  void _openFileExplorer() async {
    if (_pickingType != null) {
      try {
        //_path = null;
        _paths = await FilePicker.getMultiFilePath(type: _pickingType);

      } on PlatformException catch (e) {
        print("Unsupported operation" + e.toString());
      }
      if (!mounted) return;

//      setState(() {
//        _fileName = _path != null ? _path.split('/').last : _paths != null ? _paths.keys.toString() : '...';
//      });
    }
  }


  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body:Container(
        width: screenSize.width,
        height: screenSize.height,
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 0, 27, 45),
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        child: Stack(
          children: <Widget>[
            //header
            Container(
              height: 21,
              margin: EdgeInsets.only(left: 44, top: 19, right: 31),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      width: 104,
                      height: 17,
                      child: Stack(
                        alignment: Alignment.centerLeft,
                        children: [
                          Positioned(
                            left: 0,
                            child: Image.asset(
                              "assets/images/fill-1.png",
                              fit: BoxFit.none,
                            ),
                          ),
                          Positioned(
                            left: 0,
                            right: 0,
                            child: Image.asset(
                              "assets/images/group-17.png",
                              fit: BoxFit.none,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Spacer(),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      width: 16,
                      height: 19,
                      margin: EdgeInsets.only(top: 2, right: 25),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Positioned(
                            left: 0,
                            right: 0,
                            child: Image.asset(
                              "assets/images/group-3-3.png",
                              fit: BoxFit.none,
                            ),
                          ),
                          Positioned(
                            left: 8,
                            right: 3,
                            bottom: 3,
                            child: Image.asset(
                              "assets/images/fill-4-4.png",
                              fit: BoxFit.none,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      width: 19,
                      height: 19,
                      margin: EdgeInsets.only(top: 1),
                      child: Image.asset(
                        "assets/images/setting-icon.png",
                        fit: BoxFit.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            //first bar

            Container(
              height: MediaQuery.of(context).size.height * 0.1,
              //margin: EdgeInsets.only(top: 53),
              margin: EdgeInsets.only(
                top:MediaQuery.of(context).size.height * 0.065,
              ),
              //margin: EdgeInsets.all(MediaQuery.of(context).size.width / 25),
              decoration: BoxDecoration(
                color: AppColors.primaryBackground,// Background
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[



                  //upload
                  Container(
                    //margin: EdgeInsets.all(20.0),
                    margin:EdgeInsets.only(top:15.0),
                    padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.00009),

                    width: 36,
                    height: 30,

                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          width: 36,
                          height: 30,
                          child: Image.asset(
                            "assets/images/upload-icon.png",
                            fit: BoxFit.none,
                          ),
                        ),
                        Positioned(
                          top:30,
                          child: Text(
                            "Upload",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Color.fromARGB(255, 163, 165, 168),
                              fontFamily: "Calibri",
                              fontWeight: FontWeight.w400,
                              fontSize: 11,
                              letterSpacing: -0.5,
                              height: 1.27273,
                            ),
                          ),
                        )
                      ],

                    ),

                  ),

                  //line1
                  Container(
                    child: Container(
                      width: 1,
                      margin: EdgeInsets.all(4.00),
                      padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.00009),
                      decoration: BoxDecoration(
                        color: AppColors.primaryElement,
                      ),
                    ),
                  ),


                  //contacts
                  Container(
                    //margin: EdgeInsets.all(MediaQuery.of(context).size.width/25),
                    margin:EdgeInsets.only(top:15.0),
                    padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.00009),
                    width: 40,
                    height: 27,
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          width: 36,
                          height: 30,
                          child: Image.asset(
                            "assets/images/contacts-icon-3.png",
                            fit: BoxFit.none,
                          ),
                        ),
                        Positioned(
                          top:30,
                          child: Text(
                            "Contacts",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Color.fromARGB(255, 163, 165, 168),
                              fontFamily: "Calibri",
                              fontWeight: FontWeight.w400,
                              fontSize: 11,
                              letterSpacing: -0.5,
                              height: 1.27273,
                            ),
                          ),
                        )
                      ],

                    ),

                  ),

                  //line2
                  Container(
                    child: Container(
                      width: 1,
                      margin: EdgeInsets.all(4.00),
                      padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.00009),
                      decoration: BoxDecoration(
                        color: AppColors.primaryElement,
                      ),
                    ),
                  ),


//invite
                  Container(
                    //margin: EdgeInsets.all(MediaQuery.of(context).size.width/25),
                    margin:EdgeInsets.only(top:15.0),
                    padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.00009),

                    width: 36,
                    height: 27,
                    child: Stack(
                      children: <Widget>[

                        Positioned(
                          width: 36,
                          height: 30,
                          child: Image.asset(
                            "assets/images/group-3-7.png",
                            fit: BoxFit.none,
                          ),
                        ),
                        Positioned(
                          width: 36,
                          height: 27,
                          left: 12,
                          top: 2,
                          child: Image.asset(
                            "assets/images/fill-4.png",
                            fit: BoxFit.none,
                          ),
                        ),
                        Positioned(
                          top:30,
                          left: 5,
                          child: Text(
                            "Invite",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Color.fromARGB(255, 163, 165, 168),
                              fontFamily: "Calibri",
                              fontWeight: FontWeight.w400,
                              fontSize: 11,
                              letterSpacing: -0.5,
                              height: 1.27273,
                            ),
                          ),
                        )
                      ],

                    ),

                  ),


                  //line3
                  Container(
                    child: Container(
                      width: 1,
                      margin: EdgeInsets.all(4.00),
                      padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.00009),
                      decoration: BoxDecoration(
                        color: AppColors.primaryElement,
                      ),
                    ),
                  ),

                  //profile
                  Container(
                    //margin: EdgeInsets.all(MediaQuery.of(context).size.width/25),
                    margin:EdgeInsets.only(top:15.0),
                    padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.00009),

                    width: 36,
                    height: 27,
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          width: 36,
                          height: 27,
                          child: Image.asset(
                            "assets/images/profile-icon-2.png",
                            fit: BoxFit.none,
                          ),
                        ),
                        Positioned(
                          left: 5,
                          top:30,
                          child: Text(
                            "Profile",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Color.fromARGB(255, 163, 165, 168),
                              fontFamily: "Calibri",
                              fontWeight: FontWeight.w400,
                              fontSize: 11,
                              letterSpacing: -0.5,
                              height: 1.27273,
                            ),
                          ),
                        )
                      ],

                    ),

                  )
                ],

              ),










            ),

            //second bar
            Container(
              height: MediaQuery.of(context).size.height * 0.052,
              //margin: EdgeInsets.only(top: 130,left:10,right:10),
              //margin: EdgeInsets.all(MediaQuery.of(context).size.height / 5.5),
              margin: EdgeInsets.only(
                left:MediaQuery.of(context).size.height * 0.02,
                right: MediaQuery.of(context).size.height * 0.02,
                top:MediaQuery.of(context).size.height * 0.18,
              ),
              // margin: EdgeInsets.all(MediaQuery.of(context).size.width / 8.5),
              //margin: EdgeInsets.symmetric(),
              //padding:EdgeInsets.all(MediaQuery.of(context).size.height * 0.009),
              //width:MediaQuery.of(context).size.width * 3.0,



              decoration: BoxDecoration(
                color: Color.fromARGB(255, 50, 92, 128),
                borderRadius: Radii.k5pxRadius,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  //files
                  Container(
                    //margin: EdgeInsets.all(20.0),
                    margin: EdgeInsets.all(MediaQuery.of(context).size.height*0.014),
                    //padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.00009),
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          child: Text(
                            "Files",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: AppColors.primaryText,
                              fontFamily: "Calibri",
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              letterSpacing: -0.63636,
                              height: 1,
                            ),
                          ),
                        ),

                      ],
                    ),

                  ),

                  //line1
                  Container(
                    child: Container(
                      width: 1,
                      //margin: EdgeInsets.all(4.00),
                      padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.00009),
                      decoration: BoxDecoration(
                        color: AppColors.primaryElement,
                      ),
                    ),
                  ),

                  //send
                  Container(
                    //margin: EdgeInsets.all(20.0),
                    margin: EdgeInsets.all(MediaQuery.of(context).size.height*0.014),
                    //padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.00009),
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          child: Text(
                            "Send",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: AppColors.primaryText,
                              fontFamily: "Calibri",
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              letterSpacing: -0.63636,
                              height: 1,
                            ),
                          ),
                        ),

                      ],
                    ),

                  ),

                  //line2
                  Container(
                    child: Container(
                      width: 1,
                      //margin: EdgeInsets.all(4.00),
                      padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.00009),
                      decoration: BoxDecoration(
                        color: AppColors.primaryElement,
                      ),
                    ),
                  ),


                  //progress
                  Container(
                    margin: EdgeInsets.all(MediaQuery.of(context).size.height*0.014),
                    //padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.00009),
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          child: Text(
                            "Progress",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: AppColors.primaryText,
                              fontFamily: "Calibri",
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              letterSpacing: -0.63636,
                              height: 1,
                            ),
                          ),
                        ),

                      ],
                    ),

                  ),
                ],
              ),
            ),






            //body
            Container(
              margin: EdgeInsets.only(
//                  left:MediaQuery.of(context).size.height * 0.0001,
//                  right: MediaQuery.of(context).size.height * 0.02,
                  top:MediaQuery.of(context).size.height * 0.35,
                  left:MediaQuery.of(context).size.height * 0.1,
                  right: MediaQuery.of(context).size.height * 0.1,
                  bottom: MediaQuery.of(context).size.height * 0.35 //right:MediaQuery.of(context).size.height * 0.03,
              ),

              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[

                    Container(
                      height: MediaQuery.of(context).size.height * 0.4,
//          width:MediaQuery.of(context).size.height * 0.3,

//            padding:EdgeInsets.only(
//              top:MediaQuery.of(context).size.height * 0.001,
//              left:MediaQuery.of(context).size.height * 0.5,
//            ),
                      padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.01),
                      decoration: BoxDecoration(
                        border: Border.fromBorderSide(Borders.secondaryBorder),
                        borderRadius: BorderRadius.all(Radius.circular(130)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
//                  Text('Welcome',
//                    style: TextStyle(
//                        color: Colors.white
//                    ),),
//                  Text('Welcome $email',
//                  style: TextStyle(
//                    color: Colors.white
//                  ),),

                          Container(
                            margin: EdgeInsets.all(MediaQuery.of(context).size.height*0.012),
                            child:Stack(
                              children: <Widget>[
                                Positioned(
                                  child: Container(
                                    //height: MediaQuery.of(context).size.height * 0.3,
                                    //width:MediaQuery.of(context).size.height * 0.3,
                                    margin: EdgeInsets.only(
                                      //left:MediaQuery.of(context).size.height * 0.0009,
                                      //right: MediaQuery.of(context).size.height * 0.0009,
                                      top:MediaQuery.of(context).size.height * 0.002,
                                      //left:MediaQuery.of(context).size.height * 0.09,
                                      //right: MediaQuery.of(context).size.height * 0.02,              //right:MediaQuery.of(context).size.height * 0.03,
                                    ),
                                    padding:EdgeInsets.all(MediaQuery.of(context).size.height * 0.13),

                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        width: 1,
                                        color: Color.fromARGB(255, 89, 131, 146),
                                      ),
                                      borderRadius: BorderRadius.all(Radius.circular(104.40945)),
                                    ),),
                                ),


                                Positioned(
                                  child: Container(
//                                    margin: EdgeInsets.only(
////                  left:MediaQuery.of(context).size.height * 0.0001,
////                  right: MediaQuery.of(context).size.height * 0.02,
//                                      top:MediaQuery.of(context).size.height * 0.13,
//                                      left:MediaQuery.of(context).size.height * 0.07,
//                                    ),
                                    padding:EdgeInsets.only(top:MediaQuery.of(context).size.height * 0.1,
                                        left:MediaQuery.of(context).size.height * 0.08),

                                    //width: MediaQuery.of(context).size.height * 0.06,
                                    child: Image.asset(
                                      "assets/images/group-20.png",
                                      fit: BoxFit.none,
                                    ),
                                  ),
                                ),

                                Positioned(
                                  child: Container(
                                    padding:EdgeInsets.only(top:MediaQuery.of(context).size.height * 0.05,
                                        left:MediaQuery.of(context).size.height * 0.06),
                                    child: new FlatButton(
                                      color: Colors.transparent,
                                      textColor:AppColors.primaryText,
                                      onPressed: () => _openFileExplorer(),
                                      child: new Text(
                                        "Upload Files",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          color: Color.fromARGB(255, 89, 131, 146),
                                          fontFamily: "Calibri",
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14,
                                          letterSpacing: -0.63636,
                                          height: 1,
                                        ),
                                      ),
                                    ),
                                  ),

                                ),


                                new Builder(builder: (BuildContext context) => new Container(
                                  margin: EdgeInsets.only(
                                    top:MediaQuery.of(context).size.height * 0.1,
                                    left:MediaQuery.of(context).size.height * 0.09,
                                  ),
                                  child: new Scrollbar(
                                    child:  _paths != null
                                        ? new ListView.separated(
                                      itemCount: _paths != null && _paths.isNotEmpty ? _paths.length : 1,
                                      itemBuilder: (BuildContext context, int index) {
                                        final bool isMultiPath = _paths != null && _paths.isNotEmpty;
                                        final String name = 'File $index: ' + (isMultiPath ? _paths.keys.toList()[index] : _fileName ?? '...');
                                        final path = isMultiPath ? _paths.values.toList()[index].toString() : _paths;

                                        return new ListTile(
                                          title: new Text(
                                            name,
                                          ),
                                          subtitle: new Text(path),
                                        );
                                      },
                                      separatorBuilder: (BuildContext context, int index) => new Divider(),
                                    )
                                        : new Container(),
                                  ),

                                )),


                                Container(
                                  margin: EdgeInsets.only(
//                  left:MediaQuery.of(context).size.height * 0.0001,
//                  right: MediaQuery.of(context).size.height * 0.02,
                                    top:MediaQuery.of(context).size.height * 0.2,
                                    left:MediaQuery.of(context).size.height * 0.02,
                                    right: MediaQuery.of(context).size.height * 0.02,              //right:MediaQuery.of(context).size.height * 0.03,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: <Widget>[
                                      FlatButton.icon(
                                        onPressed: () {
                                          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => Signup()), (Route<dynamic> route) => false);
                                        },
                                        icon: Icon(Icons.contacts),
                                        label: Text('Sign Up'),
                                      ),
                                    ],
                                  ),
                                ),

//                        Positioned(
//                          child: Container(
//                            margin: EdgeInsets.only(
//                              top:MediaQuery.of(context).size.height * 0.1,
//                              left:MediaQuery.of(context).size.height * 0.09,
//                            ),
//                            child: Text(
//                              "Upload Files",
//                              textAlign: TextAlign.left,
//                              style: TextStyle(
//                                color: Color.fromARGB(255, 89, 131, 146),
//                                fontFamily: "Calibri",
//                                fontWeight: FontWeight.w400,
//                                fontSize: 14,
//                                letterSpacing: -0.63636,
//                                height: 1,
//                              ),
//                            ),
//                          ),
//                        ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),



                  ]
              ),
            ),



            //Body





























            //footer
            Container(
              height: MediaQuery.of(context).size.height * 0.05,
//            width:MediaQuery.of(context).size.height * 0.5 ,
              margin: EdgeInsets.only(
//                  left:MediaQuery.of(context).size.height * 0.0001,
//                  right: MediaQuery.of(context).size.height * 0.02,
                top:MediaQuery.of(context).size.height * 0.92,
                left:MediaQuery.of(context).size.height * 0.02,
                right: MediaQuery.of(context).size.height * 0.02,              //right:MediaQuery.of(context).size.height * 0.03,
              ),

//            padding:EdgeInsets.only(
//              top:MediaQuery.of(context).size.height * 0.001,
//              left:MediaQuery.of(context).size.height * 0.5
//            ),
              decoration: BoxDecoration(
                color: AppColors.accentElement,
                borderRadius: Radii.k5pxRadius,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.all(MediaQuery.of(context).size.height*0.014),
                    child:Stack(
                      children: <Widget>[
                        Positioned(
                          child: Text(
                            "Update Available",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: AppColors.primaryText,
                              fontFamily: "Calibri",
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              letterSpacing: -0.63636,
                              height: 1,
                            ),
                          ),
                        ),
                      ],

                    ),
                  ),
                ],
              ),
            ),




          ],
        ),
      ),
    );
  }
}
