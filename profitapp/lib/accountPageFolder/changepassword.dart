//import statements
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:profitapp/sizeConfig.dart';

class ChangePassword extends StatefulWidget {
  @override
  ChangePasswordState createState() => ChangePasswordState();
}

class ChangePasswordState extends State<ChangePassword> {
  //text editing controller variables
  final TextEditingController oldPassword = TextEditingController();
  final TextEditingController newPassword = TextEditingController();
  final TextEditingController newPasswordCheck = TextEditingController();

  //key for validator
  final _formKey = GlobalKey<FormState>();

  //erro text variables
  var errorTextOldPass = null;
  var errorTextNewPass = null;
  var errorTextNewPassCheck = null;

  @override
  Widget build(BuildContext context) {
    //back button variable
    final backButton = RaisedButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      shape: StadiumBorder(),
      color: Colors.purple[600],
      child: Text("     Back     ",
          style: TextStyle(
            fontSize: 20,
            fontFamily: 'BebasNeue',
          )),
    );
    //previous password field variable
    final oldPasswordField = TextFormField(
      obscureText: true,
      controller: oldPassword,
      keyboardType: TextInputType.text,
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter your current password';
        }
      },
      decoration: new InputDecoration(
          hintText: 'Enter your current password',
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          errorText: errorTextOldPass,
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );
    //new password field variable
    final newPasswordField = TextFormField(
      obscureText: true,
      controller: newPassword,
      keyboardType: TextInputType.text,
      decoration: new InputDecoration(
          hintText: 'Enter your new password',
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          errorText: errorTextNewPass,
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    //re-enter new password field variable
    final newPasswordCheckField = TextFormField(
      obscureText: true,
      controller: newPasswordCheck,
      keyboardType: TextInputType.text,
      decoration: new InputDecoration(
          hintText: 'Re-enter your new password',
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          errorText: errorTextNewPassCheck,
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    //confirm button variable
    final confirmButton = RaisedButton(
        onPressed: () async {
          //fire base variables
          final currentUser = FirebaseAuth.instance.currentUser;
          final userEmail = currentUser.email;
          final credential = EmailAuthProvider.credential(
              email: userEmail, password: oldPassword.text);
          setState(() {
            errorTextOldPass = null;
            errorTextNewPass = null;
            errorTextNewPassCheck = null;
          });
          //error cases:
          if (oldPassword.text == newPassword.text) {
            setState(() {
              errorTextNewPass = 'New password can\'t be old password';
            });
          }
          if (oldPassword.text.isEmpty == true) {
            setState(() {
              errorTextOldPass = 'Current password can\'t be empty';
            });
          }
          if (newPassword.text.isEmpty == true) {
            setState(() {
              errorTextNewPass = 'New password can\'t be empty';
            });
          }
          if (newPasswordCheck.text.isEmpty == true) {
            setState(() {
              errorTextNewPassCheck = 'Password can\'t be empty';
            });
          }
          if (newPassword.text != newPasswordCheck.text) {
            setState(() {
              errorTextNewPassCheck = 'Passwords don\'t match.';
              errorTextNewPass = 'Passwords don\'t match';
            });
          }
          if (newPassword.text.length < 6) {
            setState(() {
              errorTextNewPass = 'Password must be 6 characters or longer';
            });
          }

          //case for user successfully changing pass:
          if (oldPassword.text != newPassword.text &&
              newPassword.text.isEmpty == false &&
              oldPassword.text.isEmpty == false &&
              newPasswordCheck.text.isEmpty == false &&
              newPassword.text == newPasswordCheck.text &&
              newPassword.text.length >= 6) {
            try {
              setState(() {
                //reset error texts
                errorTextOldPass = null;
                errorTextNewPass = null;
                errorTextNewPassCheck = null;
              });
              //firebase update password
              await currentUser.reauthenticateWithCredential(credential);
              currentUser.updatePassword(newPassword.text);
              //sends user back to account page
              Navigator.of(context).pop();
            } on FirebaseAuthException catch (error) {
              setState(() {
                //catch error
                errorTextOldPass = 'Incorrect Password';
              });
            }
          }
        },
        shape: StadiumBorder(),
        color: Colors.blue,
        child: Text('   Confirm Password Change   ',
            style: TextStyle(fontFamily: 'BebasNeue', fontSize: 20)));

    //return scaffold holding widgets
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: new Form(
            key: _formKey,
            child: Center(
                child: Container(
                    child: Column(children: [
              Row(children: [
                SizedBox(
                    width: SizeConfig.safeBlockHorizontal *
                        16), //spaces out objects horizontally
                Image.asset('assets/PRShoe.png',
                    width: SizeConfig.safeBlockHorizontal * 50,
                    height: MediaQuery.of(context).viewInsets.bottom == 0.0
                        ? SizeConfig.safeBlockVertical * 50
                        : SizeConfig.safeBlockVertical *
                            25), //image asset widget for logo
              ]),
              oldPasswordField,
              SizedBox(
                  height: SizeConfig.safeBlockVertical *
                      1.5), //spaces out objects vertically
              newPasswordField,
              SizedBox(
                  height: SizeConfig.safeBlockVertical *
                      1.5), //spaces out objects vertically
              newPasswordCheckField,
              SizedBox(
                  height: SizeConfig.safeBlockVertical *
                      1.5), //spaces out objects vertically
              confirmButton,
              SizedBox(
                  height: SizeConfig.safeBlockVertical *
                      0.0005), //spaces out objects vertically
              backButton
            ])))));
  }
}
