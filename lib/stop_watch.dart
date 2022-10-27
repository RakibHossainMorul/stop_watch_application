// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:flutter/material.dart';

class StopWatchApp extends StatefulWidget {
  const StopWatchApp({super.key});

  @override
  State<StopWatchApp> createState() => _StopWatchAppState();
}

class _StopWatchAppState extends State<StopWatchApp> {
  //define business logics
  int seconds = 0, minutes = 0, hours = 0;
  String digitsSeconds = "00", digitsMinutes = "00", digitsHours = "00";
  Timer? timer;
  bool started = false;
  List laps = [];

  //Create Stop timer function
  void stop() {
    timer!.cancel();
    setState(() {
      started = false;
    });
  }

  //Create Reset funtion for timer

  void reset() {
    timer!.cancel();
    setState(() {
      seconds = 0;
      minutes = 0;
      hours = 0;
      digitsSeconds = "00";
      digitsMinutes = "00";
      digitsHours = "00";
      started = false;
    });
  }

  //Create addLap funtion for addding timer data to laps variable

  void addLap() {
    String lap = "$digitsHours,$digitsMinutes,$digitsSeconds";
    setState(() {
      laps.add(lap);
    });
  }

  ///Create start funtion for starting the timer

  void start() {
    started = true;
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      int localSeconds = seconds + 1;
      int localMinutes = minutes;
      int localHours = hours;
      if (localSeconds > 59) {
        if (localMinutes > 59) {
          localHours++;
          localMinutes = 0;
        } else {
          localMinutes++;
          localSeconds = 0;
        }
      }
      setState(() {
        seconds = localSeconds;
        minutes = localMinutes;
        hours = localHours;
        digitsSeconds = (seconds >= 10) ? "$seconds" : "0$seconds";
        digitsMinutes = (minutes >= 10) ? "$minutes" : "0$minutes";
        digitsHours = (hours >= 10) ? "$hours" : "0$hours";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C2757),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  "StopWatch",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: Text(
                  "$digitsHours:$digitsMinutes:$digitsSeconds",
                  style: TextStyle(
                      fontSize: 82,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
              ),
              Container(
                height: 400,
                decoration: BoxDecoration(
                  color: Color(0xFF323F68),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ListView.builder(
                    itemCount: laps.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Lap no : ${index + 1}",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              "${laps[index + 1]}",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: RawMaterialButton(
                      onPressed: () {
                        (!started) ? start() : stop();
                      },
                      shape: StadiumBorder(
                        side: BorderSide(color: Colors.blue),
                      ),
                      child: Text(
                        (!started) ? "Start" : "Pause",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  IconButton(
                    onPressed: () {
                      addLap();
                    },
                    icon: Icon(Icons.flag),
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: RawMaterialButton(
                      onPressed: () {
                        reset();
                      },
                      fillColor: Colors.blue,
                      shape: StadiumBorder(),
                      child: Text(
                        "Reset",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
