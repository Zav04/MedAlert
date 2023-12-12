import 'dart:convert';
import 'dart:typed_data';

class AppointmentInspect {
  final int idPrescricao;
  final int iduser;
  final String historicoData;
  final String dataDeEmissao;
  final String dataDeincio;
  final String dataDeFim;
  final int dosagemTempo;
  final String dosagemNotas;
  final String nomeMedicamento;
  final String medicamentoInfo;
  final String nomeMedico;
  final Uint8List? imageData;
  final int status;

  // image_data BYTEA

  AppointmentInspect({
    required this.idPrescricao,
    required this.iduser,
    required this.historicoData,
    required this.dataDeEmissao,
    required this.dataDeincio,
    required this.dataDeFim,
    required this.dosagemTempo,
    required this.dosagemNotas,
    required this.nomeMedicamento,
    required this.medicamentoInfo,
    required this.nomeMedico,
    required this.imageData,
    required this.status,
  });

  factory AppointmentInspect.fromJson(Map<String, dynamic> json) {
    return AppointmentInspect(
      idPrescricao: json['prescription_id'],
      iduser: json['patient_user_id'],
      historicoData: json['historic_date'],
      dataDeEmissao: json['prescription_date'],
      dataDeincio: json['start_date'],
      dataDeFim: json['end_date'],
      dosagemTempo: json['dosage_time'],
      dosagemNotas: json['dosage_note'],
      nomeMedicamento: json['medicine_name'],
      medicamentoInfo: json['medicine_info'],
      nomeMedico: json['medic_name'],
      imageData: json['image_data'].isNotEmpty
          ? decodeImageData(json['image_data'])
          : null,
      status: json['prescription_status'],
    );
  }

  // Make this method static so it can be used in the factory constructor
  static Uint8List? decodeImageData(String base64String) {
    try {
      String properBase64String = base64String.replaceAll(r'\x', '');
      return base64Decode(properBase64String);
    } on FormatException catch (e) {
      return null;
    }
  }
}
