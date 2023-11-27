class Appointment {
  final int idPrescricao;
  final String nomeUtilizador;
  final String dosagem;
  final String nomeDoMedicamento;
  final String nomeDoMedico;
  final String dataDeEmissao;
  final int status;
  final String dataDeValidade;
  final String dataDeincio;
  final String dataDeFim;

  Appointment(
      {required this.idPrescricao,
      required this.nomeUtilizador,
      required this.dosagem,
      required this.nomeDoMedicamento,
      required this.nomeDoMedico,
      required this.dataDeEmissao,
      required this.status,
      required this.dataDeValidade,
      required this.dataDeincio,
      required this.dataDeFim});

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      idPrescricao: json['id_medical_prescription'] as int,
      nomeUtilizador: json['full_name'] as String,
      dosagem: json['dosage_note'] as String,
      nomeDoMedicamento: json['medicine_name'] as String,
      nomeDoMedico: json['medic_name'] as String,
      dataDeEmissao: json['emission_date'] as String,
      status: json['prescription_status'] as int,
      dataDeValidade: json['dt_valid'] as String,
      dataDeincio: json['dt_start'] as String,
      dataDeFim: json['dt_end'] as String,
    );
  }
}

class CardMedication {
  final String nomdeMedicamento;
  final String dosagem;
  final int status;
  // 0: Concluído, 1: Em andamento, 2: Cancelado

  CardMedication(
      {required this.nomdeMedicamento,
      required this.dosagem,
      required this.status});
}

List<CardMedication>? appointmentCards;
