import 'dart:async';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'main.dart';

void main(){ runApp(const Timerbar()); }

class Timerbar extends StatelessWidget {
  const Timerbar({Key? key}) : super (key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const Bartimermenu(),
    );
  }
}

class Bartimermenu extends StatefulWidget {
  const Bartimermenu({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => Bartimerpage();
}

class Bartimerpage extends State<Bartimermenu>{

  double time = 0;
  double gauge = 0;
  double preset = 300;
  var M, S;
  late Timer timer;
  bool timerrunning = false;

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double maxwidth = MediaQuery.of(context).size.width;
    double maxheight = MediaQuery.of(context).size.height;
    time = preset * (288 - gauge) / 288;
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
                            if(preset == 300 && gauge <= 287)
                              gauge += 288 / preset;
                            else if(preset == 1800 && gauge <= 287.84)
                              gauge += 288 / preset;
                            else if(preset == 7200 && gauge <= 287.96)
                              gauge += 288 / preset;
                            else
                              gauge = 288;
                          });
                        },
                        onLongPress: () {
                          setState(() {
                            if(gauge < 284){
                              timerrunning = true;
                              timer = Timer.periodic(Duration(milliseconds: 10), (timer){
                                setState(() {
                                  gauge += 288 / preset;
                                  if(gauge >= 284){
                                    timer.cancel();
                                  }
                                });
                              });
                            }
                          });
                        },
                        onLongPressEnd: (LongPressEndDetails details) {
                          setState(() {
                            if(timerrunning)
                              timer.cancel();
                            timerrunning = false;
                          });
                        },
                      ),
                      Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(20),),
                              border: Border.all(color: Color(0x777777).withOpacity(1), style: BorderStyle.solid, width: 4),
                              color: Color(0xE4DE8A).withOpacity(0.7),
                            ),
                            width: 120,
                            height: 300,
                          ),
                          GestureDetector(
                            child: Container(
                              margin: EdgeInsets.only(bottom: 6),
                              width: 110,
                              height: 288 - gauge,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(15),),
                                color: Color(0xE4DE8A).withOpacity(1),
                              ),
                            ),
                            onVerticalDragUpdate: (DragUpdateDetails details){
                              setState(() {
                                if(gauge >= 0 && gauge <= 288) {
                                  gauge += details.delta.dy;
                                }
                                else if(gauge > 288)
                                  gauge = 284;
                                else{
                                  gauge = 0;
                                }
                              });
                            },
                            onVerticalDragEnd: (DragEndDetails details){
                              setState(() {
                                if(gauge > 288)
                                  gauge = 284;
                                else if(gauge <= 0) {
                                  gauge = 0;
                                }
                              });
                            },
                          ),
                          Positioned(
                            top: 140,
                            child: SizedBox(
                              width: 120,
                              child: Align(
                                alignment: Alignment.center,
                                child: Text('${M}'.padLeft(2, '0') + ' : ' + '${S}'.padLeft(2, '0'),
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),),
                              ),
                            ),
                          )
                        ],
                      ),
                      GestureDetector(
                        child: Icon(Icons.arrow_forward_ios_rounded, size: 20, color: Colors.black,),
                        onTap: () {
                          setState(() {
                            if(gauge > 0)
                              gauge -= 288 / preset;
                            else
                              gauge = 0;
                          });
                        },
                        onLongPress: () {
                          setState(() {
                            if(gauge > 2){
                              timerrunning = true;
                              timer = Timer.periodic(Duration(milliseconds: 10), (timer){
                                setState(() {
                                  gauge -= 288 / preset;
                                  if(gauge <= 2)
                                    timer.cancel();
                                });
                              });
                            }
                          });
                        },
                        onLongPressEnd: (LongPressEndDetails details) {
                          setState(() {
                            if(timerrunning)
                              timer.cancel();
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
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => StartBartimer(preset: preset, gauge: gauge)));
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

class StartBartimer extends StatefulWidget {
  const StartBartimer({Key? key, required this.preset, required this.gauge}) : super(key: key);
  final double preset, gauge;
  @override
  State<StatefulWidget> createState() => ExcusionBartimer();
}

class ExcusionBartimer extends State<StartBartimer> {

  double time = 0;
  double gauge = 0, preset = 0;
  var M, S; double stopgauge = 0;
  late Timer timer;
  bool timerrunning = false;

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
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Timerbar()));
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
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if(widget.gauge > 0){
      while(gauge < widget.gauge){
        gauge += 0.0001;
      }
    }
    double maxwidth = MediaQuery.of(context).size.width;
    double maxheight = MediaQuery.of(context).size.height;
    preset = widget.preset;
    stopgauge = (preset == 300)? 287 : (preset == 1800? 287.84 : 287.96);
    time = preset * (288 - gauge) / 288;
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
                    height: 30,
                  ),
                  Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20),),
                          border: Border.all(color: Color(0x777777).withOpacity(1), style: BorderStyle.solid, width: 4),
                          color: Color(0xE4DE8A).withOpacity(0.7),
                        ),
                        width: 120,
                        height: 300,
                      ),
                      GestureDetector(
                        child: Container(
                          margin: EdgeInsets.only(bottom: 6),
                          width: 110,
                          height: 288 - gauge,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(15),),
                            color: Color(0xE4DE8A).withOpacity(1),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: maxwidth * 0.7,
                    height: maxheight * 0.1,
                    margin: EdgeInsets.only(top: 40),
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
                          timerrunning = !timerrunning;
                          if(timerrunning){
                            timer = Timer.periodic(Duration(seconds: 1), (timer){
                              setState(() {
                                gauge += 288 / preset;
                                if(gauge >= stopgauge){
                                  timer.cancel();
                                  timerrunning = false;
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Timerbar()));
                                }
                              });
                            });
                          }
                          else{
                            timer.cancel();
                          }
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