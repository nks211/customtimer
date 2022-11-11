import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'main.dart';

void main() {
  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const Splash(),
    );
  }
}

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => SplashIcon();
}

class SplashIcon extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    precacheImage(AssetImage('assets/images/icon.png'), context);
    return Scaffold(
      body: FutureBuilder(
        future: splash(),
        builder: (context, snapshot) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Image.asset(
                    'assets/images/icon.png'
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text("MakeTimer", style: TextStyle(
                fontFamily: "Cafe24Decobox",
                fontSize: 40,
                color: Colors.black,
              ),),
            ],
          );
        },
      ),
    );
  }

  Future<void> splash() async {
    await Future.delayed(Duration(seconds: 3)).then((value) {
      Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext context) {
          return Mainmenu(loading: true,);
        })
      );
    });
  }
}
