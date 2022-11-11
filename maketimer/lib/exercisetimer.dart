import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'main.dart';

void main(){ runApp(const Timerexercise()); }

class Timerexercise extends StatelessWidget {
  const Timerexercise({Key? key}) : super (key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const Exercisetimermenu(),
    );
  }
}

class Exercisetimermenu extends StatefulWidget {
  const Exercisetimermenu({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => Exercisetimerpage();
}

class Exercisetimerpage extends State<Exercisetimermenu> {

  double worktime = 0; double resttime = 0;
  double workgauge = 0; double restgauge = 0;
  var workMin, workSec, restMin, restSec, repeat = 3;
  late Timer timer;
  bool timerrunning = false;

  @override
  Widget build(BuildContext context) {
    double maxwidth = MediaQuery.of(context).size.width;
    double maxheight = MediaQuery.of(context).size.height;
    worktime = 3600 * (120 + workgauge) / 236;
    resttime = 1800 * (120 + restgauge) / 236;
    workMin = worktime ~/ 60; workSec = (worktime % 60).truncate();
    restMin = resttime ~/ 60; restSec = (resttime % 60).truncate(); repeat.truncate();
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
                    Container(
                      width: double.maxFinite,
                      height: maxheight * 0.2,
                      margin: EdgeInsets.only(top: maxheight * 0.2, bottom: 30),
                      decoration: BoxDecoration(
                        boxShadow : [BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.25),
                            offset: Offset(0,4),
                            blurRadius: 16
                        )],
                        color : Color(0xFFC7BA).withOpacity(1),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text("운동 시간을 설정해주세요", style: TextStyle(
                            fontSize: 18, fontFamily: "Cafe24Simplehae", fontWeight: FontWeight.bold,
                          ),),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              GestureDetector(
                                child: SvgPicture.asset("assets/images/leftbutton.svg", fit: BoxFit.none,),
                                onTap: () {
                                  setState(() {
                                    if(workgauge > -119.95)
                                      workgauge -= 236 / 3600;
                                    else
                                      workgauge = -120;
                                  });
                                },
                                onLongPress: () {
                                  setState(() {
                                    if(workgauge > -117){
                                      timerrunning = true;
                                      timer = Timer.periodic(Duration(milliseconds: 10), (timer) {
                                        setState(() {
                                          workgauge -= 236 / 3600;
                                          if(workgauge <= -117)
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
                              GestureDetector(
                                child: Stack(
                                  alignment: Alignment.centerLeft,
                                  children: [
                                    Container(
                                        width: 240,
                                        height: 32,
                                        decoration: BoxDecoration(
                                          borderRadius : BorderRadius.only(
                                            topLeft: Radius.circular(30),
                                            topRight: Radius.circular(30),
                                            bottomLeft: Radius.circular(30),
                                            bottomRight: Radius.circular(30),
                                          ),
                                          color : Color.fromRGBO(196, 196, 196, 1),
                                          border : Border.all(
                                            color: Color.fromRGBO(0, 0, 0, 1),
                                            width: 2,
                                          ),
                                        )
                                    ),
                                    Container(
                                        margin: EdgeInsets.only(left: 2, right: 2),
                                        width: 120 + workgauge,
                                        height: 28,
                                        decoration: BoxDecoration(
                                          borderRadius : BorderRadius.only(
                                            topLeft: Radius.circular(30),
                                            topRight: Radius.circular(30),
                                            bottomLeft: Radius.circular(30),
                                            bottomRight: Radius.circular(30),
                                          ),
                                          color : Color(0x9ADCFF).withOpacity(1),
                                        )
                                    ),
                                  ],
                                ),
                                onHorizontalDragUpdate: (DragUpdateDetails details){
                                  setState(() {
                                    if(workgauge >= -118 && workgauge <= 116){
                                      workgauge += details.delta.dx;
                                    }
                                    if(workgauge > 116)
                                      workgauge = 116;
                                    else if(workgauge < -118)
                                      workgauge = -116;
                                  });
                                },
                                onHorizontalDragEnd: (DragEndDetails details){
                                  setState(() {
                                    if(workgauge < -118)
                                      workgauge = -116;
                                  });
                                },
                              ),
                              GestureDetector(
                                child: SvgPicture.asset("assets/images/rightbutton.svg", fit: BoxFit.none,),
                                onTap: () {
                                  setState(() {
                                    if(workgauge < 116)
                                      workgauge += 236 / 3600;
                                    else
                                      workgauge = 116;
                                  });
                                },
                                onLongPress: () {
                                  setState(() {
                                    if(workgauge < 114){
                                      timerrunning = true;
                                      timer = Timer.periodic(Duration(milliseconds: 10), (timer) {
                                        setState(() {
                                          workgauge += 236 / 3600;
                                          if(workgauge >= 114)
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
                          Text('${workMin}'.padLeft(2, '0') + ' : ' + '${workSec}'.padLeft(2, '0'),
                            style: TextStyle(color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: double.maxFinite,
                      height: maxheight * 0.2,
                      margin: EdgeInsets.only(top: 30),
                      decoration: BoxDecoration(
                        boxShadow : [BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.25),
                            offset: Offset(0,4),
                            blurRadius: 16
                        )],
                        color : Color(0x9ADCFF).withOpacity(1),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text("휴식 시간을 설정해주세요", style: TextStyle(
                            fontSize: 18, fontFamily: "Cafe24Simplehae", fontWeight: FontWeight.bold,
                          ),),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              GestureDetector(
                                child: SvgPicture.asset("assets/images/leftbutton.svg", fit: BoxFit.none,),
                                onTap: () {
                                  setState(() {
                                    if(restgauge > -119.9)
                                      restgauge -= 236 / 1800;
                                    else
                                      restgauge = -120;
                                  });
                                },
                                onLongPress: () {
                                  setState(() {
                                    if(restgauge > -117){
                                      timerrunning = true;
                                      timer = Timer.periodic(Duration(milliseconds: 10), (timer) {
                                        setState(() {
                                          restgauge -= 236 / 1800;
                                          if(restgauge <= -117)
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
                              GestureDetector(
                                child: Stack(
                                  alignment: Alignment.centerLeft,
                                  children: [
                                    Container(
                                        width: 240,
                                        height: 32,
                                        decoration: BoxDecoration(
                                          borderRadius : BorderRadius.only(
                                            topLeft: Radius.circular(30),
                                            topRight: Radius.circular(30),
                                            bottomLeft: Radius.circular(30),
                                            bottomRight: Radius.circular(30),
                                          ),
                                          color : Color.fromRGBO(196, 196, 196, 1),
                                          border : Border.all(
                                            color: Color.fromRGBO(0, 0, 0, 1),
                                            width: 2,
                                          ),
                                        )
                                    ),
                                    Container(
                                        margin: EdgeInsets.only(left: 2, right: 2),
                                        width: 120 + restgauge,
                                        height: 28,
                                        decoration: BoxDecoration(
                                          borderRadius : BorderRadius.only(
                                            topLeft: Radius.circular(30),
                                            topRight: Radius.circular(30),
                                            bottomLeft: Radius.circular(30),
                                            bottomRight: Radius.circular(30),
                                          ),
                                          color : Colors.white,
                                        )
                                    ),
                                  ],
                                ),
                                onHorizontalDragUpdate: (DragUpdateDetails details){
                                  setState(() {
                                    if(restgauge >= -118 && restgauge <= 116){
                                      restgauge += details.delta.dx;
                                    }
                                    if(restgauge > 116)
                                      restgauge = 116;
                                    else if(restgauge < -118)
                                      restgauge = -116;
                                  });
                                },
                                onHorizontalDragEnd: (DragEndDetails details){
                                  setState(() {
                                    if(restgauge < -118)
                                      restgauge = -116;
                                  });
                                },
                              ),
                              GestureDetector(
                                child: SvgPicture.asset("assets/images/rightbutton.svg", fit: BoxFit.none,),
                                onTap: () {
                                  setState(() {
                                    if(restgauge < 116)
                                      restgauge += 236 / 1800;
                                    else
                                      restgauge = 116;
                                  });
                                },
                                onLongPress: () {
                                  setState(() {
                                    if(restgauge < 114){
                                      timerrunning = true;
                                      timer = Timer.periodic(Duration(milliseconds: 10), (timer) {
                                        setState(() {
                                          restgauge += 236 / 1800;
                                          if(restgauge >= 114)
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
                          Text('${restMin}'.padLeft(2, '0') + ' : ' + '${restSec}'.padLeft(2, '0'),
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w600
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 50),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(width: 50,),
                          Text('반복 횟수를 설정해주세요', style: TextStyle(
                            color: Colors.white, fontFamily: "Cafe24Simplehae", fontSize: 20, fontWeight: FontWeight.bold,
                          ),),
                          SizedBox(width: 50,),
                          GestureDetector(
                            child: SvgPicture.asset("assets/images/leftbutton.svg", fit: BoxFit.none,),
                            onTap: () {
                              setState(() {
                                if(repeat > 1)
                                  repeat -= 1;
                              });
                            },
                          ),
                          SizedBox(width: 20,),
                          Text('${repeat}', style: TextStyle(
                            fontSize: 20, fontFamily: "Cafe24Simplehae", fontWeight: FontWeight.bold,
                          ),),
                          SizedBox(width: 20,),
                          GestureDetector(
                            child: SvgPicture.asset("assets/images/rightbutton.svg", fit: BoxFit.none,),
                            onTap: () {
                              setState(() {
                                if(repeat < 10)
                                  repeat += 1;
                              });
                            },
                          ),
                          SizedBox(width: 10,),
                        ],
                      ),
                    ),
                    Container(
                      width: maxwidth * 0.7,
                      height: maxheight * 0.1,
                      margin: EdgeInsets.only(top: maxheight * 0.08),
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
                          setState(() {
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => StartExercisetimer(exercisegauge: workgauge, restgauge: restgauge, repeatset: repeat,)));
                          });
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

class StartExercisetimer extends StatefulWidget {
  const StartExercisetimer({Key? key, required this.exercisegauge, required this.restgauge, required this.repeatset}) : super(key: key);
  final double exercisegauge, restgauge; final int repeatset;
  @override
  State<StatefulWidget> createState() => ExcusionExercisetimer();
}

class ExcusionExercisetimer extends State<StartExercisetimer> {

  double worktime = 0, resttime = 0;
  double workgauge = 0, restgauge = 0; var count = 0, number = 0;
  var workM, workS, restM, restS; double clock = 0.4;
  late Timer timer4; Color colorstate = Colors.grey;
  bool worktimerrunning = false;
  bool resttimerrunning = false;

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
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Exercisetimermenu()));
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
    timer4?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double maxwidth = MediaQuery.of(context).size.width;
    double maxheight = MediaQuery.of(context).size.height;
    number = widget.repeatset.truncate();
    worktime = 3600 * (120 + widget.exercisegauge) / 236 * (maxwidth * 0.6 - workgauge) / (maxwidth * 0.6);
    resttime = 1800 * (120 + widget.restgauge) / 236 * (maxwidth * 0.6 - restgauge) / (maxwidth * 0.6);
    workM = worktime ~/ 60; workS = (worktime % 60).truncate();
    restM = resttime ~/ 60; restS = (resttime % 60).truncate();
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          if(worktimerrunning || resttimerrunning){
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
                    child: Text(worktimerrunning? '움직여라 나의 신체야!' : (resttimerrunning? '그래도 쉬니까 좋다...' : '준비되었나요?'),
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 40,
                          fontWeight: FontWeight.w800),),
                  ),
                  SizedBox(
                    height: 80,
                  ),
                  Stack(
                    alignment: Alignment.topLeft,
                    children: [
                      Opacity(
                        opacity: clock,
                        child: SvgPicture.asset("assets/images/timerexercise.svg", height: maxheight * 0.32,),
                      ),
                      Opacity(
                        opacity: worktimerrunning? 1 : 0.4,
                        child: Container(
                          width: worktimerrunning? workgauge : maxwidth * 0.75, height: maxheight * 0.32,
                          child: SvgPicture.asset("assets/images/timerexercise.svg", height: maxheight * 0.32,
                            fit: BoxFit.fitHeight,
                            alignment: Alignment.topLeft,
                          ),
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
                          colorstate,
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
                          int delay = 0;
                          worktimerrunning = !worktimerrunning;
                          resttimerrunning = !resttimerrunning;
                          if(worktimerrunning != resttimerrunning){
                            timer4.cancel();
                            colorstate = Colors.grey;
                            if(worktime > 0)
                              resttimerrunning = false;
                            if(resttime > 0)
                              worktimerrunning = false;
                          }
                          else {
                            if (clock > 0 && clock < 1) {
                              colorstate = Colors.red;
                              resttimerrunning = false;
                            }
                            else {
                              colorstate = Colors.blue;
                              worktimerrunning = false;
                            }
                            Future.delayed(Duration(seconds: delay)).then((value) => delay = 0);
                            timer4 = Timer.periodic(Duration(seconds: 1), (timer) {
                              setState(() {
                                if(clock > 0 && clock < 1){
                                  if(delay > 0){
                                    Future.delayed(Duration(seconds: 1)).then((value) => delay--);
                                  }
                                  else{
                                    workgauge += 236 * maxwidth * 0.75 / (3600 * (120 + widget.exercisegauge));
                                    if(workM == 0 && workS == 1){
                                      workgauge = maxwidth * 0.75;
                                      clock = 0;
                                      colorstate = Colors.grey;
                                      delay = 2;
                                      Future.delayed(Duration(seconds: 2)).then((value) {
                                        setState(() {
                                          worktimerrunning = !worktimerrunning;
                                          resttimerrunning = !resttimerrunning;
                                          colorstate = Colors.blue;
                                        });
                                      });
                                    }
                                  }
                                }
                                else{
                                  if(delay > 0){
                                    Future.delayed(Duration(seconds: 1)).then((value) => delay--);
                                  }
                                  else{
                                    restgauge += 236 * maxwidth * 0.75 / (1800 * (120 + widget.restgauge));
                                    clock = (restS % 2 == 0) ? 0 : 1;
                                    if (restM == 0 && restS == 1) {
                                      workgauge = 0;
                                      restgauge = 0;
                                      colorstate = Colors.grey;
                                      clock = 0;
                                      count += 1;
                                      if(count == widget.repeatset){
                                        timer4.cancel();
                                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Timerexercise()));
                                      }
                                      else{
                                        delay = 2;
                                        Future.delayed(Duration(seconds: 2)).then((value) {
                                          setState(() {
                                            worktimerrunning = !worktimerrunning;
                                            resttimerrunning = !resttimerrunning;
                                            colorstate = Colors.red;
                                            clock = 0.4;
                                          });
                                        });
                                      }
                                    }
                                  }
                                }
                              });
                            });
                          }
                        });
                      },
                      child: Text(worktimerrunning? 'Work Out!!!' : (resttimerrunning? 'Rest a while...' : 'Ready'), style: TextStyle(
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