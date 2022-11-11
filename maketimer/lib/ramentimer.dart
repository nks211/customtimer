import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'main.dart';

void main(){ runApp(const Timerramen()); }

class Timerramen extends StatelessWidget {
  const Timerramen({Key? key}) : super (key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const Ramentimermenu(),
    );
  }
}

class Ramentimermenu extends StatefulWidget {
  const Ramentimermenu({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => Ramentimerpage();
}

class Ramentimerpage extends State<Ramentimermenu> {

  var index = 0, number = 5;
  List<String> ramenlist = ["봉지라면", "컵라면", "파스타", "칼국수", "소면", "우동사리", "당면"];
  List<int> presetlist = [240, 180, 300, 270, 150, 210, 360];

  @override
  Widget build(BuildContext context) {
    double maxwidth = MediaQuery.of(context).size.width;
    double maxheight = MediaQuery.of(context).size.height;
    index.truncate(); number.truncate();
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
                      margin: EdgeInsets.only(top: maxheight * 0.25, bottom: 30),
                      decoration: BoxDecoration(
                        boxShadow : [BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.25),
                            offset: Offset(0,4),
                            blurRadius: 16
                        )],
                        color : Color.fromRGBO(255, 255, 255, 1),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("끓이는 면의 개수를 설정해주세요", style: TextStyle(
                            fontSize: 18, fontFamily: "Cafe24Simplehae", fontWeight: FontWeight.bold,
                          ),),
                          SizedBox(height: 30,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset("assets/images/boilingpot.svg", fit: BoxFit.none,),
                              SizedBox(width: 60,),
                              GestureDetector(
                                child: SvgPicture.asset("assets/images/leftbutton.svg", fit: BoxFit.none,),
                                onTap: () {
                                  setState(() {
                                    if(number > 1)
                                      number -= 1;
                                  });
                                },
                              ),
                              SizedBox(width: 40,),
                              Text('${number}', style: TextStyle(
                                fontSize: 20, fontFamily: "Cafe24Simplehae", fontWeight: FontWeight.bold,
                              ),),
                              SizedBox(width: 40,),
                              GestureDetector(
                                child: SvgPicture.asset("assets/images/rightbutton.svg", fit: BoxFit.none,),
                                onTap: () {
                                  setState(() {
                                    if(number < 10)
                                      number += 1;
                                  });
                                },
                              ),
                            ],
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
                        color : Color.fromRGBO(255, 255, 255, 1),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("어떤 종류의 면을 요리할 건가요?", style: TextStyle(
                            fontSize: 18, fontFamily: "Cafe24Simplehae", fontWeight: FontWeight.bold,
                          ),),
                          SizedBox(height: 30,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset("assets/images/noodle.svg", width: 70, fit: BoxFit.fitWidth,),
                              SizedBox(width: 60,),
                              GestureDetector(
                                child: SvgPicture.asset("assets/images/leftbutton.svg", fit: BoxFit.none,),
                                onTap: () {
                                  setState(() {
                                    index = (index - 1) % ramenlist.length;
                                  });
                                },
                              ),
                              SizedBox(width: 40,),
                              Container(
                                width: 90,
                                child: Text(ramenlist[index], style: TextStyle(
                                  fontSize: 20, fontFamily: "Cafe24Decoline",
                                ), textAlign: TextAlign.center,),
                              ),
                              SizedBox(width: 40,),
                              GestureDetector(
                                child: SvgPicture.asset("assets/images/rightbutton.svg", fit: BoxFit.none,),
                                onTap: () {
                                  setState(() {
                                    index = (index + 1) % ramenlist.length;
                                  });
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
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
                          setState(() {
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => StartRamentimer(preset: presetlist[index], number: number,)));
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

class StartRamentimer extends StatefulWidget {
  const StartRamentimer({Key? key, required this.preset, required this.number}) : super(key: key);
  final int preset; final int number;
  @override
  State<StatefulWidget> createState() => ExcusionRamentimer();
}

class ExcusionRamentimer extends State<StartRamentimer> {

  double time = 0;
  double gauge = 0; var preset = 0; var number = 0;
  var M, S;
  late Timer timer3;
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
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Ramentimermenu()));
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
    timer3?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double maxwidth = MediaQuery.of(context).size.width;
    double maxheight = MediaQuery.of(context).size.height;
    preset = widget.preset; number = widget.number.truncate();
    time = preset * (maxwidth * 0.6 - gauge) / (maxwidth * 0.6) * (1 + (number - 1) * 0.1);
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
                    child: Text(timerrunning? '면을 삶고 있는 중입니다...' : '준비되었나요?',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.w800),),
                  ),
                  SizedBox(
                    height: maxheight * 0.1,
                  ),
                  Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Opacity(
                        opacity: 0.4,
                        child: SvgPicture.asset("assets/images/noodle.svg", height: maxwidth * 0.6,),
                      ),
                      Container(
                        width: maxwidth * 0.6, height: gauge,
                        child: SvgPicture.asset("assets/images/noodle.svg", height: maxwidth * 0.6,
                          fit: BoxFit.fitWidth,
                          alignment: Alignment.bottomCenter,
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
                          timerrunning = !timerrunning;
                          if(timerrunning){
                            timer3 = Timer.periodic(Duration(seconds: 1), (timer) {
                              setState(() {
                                gauge += maxwidth * 0.6 / (preset * (1 + (number - 1) * 0.1));
                                if(M == 0 && S == 1){
                                  timer3.cancel();
                                  timerrunning = false;
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Timerramen()));
                                }
                              });
                            });
                          }
                          else
                            timer3.cancel();
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