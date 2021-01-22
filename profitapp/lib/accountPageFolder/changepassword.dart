import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:profitapp/sizeConfig.dart';

class ChangePassword extends StatefulWidget {
  @override
  ChangePasswordState createState() => ChangePasswordState();
}

class ChangePasswordState extends State<ChangePassword> {
  final TextEditingController oldPassword = TextEditingController();
  final TextEditingController newPassword = TextEditingController();
  final TextEditingController newPasswordCheck = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var errorTextOldPass = null;
  var errorTextNewPass = null;
  var errorTextNewPassCheck = null;

  @override
  Widget build(BuildContext context) {
    final backButton = RaisedButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      shape: StadiumBorder(),
      color: Colors.blue[300],
      child: Text("     Back     ",
          style: TextStyle(
            fontSize: 20,
            fontFamily: 'BebasNeue',
          )),
    );
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
    final confirmButton = RaisedButton(
        onPressed: () async {
          final currentUser = FirebaseAuth.instance.currentUser;
          final userEmail = currentUser.email;
          final credential = EmailAuthProvider.credential(
              email: userEmail, password: oldPassword.text);
          setState(() {
            errorTextOldPass = null;
            errorTextNewPass = null;
            errorTextNewPassCheck = null;
          });
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

          if (oldPassword.text != newPassword.text &&
              newPassword.text.isEmpty == false &&
              oldPassword.text.isEmpty == false &&
              newPasswordCheck.text.isEmpty == false &&
              newPassword.text == newPasswordCheck.text &&
              newPassword.text.length >= 6) {
            try {
              setState(() {
                errorTextOldPass = null;
                errorTextNewPass = null;
                errorTextNewPassCheck = null;
              });
              await currentUser.reauthenticateWithCredential(credential);
              currentUser.updatePassword(newPassword.text);
              Navigator.of(context).pop();
            } on FirebaseAuthException catch (error) {
              setState(() {
                errorTextOldPass = 'Incorrect Password';
              });
            }
          }
        },
        shape: StadiumBorder(),
        color: Colors.red[600],
        child: Text('   Confirm Password Change   ',
            style: TextStyle(fontFamily: 'BebasNeue', fontSize: 20)));
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: new Form(
            key: _formKey,
            child: Center(
                child: Container(
                    child: Column(children: [
              Row(children: [
                SizedBox(width: SizeConfig.safeBlockHorizontal * 16),
                Image.asset('assets/PRShoe.png',
                    width: SizeConfig.safeBlockHorizontal * 50,
                    height: MediaQuery.of(context).viewInsets.bottom == 0.0
                        ? SizeConfig.safeBlockVertical * 50
                        : SizeConfig.safeBlockVertical * 25),
              ]),
              oldPasswordField,
              SizedBox(height: SizeConfig.safeBlockVertical * 1.5),
              newPasswordField,
              SizedBox(height: SizeConfig.safeBlockVertical * 1.5),
              newPasswordCheckField,
              SizedBox(height: SizeConfig.safeBlockVertical * 1.5),
              confirmButton,
              SizedBox(height: SizeConfig.safeBlockVertical * 0.0005),
              backButton
            ])))));
  }
}
