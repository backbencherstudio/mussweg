import 'dart:async';
import 'package:flutter/material.dart';

class PickupTimerProvider extends ChangeNotifier {
  late DateTime pickupTime;
  late Duration remaining;
  late Duration totalDuration;
  Timer? _timer;

  PickupTimerProvider() {
    pickupTime = DateTime.now().add(const Duration(hours: 0, minutes: 2));
    totalDuration = pickupTime.difference(DateTime.now());
    _initTimer();
  }

  void _initTimer() {
    remaining = pickupTime.difference(DateTime.now());
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final diff = pickupTime.difference(DateTime.now());
      if (diff.isNegative) {
        remaining = Duration.zero;
        timer.cancel();
      } else {
        remaining = diff;
      }
      notifyListeners();
    });
  }

  void setPickupTime(DateTime newPickupTime) {
    pickupTime = newPickupTime;
    totalDuration = pickupTime.difference(DateTime.now());
    _timer?.cancel();
    _initTimer();
    notifyListeners();
  }

  double get progress {
    if (totalDuration.inSeconds == 0) return 1.0;
    final elapsed = totalDuration.inSeconds - remaining.inSeconds;
    return elapsed / totalDuration.inSeconds;
  }

  String get hours => remaining.inHours.toString().padLeft(2, '0');
  String get minutes => (remaining.inMinutes % 60).toString().padLeft(2, '0');
  String get seconds => (remaining.inSeconds % 60).toString().padLeft(2, '0');

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
