import 'dart:async';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'main.dart';

void main(){ runApp(const Timerclock()); }

class Timerclock extends StatelessWidget {
  const Timerclock({Key? key}) : super (key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const Clocktimermenu(),
    );
  }
}

class Clocktimermenu extends StatefulWidget {
  const Clocktimermenu({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => Clocktimerpage();
}

class Clocktimerpage extends State<Clocktimermenu> {

  double value = 0.5;
  double time = 0;
  double preset = 300;
  var M, S;
  late Timer timer2;
  bool timerrunning = false;

  @override
  void dispose() {
    timer2?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double maxwidth = MediaQuery.of(context).size.width;
    double maxheight = MediaQuery.of(context).size.height;
    time = preset * value;
    M = time ~/ 60; S = (time % 60).truncate();
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async { return false; },
        child: Stack(
          children: [
            SvgPicture.asset("assets/images/background.svg", width: MediaQuery.of(context).size.width, height: MediaQuery.of(context).size.height, fit: BoxFit.cover,),
            IconButton(
              padding: EdgeInsets.only(left: 5, top: 80,),
              onPressed: () {
                setState(() {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Mainmenu(loading: false,)));
                });
              },
              icon: Icon(
                Icons.west_outlined,
                color: Colors.black,
                size: 30,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 50, top: 70),
              child: TextButton(
                  child: Text('Back', style: TextStyle(
                    color: Colors.black, fontSize: 25,),),
                  onPressed: () {
                    setState(() {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Menu()));
                    });
                  }),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(top: maxheight * 0.2, bottom: maxheight * 0.08),
                      width: maxwidth * 0.2,
                      height: maxheight * 0.05,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: Color(0xFFC7BA).withOpacity(1),
                      ),
                      child: TextButton(
                        onPressed: (){
                          setState(() {
                            if(preset == 300){
                              preset = 1800;
                            }
                            else if(preset == 1800){
                              preset = 7200;
                            }
                            else{
                              preset = 300;
                            }
                          });
                        },
                        child: Text((preset == 300)? "5min" : ((preset == 1800)? "30min" : "2h"),
                          style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15,
                          ),),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        child: Icon(Icons.arrow_back_ios_rounded, size: 20, color: Colors.black,),
                        onTap: () {
                          setState(() {
                            if(preset == 300 && value >= 0.0033)
                              value -= 1 / preset;
                            else if(preset == 1800 && value >= 0.00055)
                              value -= 1 / preset;
                            else if(preset == 7200 && value >= 0.00013)
                              value -= 1 / preset;
                            else
                              value = 0;
                          });
                        },
                        onLongPress: () {
                          setState(() {
                            if(value > 0.01){
                              timerrunning = true;
                              timer2 = Timer.periodic(Duration(milliseconds: 10), (timer) {
                                setState(() {
                                  value -= 1 / preset;
                                  if(value <= 0.01)
                                    timer2.cancel();
                                });
                              });
                            }
                          });
                        },
                        onLongPressEnd: (LongPressEndDetails details) {
                          setState(() {
                            if(timerrunning)
                              timer2.cancel();
                            timerrunning = false;
                          });
                        },
                      ),
                      GestureDetector(
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              width: maxwidth * 0.6,
                              height: maxwidth * 0.6,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xE4DE8A).withOpacity(0.7),
                                border: Border.all(color: Color(0x777777).withOpacity(1), style: BorderStyle.solid, width: 4),
                              ),
                            ),
                            SizedBox(
                              width: maxwidth * 0.28,
                              height: maxwidth * 0.28,
                              child: CircularProgressIndicator(
                                strokeWidth: maxwidth * 0.3,
                                value: value,
                                color: Color(0xE4DE8A).withOpacity(1),
                              ),
                            ),
                            Positioned(
                              child: Align(
                                alignment: Alignment.topCenter,
                                child: Text('${M}'.padLeft(2, '0') + ' : ' + '${S}'.padLeft(2, '0'),
                                  style: TextStyle(color: Colors.black,
                                      fontSize: 40,
                                      fontWeight: FontWeight.w600),),
                              ),
                            ),
                          ],
                        ),
                        onHorizontalDragUpdate: (DragUpdateDetails details){
                          setState(() {
                            value += details.delta.dx / 1000;
                            if(value > 1)
                              value = 1;
                            else if(value < 0)
                              value = 0;
                          });
                        },
                        onHorizontalDragEnd: (DragEndDetails details){
                          setState(() {

                          });
                        },
                      ),
                      GestureDetector(
                        child: Icon(Icons.arrow_forward_ios_rounded, size: 20, color: Colors.black,),
                        onTap: () {
                          setState(() {
                            if(value < 1)
                              value += 1 / preset;
                            else
                              value = 1;
                          });
                        },
                        onLongPress: () {
                          setState(() {
                            if(value < 0.99){
                              timerrunning = true;
                              timer2 = Timer.periodic(Duration(milliseconds: 10), (timer) {
                                setState(() {
                                  value += 1 / preset;
                                  if(value >= 0.99)
                                    timer2.cancel();
                                });
                              });
                            }
                          });
                        },
                        onLongPressEnd: (LongPressEndDetails details) {
                          setState(() {
                            if(timerrunning)
                              timer2.cancel();
                            timerrunning = false;
                          });
                        },
                      ),
                    ],
                  ),
                  Container(
                    width: maxwidth * 0.7,
                    height: maxheight * 0.1,
                    margin: EdgeInsets.only(top: maxheight * 0.1),
                    decoration: BoxDecoration(
                      borderRadius : BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                        bottomLeft: Radius.circular(40),
                        bottomRight: Radius.circular(40),
                      ),
                      boxShadow : [
                        BoxShadow(
                            color: Color.fromRGBO(51, 51, 51, 0.46050000190734863),
                            offset: Offset(0.41304028034210205,23.663063049316406),
                            blurRadius: 47.33333206176758
                        ),
                      ],
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.white,
                          Colors.grey.shade400,
                          Colors.grey.withOpacity(0.5),
                        ],
                        stops: [
                          0.78,
                          0.9,
                          1,
                        ],
                      ),
                      border : Border.all(
                        color: Color.fromRGBO(0, 0, 0, 1),
                        width: 2,
                      ),
                    ),
                    child: TextButton(
                      onPressed: (){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => StartClocktimer(total: preset, value: value)));
                      },
                      child: Text("Timer Start!", style: TextStyle(
                        color: Colors.black, fontSize: 25, fontFamily: "Roboto",
                      ),),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}

class StartClocktimer extends StatefulWidget {
  const StartClocktimer({Key? key, required this.total, required this.value}) : super(key: key);
  final double total, value;
  @override
  State<StatefulWidget> createState() => ExcusionClocktimer();
}

class ExcusionClocktimer extends State<StartClocktimer> {

  double time = 0;
  double value = 0, preset = 0;
  double volume = 0;
  var M, S;
  late Timer timer2;
  bool timerrunning = false;
  bool initialrunning = true;

  void starttimer() async {
    timer2 = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        this.volume -= 1 / preset;
        if(M == 0 && S == 1){
          Future.delayed(Duration(seconds: 1)).then((value) => {
          this.setState(() {
            this.volume = 0;
            this.timerrunning = false;
            timer2.cancel();
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Timerclock()));
            })
          });
        }
      });
    });
  }

  Future<bool> onBackPressed(BuildContext context) async {
    bool? result = await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          alignment: Alignment(0, 0.3),
          actionsAlignment: MainAxisAlignment.spaceEvenly,
          actionsPadding: EdgeInsets.only(bottom: 20),
          content: Text('타이머가 아직 실행 중입니다. 타이머를 취소하고 설정 화면으로 돌아가시겠습니까?',
            style: TextStyle( fontSize: 20, fontWeight: FontWeight.w700 ),
          ),
          actions: [
            Container(
              decoration: BoxDecoration(
                color: Colors.lightBlue.shade400,
                borderRadius: BorderRadius.all(Radius.circular(8)),
                boxShadow: [BoxShadow(color: Colors.grey, offset: Offset(4, 4),)],
              ),
              child: TextButton(
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Timerclock()));
                  });
                },
                child: Text('Yes', style: TextStyle( fontSize: 15, color: Colors.black ),),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.redAccent.shade400,
                borderRadius: BorderRadius.all(Radius.circular(8)),
                boxShadow: [BoxShadow(color: Colors.grey, offset: Offset(4, 4),)],
              ),
              child: TextButton(
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                  });
                },
                child: Text('No', style: TextStyle( fontSize: 15, color: Colors.black ),),
              ),
            ),
          ],
        ));
    return result ?? false;
  }

  @override
  void dispose() {
    timer2?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double maxwidth = MediaQuery.of(context).size.width;
    double maxheight = MediaQuery.of(context).size.height;
    value = widget.value;
    preset = widget.total;
    time = initialrunning? preset * value : preset * volume;
    M = time ~/ 60; S = (time % 60).truncate();
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          if(timerrunning){
            return onBackPressed(context);
          }
          else{
            return false;
          }
        },
        child: Stack(
          children: [
            SvgPicture.asset("assets/images/background.svg", width: MediaQuery.of(context).size.width, height: MediaQuery.of(context).size.height, fit: BoxFit.cover,),
            Align(
              alignment: Alignment.topCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: maxheight * 0.2,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text('${M}'.padLeft(2, '0') + ' : ' + '${S}'.padLeft(2, '0'),
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 40,
                          fontWeight: FontWeight.w800),),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: maxwidth * 0.6,
                        height: maxwidth * 0.6,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xE4DE8A).withOpacity(0.7),
                          border: Border.all(color: Color(0x777777).withOpacity(1), style: BorderStyle.solid, width: 4),
                        ),
                      ),
                      SizedBox(
                        width: maxwidth * 0.28,
                        height: maxwidth * 0.28,
                        child: CircularProgressIndicator(
                          strokeWidth: maxwidth * 0.3,
                          value: initialrunning? value: this.volume,
                          color: Color(0xE4DE8A).withOpacity(1),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: maxwidth * 0.7,
                    height: maxheight * 0.1,
                    margin: EdgeInsets.only(top: maxheight * 0.1),
                    decoration: BoxDecoration(
                      borderRadius : BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                        bottomLeft: Radius.circular(40),
                        bottomRight: Radius.circular(40),
                      ),
                      boxShadow : [
                        BoxShadow(
                            color: Color.fromRGBO(51, 51, 51, 0.46050000190734863),
                            offset: Offset(0.41304028034210205,23.663063049316406),
                            blurRadius: 47.33333206176758
                        ),
                      ],
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          (timerrunning? Colors.blue : Colors.red),
                          Colors.white.withOpacity(0.7),
                          Colors.white.withOpacity(0.5),
                        ],
                        stops: [
                          0.78,
                          0.9,
                          1,
                        ],
                      ),
                      border : Border.all(
                        color: Color.fromRGBO(0, 0, 0, 1),
                        width: 2,
                      ),
                    ),
                    child: TextButton(
                      onPressed: (){
                        setState(() {
                          if(initialrunning){
                            setState(() {
                              this.volume = value;
                              initialrunning = false;
                            });
                          }
                          timerrunning = !timerrunning;
                          if(timerrunning)
                            this.starttimer();
                          else
                            timer2.cancel();
                        });
                      },
                      child: Text(timerrunning? "Timer Pause" : "Timer Start!", style: TextStyle(
                        color: Colors.black, fontSize: 25, fontFamily: "Roboto",
                      ),),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}