import 'package:flutter/material.dart';
import 'dart:async';

class PomodoroTimerPage extends StatefulWidget {
  @override
  _PomodoroTimerPageState createState() => _PomodoroTimerPageState();
}

class _PomodoroTimerPageState extends State<PomodoroTimerPage> {
  int _start = 25 * 60; // 25 minutes in seconds
  int _current = 0;
  bool _isActive = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _current = _start;
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void startTimer() {
    _isActive = true;
    const oneSec = const Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_current == 0) {
          timer.cancel();
          setState(() {
            _isActive = false;
          });
        } else {
          setState(() {
            _current = _current - 1;
          });
        }
      },
    );
  }

  void resetTimer() {
    _timer?.cancel();
    setState(() {
      _current = _start;
      _isActive = false;
    });
  }

  void pauseTimer() {
    _timer?.cancel();
    setState(() {
      _isActive = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '${(_current ~/ 60).toString().padLeft(2, '0')}:${(_current % 60).toString().padLeft(2, '0')}',
              style: Theme.of(context).textTheme.headline4,
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: _isActive ? pauseTimer : startTimer,
                  child: Text(_isActive ? 'Pause' : 'Start'),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: resetTimer,
                  child: Text('Reset'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
