import 'package:flutter/material.dart';
import 'package:routy_app_v102/models/user.dart';
import 'package:routy_app_v102/provider/sign_in.dart';
import 'package:provider/provider.dart';
import 'package:routy_app_v102/widget/background_painter.dart';

class LoggedInWidget extends StatelessWidget {
  
  
  @override
  Widget build(BuildContext context) {
    
    bool _progressController = true;
    MyUser myUser;
    final provider = Provider.of<SignInProvider>(context, listen: false);
    myUser = provider.myUser;
    getuser() async{
      myUser = await provider.getUser(); 
    }
    getuser();
    _progressController = false;
    return Container(
      alignment: Alignment.center,
      color: Colors.blueGrey.shade900,
      child: _progressController
            ? buildLoading
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
            backgroundImage: NetworkImage(myUser.image),
          ),
          SizedBox(height: 8),
          Text(
            'Name: ' + myUser.fullName,
            style: TextStyle(color: Colors.white),
          ),
          SizedBox(height: 8),
          Text(
            'Email: ' + myUser.email,
            style: TextStyle(color: Colors.white),
          ),
          SizedBox(height: 8),
          Text(
            'Fecha de creación: ' + myUser.createdAt.toString(),
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
    Widget buildLoading() => Stack(
        fit: StackFit.expand,
        children: [
          CustomPaint(painter: BackgroundPainter()),
          Center(child: CircularProgressIndicator()),
        ],
      );
}
