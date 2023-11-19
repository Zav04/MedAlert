class Appointment {
  final String idPrescricao;
  final String idDosagem;
  final String idmedicamento;

  Appointment({
    required this.idPrescricao,
    required this.idDosagem,
    required this.idmedicamento,
  });
}

List<Appointment>? appointmentData;
