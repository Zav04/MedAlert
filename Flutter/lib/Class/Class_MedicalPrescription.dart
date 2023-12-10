import '../Class/Class_TimeToNextDoses.dart';

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
  TimeToNextDoses? timeToNextDoses;

  Appointment({
    required this.idPrescricao,
    required this.nomeUtilizador,
    required this.dosagem,
    required this.nomeDoMedicamento,
    required this.nomeDoMedico,
    required this.dataDeEmissao,
    required this.status,
    required this.dataDeValidade,
    required this.dataDeincio,
    required this.dataDeFim,
    this.timeToNextDoses,
  });

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      idPrescricao: json['id_medical_prescription'],
      nomeUtilizador: json['full_name'],
      dosagem: json['dosage_note'],
      nomeDoMedicamento: json['medicine_name'],
      nomeDoMedico: json['medic_name'],
      dataDeEmissao: json['emission_date'],
      status: json['prescription_status'],
      dataDeValidade: json['dt_valid'],
      dataDeincio: json['dt_start'],
      dataDeFim: json['dt_end'],
      // timeToNextDoses não é inicializado aqui; será configurado posteriormente
    );
  }

  void initializeTimeToNextDoses(
      DateTime? lastDoseTime, int? dosageIntervalHours) {
    // Nota: 'int?' permite nulos
    if (dosageIntervalHours != null && lastDoseTime != null) {
      // Se dosageIntervalHours não é nulo, inicialize timeToNextDoses normalmente
      timeToNextDoses = TimeToNextDoses(
        lastDoseTime: lastDoseTime,
        dosageIntervalHours: dosageIntervalHours,
      );
    } else {
      // Trate o caso em que dosageIntervalHours é nulo
      // Talvez você queira atribuir um valor padrão ou lidar com o caso nulo de alguma outra forma
    }
  }
}
