import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../view_model/pickup/pickup_timer_provider.dart';


class PickupTimerWidget extends StatelessWidget {
  const PickupTimerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PickupTimerProvider>(context);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Pickup In",
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _timeBox(provider.hours, "Hours"),
              _colon(),
              _timeBox(provider.minutes, "Minutes"),
              _colon(),
              _timeBox(provider.seconds, "Seconds"),
            ],
          ),
          const SizedBox(height: 20),
          LinearProgressIndicator(
            value: provider.progress,
            color: Colors.white,
            backgroundColor: Colors.red.shade300,
            minHeight: 10,
            borderRadius: BorderRadius.circular(15),
          ),
        ],
      ),
    );
  }

  Widget _colon() => const Padding(
    padding: EdgeInsets.symmetric(horizontal: 8.0),
    child: Text(
      ":",
      style: TextStyle(
        color: Colors.white,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    ),
  );

  Widget _timeBox(String value, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.red.shade400,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
