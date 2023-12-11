import 'package:flutter/material.dart';
import '../Class/Class_AppointmentInspect.dart';
import 'package:intl/intl.dart';

class InspectionCard extends StatefulWidget {
  final AppointmentInspect appointment;

  InspectionCard({
    Key? key,
    required this.appointment,
  }) : super(key: key);

  @override
  State<InspectionCard> createState() => _MedicationCardState();
}

class _MedicationCardState extends State<InspectionCard> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    // Definir status e cor
    String statusText;
    Color statusColor;
    switch (widget.appointment.status) {
      case 0: // Concluído
        statusText = 'Concluído';
        statusColor = Colors.green;
        break;
      case 1: // Em andamento
        statusText = 'Em andamento';
        statusColor = Colors.orange;
        break;
      case 2: // Cancelado
        statusText = 'Cancelado';
        statusColor = Colors.red;
        break;
      default: // Não iniciado ou outro status
        statusText = 'Não Iniciado';
        statusColor = Colors.grey;
    }

    // Configurar trailing widget
    Widget trailingWidget = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          decoration: BoxDecoration(
            color: statusColor,
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Text(statusText, style: const TextStyle(color: Colors.white)),
        ),
      ],
    );

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      elevation: 4.0,
      child: ExpansionTile(
        title: Text(
          widget.appointment.nomeMedicamento,
          style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        subtitle: !isExpanded
            ? Text('Dosagem: ${widget.appointment.dosagemNotas}')
            : null, // Corrigido o fechamento do parêntese aqui
        leading: CircleAvatar(
          backgroundColor: Colors.grey[200],
          child: const Icon(Icons.medication, color: Colors.black54),
        ),
        children: _buildDetails(),
        onExpansionChanged: (expanded) {
          setState(() {
            isExpanded = expanded;
          });
        },
        trailing: trailingWidget,
      ),
    );
  }

  List<Widget> _buildDetails() {
    // Inicialize a lista de detalhes com todos os widgets comuns
    List<Widget> details = [
      buildDetailRow('Dosagem:', widget.appointment.dosagemNotas),
      buildDetailRow('Medicamento:', widget.appointment.dosagemNotas),
      buildDetailRow('Médico:', widget.appointment.dosagemNotas),
      buildDetailRow('Emissão:', formatDate(widget.appointment.dataDeEmissao)),
      buildDetailRow('Validade:', formatDate(widget.appointment.dosagemNotas)),
      buildDetailRow(
          'Fim do Tratamento:', formatDate(widget.appointment.dataDeFim)),
    ];
    return details;
  }

  Widget buildDetailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(
          left: 16.0, bottom: 8.0), // Adiciona um espaçamento à esquerda
      child: Row(
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(
              width:
                  8.0), // Você pode adicionar um SizedBox para mais espaçamento entre o título e o valor
          Flexible(child: Text(value, overflow: TextOverflow.ellipsis)),
        ],
      ),
    );
  }

  String formatDate(String dateString) {
    DateTime date = DateTime.parse(dateString);
    return DateFormat('dd/MM/yyyy').format(date);
  }
}
