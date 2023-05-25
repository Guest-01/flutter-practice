import 'dart:async';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int totalSeconds = 1500;
  int totalPomos = 0;
  late Timer timer;
  bool isActive = false;

  void onTick(Timer _) {
    setState(() {
      totalSeconds -= 1;
    });
    if (totalSeconds == 0) {
      setState(() {
        totalPomos += 1;
        totalSeconds = 1500;
      });
      onPausePressed();
    }
  }

  void onStartPressed() {
    timer = Timer.periodic(const Duration(seconds: 1), onTick);
    setState(() {
      isActive = true;
    });
  }

  void onPausePressed() {
    timer.cancel();
    setState(() {
      isActive = false;
    });
  }

  void onReset() {
    if (isActive) {
      timer.cancel();
    }
    setState(() {
      isActive = false;
      totalSeconds = 1500;
    });
  }

  String formatSecondsToMin(int sec) {
    var tmp = Duration(seconds: sec).toString();
    return tmp.substring(2, 7);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        children: [
          Flexible(
            flex: 1,
            child: Container(
              alignment: Alignment.bottomCenter,
              child: Text(
                formatSecondsToMin(totalSeconds),
                style: TextStyle(
                  color: Theme.of(context).cardColor,
                  fontSize: 88,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          Flexible(
            flex: 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  iconSize: 120,
                  color: Theme.of(context).cardColor,
                  icon: isActive
                      ? const Icon(Icons.pause_circle_outline)
                      : const Icon(Icons.play_circle_outline),
                  onPressed: isActive ? onPausePressed : onStartPressed,
                ),
                IconButton(
                  iconSize: 50,
                  color: Theme.of(context).cardColor,
                  icon: const Icon(Icons.restore),
                  onPressed: onReset,
                ),
              ],
            ),
          ),
          Flexible(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(35),
                  topRight: Radius.circular(35),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Pomodoros",
                          style: TextStyle(
                            color:
                                Theme.of(context).textTheme.displayLarge!.color,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          "$totalPomos",
                          style: TextStyle(
                            color:
                                Theme.of(context).textTheme.displayLarge!.color,
                            fontSize: 48,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
