import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:routy_app_v102/models/user.dart';
import 'package:routy_app_v102/provider/sign_in.dart';
import 'package:routy_app_v102/widget/background_painter.dart';

class LoggedIn extends StatefulWidget {
  LoggedIn({Key key}) : super(key: key);

  @override
  _LoggedInState createState() => _LoggedInState();
}


class _LoggedInState extends State<LoggedIn> {

    final user = FirebaseAuth.instance.currentUser;
    
    MyUser _myUser;
    bool _loading = true;
    getUser() async{
      DocumentSnapshot dc = await FirebaseFirestore.instance.collection("users").doc(user.email).get();
      setState(() {
        _myUser = new MyUser.fromData(dc.data());
        _loading = false;
      });
    }
    

  @override
  initState() {
    
    super.initState();
    getUser();
  }


  @override
  Widget build(BuildContext context) {

    final provider = Provider.of<SignInProvider>(context, listen: false);
    
    return Container(
      alignment: Alignment.center,
      color: Colors.blueGrey.shade900,
      child: _loading
      ? buildLoading()
      :Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Logged In',
            style: TextStyle(color: Colors.white),
          ),
          SizedBox(height: 8),
          CircleAvatar(
            maxRadius: 25,
            backgroundImage: NetworkImage(_myUser.image),
          ),
          SizedBox(height: 8),
          Text(
            'Name: ' + _myUser.fullName,
            style: TextStyle(color: Colors.white),
          ),
          SizedBox(height: 8),
          Text(
            'Email: ' + _myUser.email,
            style: TextStyle(color: Colors.white),
          ),
          SizedBox(height: 8),
          Text(
            'Fecha de creación: ' + _myUser.createdAt.toString(),
            style: TextStyle(color: Colors.white),
          ),
          SizedBox(height: 8),
          ElevatedButton(
            onPressed: () {

              provider.logOut();
            },
            child: Text('Logout'),
          )
        ],
      ),
    );
  }
}

    Widget buildLoading() => Stack(
        fit: StackFit.expand,
        children: [
          CustomPaint(painter: BackgroundPainter()),
          Center(child: CircularProgressIndicator()),
        ],
      );