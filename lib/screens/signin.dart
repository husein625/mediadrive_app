import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mediadrive_app/screens/signup.dart';
import 'package:mediadrive_app/screens/upload.dart';
import 'package:mediadrive_app/values/colors.dart';
import 'package:mediadrive_app/values/radii.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' show json, base64, ascii;


class Signin extends StatefulWidget {


  @override
  _HomeScreenState createState() => _HomeScreenState();

}

class _HomeScreenState extends State<Signin> {
  bool _isLoading = false;
  SharedPreferences sharedPreferences;


  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  final TextEditingController tokenController = new TextEditingController();

  signIn(String email, pass) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map data = {
      'email': email,
      'password': pass,
      'strategy': 'local'
    };
    var jsonResponse;
    var response = await http.post("http://api-staging.mediadrive.io/authentication",
        body: data);
    setState(() {
      _isLoading = false;
    });
    jsonResponse = json.decode(response.body);
    sharedPreferences.setString("accessToken", jsonResponse['accessToken']);
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => Upload()), (Route<dynamic> route) => false);
    print(response.body);

//    if(response.statusCode == 200) {
//      if(jsonResponse != null) {
//        setState(() {
//          _isLoading = false;
//        });
//      jsonResponse = json.decode(response.body);
//    sharedPreferences.setString("accessToken", jsonResponse['accessToken']);
//    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => Upload()), (Route<dynamic> route) => false);
//
//      }
//  }
//    else {
////    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => MainPage()), (Route<dynamic> route) => false);
//
//      setState(() {
//        _isLoading = false;
//      });
//      print(response.body);
//    }
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




            //Body
            Form(
              child:Container(
//

                height: MediaQuery.of(context).size.height * 0.4,
//            width:MediaQuery.of(context).size.height * 0.5 ,
                margin: EdgeInsets.only(
//                  left:MediaQuery.of(context).size.height * 0.0001,
//                  right: MediaQuery.of(context).size.height * 0.02,
                  top:MediaQuery.of(context).size.height * 0.36,
                  left:MediaQuery.of(context).size.height * 0.02,
                  right: MediaQuery.of(context).size.height * 0.02,              //right:MediaQuery.of(context).size.height * 0.03,
                ),

                decoration: BoxDecoration(
                  color: AppColors.secondaryBackground,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    //signin
                    Container(

                      child: Stack(
                        children: <Widget>[
                          Positioned(
                            child: Container(

//              ),
                              padding: EdgeInsets.only(top:MediaQuery.of(context).size.width*0.06,
                                  left:MediaQuery.of(context).size.width*0.33),

                              child: Text(
                                "SIGN IN",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: AppColors.primaryText,
                                  fontFamily: "Calibri",
                                  fontWeight: FontWeight.w400,
                                  fontSize:MediaQuery.of(context).size.height * 0.025,
                                  letterSpacing: -0.63636,
                                  height: 1,
                                ),
                              ),
                            ),
                          ),






//              username
                          Positioned(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 89, 131, 146),
                              ),
                              height: MediaQuery.of(context).size.height * 0.06,
                              width:MediaQuery.of(context).size.width * 0.85,
                              margin: EdgeInsets.only(
                                top:MediaQuery.of(context).size.height * 0.12,
                              ),
                              padding:EdgeInsets.all(MediaQuery.of(context).size.height * 0.002),

                              child:  TextFormField(
                                controller: emailController,
                                decoration: InputDecoration(
                                    labelText: 'Email'
                                ),
                              ),

                            ),
                          ),




                          //password
                          Positioned(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 89, 131, 146),
                              ),
                              height: MediaQuery.of(context).size.height * 0.06,
                              width:MediaQuery.of(context).size.width * 0.85,
                              margin: EdgeInsets.only(
                                top:MediaQuery.of(context).size.height * 0.2,
                              ),

                              padding:EdgeInsets.all(MediaQuery.of(context).size.height * 0.002),

                              //width: MediaQuery.of(context).size.height * 0.06,
                              child:  TextFormField(
                                controller: passwordController,
                                obscureText: true,
                                decoration: InputDecoration(
                                    labelText: 'Password'
                                ),
                              ),

                            ),

                          ),

                          //buttonsignin
                          Positioned(
                            child: Container(
                              decoration: BoxDecoration(
                                  color: AppColors.accentElement,
                                  borderRadius: Radii.k5pxRadius),
                              height: MediaQuery.of(context).size.height * 0.05,
                              width:MediaQuery.of(context).size.width * 0.75,
                              margin: EdgeInsets.only(
//                  left:MediaQuery.of(context).size.height * 0.0001,
//                  right: MediaQuery.of(context).size.height * 0.02,
                                top:MediaQuery.of(context).size.height * 0.29,
                                left:MediaQuery.of(context).size.height * 0.03,
                              ),


                              child:RaisedButton(
                                color: AppColors.accentElement,
                                textColor:AppColors.primaryText,
                                child: Text('Sign In',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: AppColors.primaryText,
                                        fontFamily: "Calibri",
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14,
                                        letterSpacing: -0.63636,
                                        height: 1)
                                ),
                                onPressed: emailController.text == "" || passwordController.text == "" ? null  : () {
                                  setState(() {
                                    _isLoading = true;
                                  });
                                  signIn(emailController.text, passwordController.text);





                                },


                                //width: MediaQuery.of(context).size.height * 0.06,
//                child: Text(
//                  "Sign In",
//                  textAlign: TextAlign.center,
//                  style: TextStyle(
//                    color: AppColors.primaryText,
//                    fontFamily: "Calibri",
//                    fontWeight: FontWeight.w400,
//                    fontSize: 14,
//                    letterSpacing: -0.63636,
//                    height: 1,
//                  ),
//                ),
//

                              ),

                            ),


                          )

                        ],
                      ),

                    ),
                  ],
                ),
              ),
            ),
            //sign_up button
            Container(
              margin: EdgeInsets.only(
//                  left:MediaQuery.of(context).size.height * 0.0001,
//                  right: MediaQuery.of(context).size.height * 0.02,
                top:MediaQuery.of(context).size.height * 0.7,
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
            //sign_up button

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


//
//
//class MyTextFormField extends StatelessWidget {
//  final String hintText;
//  final Function validator;
//  final Function onSaved;
//  final bool isPassword;
//  final bool isEmail;
//
//  MyTextFormField({
//    this.hintText,
//    this.validator,
//    this.onSaved,
//    this.isPassword = false,
//    this.isEmail = false,
//  });
//  @override
//  Widget build(BuildContext context) {
//    return Padding(
//      padding: EdgeInsets.all(8.0),
//      child: TextFormField(
//        decoration: InputDecoration(
//          hintText: hintText,
//          contentPadding: EdgeInsets.all(6.0),
//          border: InputBorder.none,
//          filled: true,
//          //fillColor: Colors.grey[200],
//        ),
//        obscureText: isPassword ? true : false,
//        validator: validator,
//        onSaved: onSaved,
//        keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
//      ),
//    );
//  }
//}