// ignore_for_file: unused_import

import 'package:app/backend/database.dart';
import 'package:app/confin/constant.dart';
import 'package:app/screen/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  var name, surname, email, password;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                // txtName(),
                // txtSurname(),
                txtEmail(),
                txtPassword(),
                btnSubmit(),
              ],
            ),
          )),
    ));
  }

  Widget txtName() {
    return Container(
      margin: EdgeInsets.fromLTRB(15, 20, 15, 20),
      child: TextFormField(
        style: TextStyle(
          fontSize: 24,
          color: pColor,
        ),
        decoration: InputDecoration(
          labelText: 'Name:',
          icon: Icon(Icons.account_circle),
          hintText: 'Input your name',
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return 'กรุณาใส่ข้อมูลด้วย';
          } else if (value.length < 2) {
            return 'กรุณาใส่ข้อมูลมากกว่า 2 ตัวอักษร';
          }
        },
        onSaved: (value) {
          name = value;
        },
      ),
    );
  }

  Widget txtSurname() {
    return Container(
      margin: EdgeInsets.fromLTRB(15, 20, 15, 20),
      child: TextFormField(
        style: TextStyle(
          fontSize: 24,
          color: pColor,
        ),
        decoration: InputDecoration(
          labelText: 'Surname:',
          icon: Icon(Icons.add_reaction_sharp),
          hintText: 'Input your surname',
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return 'กรุณากรอกข้อมูล';
          }
        },
        onSaved: (value) {
          surname = value!.trim();
        },
      ),
    );
  }

  Widget txtEmail() {
    return Container(
      margin: EdgeInsets.fromLTRB(15, 20, 15, 20),
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        style: TextStyle(
          fontSize: 24,
          color: pColor,
        ),
        decoration: InputDecoration(
          labelText: 'Email:',
          icon: Icon(Icons.email),
          hintText: 'Input your email',
        ),
        validator: (value) {
          if (!(value!.contains('@'))) {
            return 'กรุณากรอกข้อมูลตามรูปแบบอีเมลด้วย';
          } else if (!(value.contains('.'))) {
            return 'กรุณากรอกข้อมูลตามรูปแบบอีเมลด้วย';
          }
        },
        onSaved: (value) {
          email = value;
        },
      ),
    );
  }

  Widget txtPassword() {
    return Container(
      margin: EdgeInsets.fromLTRB(15, 20, 15, 20),
      child: TextFormField(
        obscureText: true,
        style: TextStyle(
          fontSize: 24,
          color: pColor,
        ),
        decoration: InputDecoration(
          labelText: 'Password:',
          icon: Icon(Icons.lock),
          hintText: 'Input your password',
        ),
        onSaved: (value) {
          password = value;
        },
      ),
    );
  }

  Widget btnSubmit() => ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: pColor,
        ),
        onPressed: () {


          // print("Hello");
          // var local = new DBLocal();
          if (formKey.currentState!.validate()) {
            formKey.currentState!.save();
            registerFirbase(email,password);
            // print(
            // "Name : $name Surname : $surname Emai : $email Password : $password ");
            // local.register(name, surname, email, password);

            formKey.currentState!.reset();
            Navigator.pushNamed(context, 'Login');
          }
        },
        child: Text('Submit'),
      );

Future<void> registerFirbase(email,password)async{
  await FirebaseAuth.instance
  .createUserWithEmailAndPassword(email: email, password: password)
  .then((value){
      MaterialPageRoute materialPageRoute = MaterialPageRoute(
            builder: (BuildContext context) => Login());
    Navigator.of(context).pushAndRemoveUntil(
      materialPageRoute, (Route<dynamic>route) => false);
  }).catchError((onError){
    print(onError);
    // ignore: unnecessary_brace_in_string_interps
    var msg ='${onError}';
    showAlert(msg);
  });
}

 void showAlert(String message) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: ListTile(
              leading: Icon(
                Icons.error,
                color: Colors.red,
                size: 48,
              ),
              title: Text(
                "พบข้อผิดพลาด",
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 24,
                ),
              ),
            ),
            content: Text(message),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("ปิด"),
              )
            ],
          );
        });
  }

}
