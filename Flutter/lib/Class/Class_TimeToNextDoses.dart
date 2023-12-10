class TimeToNextDoses {
  final DateTime lastDoseTime;
  final int dosageIntervalHours;
  Duration timeUntilNextDose;

  TimeToNextDoses({
    required this.lastDoseTime,
    required this.dosageIntervalHours,
    this.timeUntilNextDose = const Duration(),
  }) {
    recalculateTimeUntilNextDose();
  }

  void recalculateTimeUntilNextDose() {
    DateTime nextDoseTime =
        lastDoseTime.add(Duration(hours: dosageIntervalHours));
    timeUntilNextDose = nextDoseTime.difference(DateTime.now());

    if (timeUntilNextDose.isNegative) {
      timeUntilNextDose = Duration.zero;
    }
  }
}
