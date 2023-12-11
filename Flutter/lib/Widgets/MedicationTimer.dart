import 'dart:async';
import 'package:flutter/material.dart';
import '../Class/Class_TimeToNextDoses.dart';

class MedicationTimerWidget extends StatefulWidget {
  final TimeToNextDoses timeToNextDose;
  final VoidCallback onTimeEnds;

  MedicationTimerWidget(
      {Key? key, required this.timeToNextDose, required this.onTimeEnds})
      : super(key: key);

  @override
  _MedicationTimerWidgetState createState() => _MedicationTimerWidgetState();
}

class _MedicationTimerWidgetState extends State<MedicationTimerWidget> {
  late Timer timer;
  bool isZero = false;

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
      if (widget.timeToNextDose.timeUntilNextDose == Duration.zero) {
        widget.onTimeEnds();
      }
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
    if (widget.timeToNextDose.timeUntilNextDose == Duration.zero) {
      isZero = true;
    } else {
      isZero = false;
    }

    return Column(
      children: <Widget>[
        const Text('Tempo até a próxima dose:'),
        Text(
          formattedTime,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: isZero
                ? Colors.red
                : Colors.black, // Texto fica vermelho se o tempo for zero
          ),
        ),
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
