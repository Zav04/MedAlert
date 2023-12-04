import 'package:flutter/material.dart';
import '../Class/Class_MedicalPrescription.dart';
import 'package:intl/intl.dart';
import '../Controller/Camera.dart';
import '../Menus/MainMenu.dart';

class MedicationCard extends StatefulWidget {
  final CardMedication cardMedication;
  final Appointment appointment;
  final bool isToday;
  final VoidCallback onUpdated; // Adiciona o callback aqui

  MedicationCard({
    Key? key,
    required this.cardMedication,
    required this.appointment,
    this.isToday = false,
    required this.onUpdated, // Torna o callback um parâmetro obrigatório
  }) : super(key: key);

  @override
  State<MedicationCard> createState() => _MedicationCard();
}

class _MedicationCard extends State<MedicationCard> {
  bool isExpanded = false;
  String imagePath = '';

  void _openCamera() async {
    final result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => CameraScreen(
          onImageCaptured: onImageCaptured,
          medicalAppointments: widget.appointment,
        ),
      ),
    );

    if (result == true) {
      widget.onUpdated(); // Chama o callback
    }
  }

  @override
  Widget build(BuildContext context) {
    String statusText;
    Color statusColor;
    Widget trailingWidget;

    switch (widget.cardMedication.status) {
      case 0:
        statusText = 'Concluído';
        statusColor = Colors.green;
        break;
      case 1:
        statusText = 'Em andamento';
        statusColor = Colors.orange;
        break;
      case 2:
        statusText = 'Cancelado';
        statusColor = Colors.red;
        break;
      case 3:
        statusText = 'Não Iniciado';
        statusColor = Colors.grey;
        break;
      default:
        statusText = 'Não Iniciado';
        statusColor = Colors.grey;
    }

    if (widget.cardMedication.status == 3 && widget.isToday) {
      trailingWidget = ElevatedButton(
        onPressed: () => _openCamera(),
        child: const Icon(Icons.camera_alt),
        style: ElevatedButton.styleFrom(
          backgroundColor: statusColor, // Cor de fundo do botão
        ),
      );
    } else {
      trailingWidget = Container(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
        decoration: BoxDecoration(
          color: statusColor,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Text(
          statusText,
          style: const TextStyle(color: Colors.white),
        ),
      );
    }
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      elevation: 4.0,
      child: ExpansionTile(
        title: Text(
          widget.cardMedication.nomdeMedicamento,
          style: const TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: !isExpanded
            ? Text('Dosagem: ${widget.cardMedication.dosagem}')
            : null,
        leading: CircleAvatar(
          backgroundColor: Colors.grey[200],
          child: const Icon(Icons.medication, color: Colors.black54),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildDetailRow('Dosagem:', widget.appointment.dosagem),
                buildDetailRow(
                    'Medicamento:', widget.appointment.nomeDoMedicamento),
                buildDetailRow('Médico:', widget.appointment.nomeDoMedico),
                buildDetailRow(
                    'Emissão:', formatDate(widget.appointment.dataDeEmissao)),
                buildDetailRow(
                    'Validade:', formatDate(widget.appointment.dataDeValidade)),
                buildDetailRow('Fim do Tratamento:',
                    formatDate(widget.appointment.dataDeFim)),
              ],
            ),
          ),
        ],
        onExpansionChanged: (expanded) {
          setState(() {
            isExpanded = expanded;
          });
        },
        trailing: trailingWidget,
      ),
    );
  }

  Widget buildDetailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Text(
            '$title ',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Flexible(
            child: Text(
              value,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  String formatDate(String dateString) {
    DateTime date = DateTime.parse(dateString);
    return DateFormat('dd/MM/yyyy').format(date);
  }

  void onImageCaptured(String imagePath) {
    setState(() {
      this.imagePath = imagePath;
    });
  }

  bool isWithinMedicationPeriod(String startDateString, String endDateString) {
    DateTime startDate = DateTime.parse(startDateString);
    DateTime endDate = DateTime.parse(endDateString);
    DateTime today = DateTime.now();

    // Verifica se a data atual está entre as datas de início e fim
    return today.isAfter(startDate.subtract(const Duration(days: 1))) &&
        today.isBefore(endDate.add(const Duration(days: 1)));
  }
}
