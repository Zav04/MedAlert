import 'dart:async';
import 'package:flutter/material.dart';
import '../Class/Class_TimeToNextDoses.dart';

class MedicationTimerWidget extends StatefulWidget {
  final TimeToNextDoses timeToNextDose;

  MedicationTimerWidget({Key? key, required this.timeToNextDose})
      : super(key: key);

  @override
  _MedicationTimerWidgetState createState() => _MedicationTimerWidgetState();
}

class _MedicationTimerWidgetState extends State<MedicationTimerWidget> {
  late Timer timer;

  @override
  void initState() {
    super.initState();
    timer =
        Timer.periodic(const Duration(seconds: 1), (Timer t) => updateTimer());
  }

  void updateTimer() {
    setState(() {
      // Aqui você recalcula o timeUntilNextDose baseado na hora atual
      // Você precisará ajustar essa lógica para o seu caso de uso específico
      widget.timeToNextDose.recalculateTimeUntilNextDose();
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Formata o Duration para um formato mais legível
    String formattedTime =
        formatDuration(widget.timeToNextDose.timeUntilNextDose);

    return Column(
      children: <Widget>[
        const Text('Tempo até a próxima dose:'),
        Text(formattedTime,
            style: const TextStyle(fontWeight: FontWeight.bold)),
        // Outros elementos do widget, se necessário
      ],
    );
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }
}
