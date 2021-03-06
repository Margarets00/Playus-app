import 'dart:async';
import 'package:flutter/material.dart';
import 'package:playus_app/constants.dart';
import 'package:playus_app/screen/home/components/send.dart';
import 'package:playus_app/screen/home/components/partyRoom.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class CodeForm extends StatefulWidget {
  CodeForm({Key key}) : super(key: key);
  @override
  _CodeForm createState() => _CodeForm();
}

class _CodeForm extends State<CodeForm> {
  TextEditingController textEditingController = TextEditingController();
  UnfocusDisposition disposition = UnfocusDisposition.scope;
  //..text = "123456";
  @override
  void dispose() {
    //textEditingController.dispose();
    super.dispose();
  }

  StreamController<ErrorAnimationType> errorController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: GestureDetector(
            onTap: () {
              primaryFocus.unfocus(disposition: disposition);
              //Print('tap!');
            },
            child: Stack(children: [
              Background(
                where: 'bottom',
                height: 0.89,
              ),
              Navigation(),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.2),
                      ),
                      Text(
                        'ENTER PARTY CODE!',
                        textAlign: TextAlign.left,
                        style: Theme.of(context).textTheme.headline2,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.03),
                      ),
                      PinCodeTextField(
                        length: 5,
                        appContext: context,
                        obscureText: false,
                        autoFocus: true,
                        keyboardType: TextInputType.number,
                        pinTheme: PinTheme(
                          shape: PinCodeFieldShape.box,
                          activeColor: Colors.transparent,
                          inactiveColor: kPrimaryColor,
                          inactiveFillColor: kPrimaryColor,
                          selectedColor: kPrimaryColor,
                          selectedFillColor: kSecondaryColor,
                          fieldHeight: 60,
                          fieldWidth: 35,
                          activeFillColor: kPrimaryColor,
                        ),
                        animationType: AnimationType.fade,
                        animationDuration: Duration(milliseconds: 300),
                        backgroundColor: Colors.transparent,
                        enableActiveFill: true,
                        errorAnimationController: errorController,
                        controller: textEditingController,
                        textStyle:
                            TextStyle(fontSize: 47, color: kSecondaryColor),
                        pastedTextStyle: TextStyle(
                          color: kSecondaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                        onCompleted: (v) {
                          //roomPass(textEditingController.text).then((value) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    PartyRoom(code: v),
                              ));
                          //}).catchError((e) => print('빠꾸'));
                        },
                        onChanged: (value) {
                          //print(value);
                          //print(textEditingController.text);
                        },
                        beforeTextPaste: (text) {
                          print("Allowing to paste $text");
                          //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                          //but you can show anything you want here, like your pop up saying wrong paste format or etc
                          return true;
                        },
                        dialogConfig: DialogConfig(
                          dialogTitle: 'Party Code',
                        ),
                      ),
                      Button(
                        text: 'START',
                        wordspace: 0.0,
                        //iconCode: 0xe5e1,
                        isClick: () {
                          if (textEditingController.text.length == 5) {
                            roomPass(textEditingController.text).then((value) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        PartyRoom(
                                            code: textEditingController.text),
                                  ));
                            }).catchError((e) => print('빠꾸'));
                            /* */
                          } else {
                            print('글자 다 입력 안함');
                          }
                        },
                      ),
                    ],
                  ))
            ])));
  }
}
