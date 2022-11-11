import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:maketimer/clocktimer.dart';
import 'package:maketimer/ramentimer.dart';

import 'bartimer.dart';
import 'exercisetimer.dart';

void main() { runApp(const Menu()); }

class Menu extends StatelessWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: Mainmenu(loading: false,),
    );
  }
}

class Mainmenu extends StatefulWidget {
  const Mainmenu({Key? key, required this.loading}) : super(key: key);
  final bool loading;

  @override
  State<StatefulWidget> createState() => Menupage();
}

class Menupage extends State<Mainmenu> {

  PageController pageselector = PageController(initialPage: 0);
  PageController buttonselector = PageController(initialPage: 0);

  late bool killswitch;

  @override
  void initState() {
    killswitch = widget.loading;
    super.initState();
    if(killswitch)
      init();
  }

  Future<void> init() async {
    await Future.delayed(Duration(seconds: 5)).then((value) {
      setState(() {
        killswitch = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double maxwidth = MediaQuery.of(context).size.width;
    double maxheight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          SvgPicture.asset("assets/images/background.svg", width: maxwidth, height: maxheight, fit: BoxFit.cover,),
          Align(
            alignment: Alignment.topCenter,
            child: Column(
              children: [
                SizedBox(height: maxheight * 0.25,),
                Text("TIMERMAKER", style: TextStyle(
                  fontSize: 50, fontFamily: "Cafe24Decobox", color: Colors.white,
                  ),
                ),
                SizedBox(height: 12,),
                Text("원하는 타이머를 내 마음대로 설정하세요!", style: TextStyle(
                  fontSize: 15, fontFamily: "Cafe24Ssurround", color: Colors.black,
                  ),
                ),
                SizedBox(height: maxheight * 0.05,),
                SizedBox(
                  height: maxheight * 0.25,
                  child: PageView(
                    controller: pageselector,
                    physics: new NeverScrollableScrollPhysics(),
                    children: [
                      SizedBox.expand(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(width: maxwidth * 0.4,),
                              SvgPicture.asset("assets/images/timerbar.svg", fit: BoxFit.none,),
                              SizedBox(width: 10,),
                              Image.asset(
                                  "assets/images/clock.gif",
                                  width: maxwidth * 0.12, height: maxheight * 0.12,
                                  alignment: Alignment(0, -3),
                              ),
                            ],
                          ),
                        ),
                      SizedBox.expand(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(width: maxwidth * 0.32,),
                            SvgPicture.asset("assets/images/timerclock.svg", fit: BoxFit.none,),
                            SizedBox(width: 5,),
                            Image.asset(
                              "assets/images/clock.gif",
                              width: maxwidth * 0.1, height: maxheight * 0.1,
                              alignment: Alignment(0, -2.5),
                            ),
                          ],
                        ),
                      ),
                      SizedBox.expand(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(width: maxwidth * 0.32,),
                            SvgPicture.asset(
                              "assets/images/boilingpot.svg",
                              width: maxwidth * 0.2, height: maxheight * 0.15,
                            ),
                            SizedBox(width: 5,),
                            Image.asset(
                              "assets/images/clock.gif",
                              width: maxwidth * 0.08, height: maxheight * 0.08,
                              alignment: Alignment(0, -4.5),
                            ),
                          ],
                        ),
                      ),
                      SizedBox.expand(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(width: maxwidth * 0.24,),
                            SvgPicture.asset(
                              "assets/images/timerexercise.svg",
                              width: maxwidth * 0.3, height: maxheight * 0.2,
                            ),
                            SizedBox(width: 5,),
                            Image.asset(
                              "assets/images/clock.gif",
                              width: maxwidth * 0.08, height: maxheight * 0.08,
                              alignment: Alignment(0, -4),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      child: SvgPicture.asset("assets/images/leftangle.svg"),
                      onTap: () {
                        setState(() {
                              pageselector.previousPage(
                                  duration: Duration(milliseconds: 300),
                                  curve: Curves.easeInOut);
                              buttonselector.previousPage(
                                  duration: Duration(milliseconds: 300),
                                  curve: Curves.easeInOut);
                          });
                      }
                    ),
                    SizedBox(
                      width: maxwidth * 0.6,
                      height: maxheight * 0.2,
                      child: PageView(
                        controller: buttonselector,
                        physics: new NeverScrollableScrollPhysics(),
                        children: [
                          SizedBox.expand(
                            child: InkWell(
                              child: Image.asset("assets/images/bartimerbutton.png",),
                              onTap: (){ Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => Timerbar())); },
                            ),
                          ),
                          SizedBox.expand(
                            child: InkWell(
                              child: Image.asset("assets/images/clocktimerbutton.png",),
                              onTap: (){ Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => Timerclock())); },
                            ),
                          ),
                          SizedBox.expand(
                            child: InkWell(
                              child: Image.asset("assets/images/ramentimerbutton.png",),
                              onTap: (){ Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => Timerramen())); },
                            ),
                          ),
                          SizedBox.expand(
                            child: InkWell(
                              child: Image.asset("assets/images/exercisetimerbutton.png",),
                              onTap: (){ Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => Timerexercise())); },
                            ),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      child: SvgPicture.asset("assets/images/rightangle.svg"),
                      onTap: (){
                        setState(() {
                            pageselector.nextPage(
                                duration: Duration(milliseconds: 300),
                                curve: Curves.easeInOut);
                            buttonselector.nextPage(
                                duration: Duration(milliseconds: 300),
                                curve: Curves.easeInOut);
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Visibility(
              visible: killswitch,
              child: Container(
                alignment: Alignment.center,
                color: Colors.blueGrey.withOpacity(0.8),
                child: CircularProgressIndicator(
                  strokeWidth: 5,
                  color: Colors.teal,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

}