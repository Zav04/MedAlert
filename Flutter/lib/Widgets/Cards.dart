import 'package:flutter/material.dart';
import '../Class/Class_MedicalPrescription.dart';
import 'package:intl/intl.dart';
import '../Controller/Camera.dart';

import 'package:image_picker/image_picker.dart';

class MedicationCard extends StatefulWidget {
  final CardMedication cardMedication;
  final Appointment appointment;

  MedicationCard({
    Key? key,
    required this.cardMedication,
    required this.appointment,
  }) : super(key: key);
  @override
  State<MedicationCard> createState() => _MedicationCard();
}

class _MedicationCard extends State<MedicationCard> {
  bool isExpanded = false;
  String imagePath = '';

  void _openCamera() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => CameraScreen(onImageCaptured: onImageCaptured),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String statusText;
    Color statusColor;

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
        statusText = 'Iniciar';
        statusColor = Colors.grey;
        break;
      default:
        statusText = 'Iniciar';
        statusColor = Colors.grey;
    }

    Widget trailingWidget = (widget.cardMedication.status == 3)
        ? ElevatedButton(
            onPressed: _openCamera,
            child: Icon(Icons.camera_alt),
            style: ElevatedButton.styleFrom(
              backgroundColor: statusColor, // Cor de fundo do botão
            ),
          )
        : Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
            decoration: BoxDecoration(
              color: statusColor,
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Text(
              statusText,
              style: const TextStyle(color: Colors.white),
            ),
          );
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
}
