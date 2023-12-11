import 'dart:convert';
import 'dart:typed_data';

class AppointmentInspect {
  final int idPrescricao;
  final String historicoData;
  final String dataDeEmissao;
  final String dataDeincio;
  final String dataDeFim;
  final String dosagemTempo;
  final String dosagemNotas;
  final String nomeMedicamento;
  final String medicamentoInfo;
  final String nomeMedico;
  //final Uint8List imageData;
  final int status;

  // image_data BYTEA

  AppointmentInspect({
    required this.idPrescricao,
    required this.historicoData,
    required this.dataDeEmissao,
    required this.dataDeincio,
    required this.dataDeFim,
    required this.dosagemTempo,
    required this.dosagemNotas,
    required this.nomeMedicamento,
    required this.medicamentoInfo,
    required this.nomeMedico,
    //required this.imageData,
    required this.status,
  });

  factory AppointmentInspect.fromJson(Map<String, dynamic> json) {
    return AppointmentInspect(
      idPrescricao: json['id_medical_prescription'],
      historicoData: json['date'],
      dataDeEmissao: json['emission_date'],
      dataDeincio: json['dt_start'],
      dataDeFim: json['dt_end'],
      dosagemTempo: json['dosage_time'],
      dosagemNotas: json['dosage_note'],
      nomeMedicamento: json['medicine_name'],
      medicamentoInfo: json['medicine_info'],
      nomeMedico: json['medic_name'],
      //imageData: base64Decode(json['image_data']),
      status: json['prescription_status'],
    );
  }
}
