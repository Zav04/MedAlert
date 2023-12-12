import 'package:flutter/material.dart';
import '../Class/Class_AppointmentInspect.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'dart:typed_data';

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
            ? Text('Data: ${formatDate(widget.appointment.historicoData)}')
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
      buildDetailRow('Nome do Medicamento', widget.appointment.nomeMedicamento),
      buildDetailRow(
          'Informação do Medicamento:', widget.appointment.medicamentoInfo),
      buildDetailRow(
          'Horario de Ingestão:', formatDate(widget.appointment.historicoData)),
      buildDetailRow('Dosagem:', widget.appointment.dosagemNotas),
      buildDetailRow('Tempo entre Dosagens (Horas):',
          widget.appointment.dosagemTempo.toString()),
      buildDetailRow('Data de Inicio do Tratamento:',
          formatDate(widget.appointment.dataDeincio)),
      buildDetailRow('Data de Fim do Tratamento:',
          formatDate(widget.appointment.dataDeFim)),
      buildDetailRow('Nome do Médico:', widget.appointment.nomeMedico),
    ];

    if (widget.appointment.imageData != null) {
      details.add(
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: ElevatedButton(
            child: const Text("Ver Imagem"),
            onPressed: () =>
                _showImageDialog(context, widget.appointment.imageData!),
          ),
        ),
      );
    }

    return details;
  }

  void _showImageDialog(BuildContext context, Uint8List imageBytes) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Image.memory(imageBytes),
          actions: <Widget>[
            TextButton(
              child: const Text("Fechar"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

Widget buildDetailRow(String title, String value) {
  return Padding(
    padding: const EdgeInsets.only(
        left: 16.0,
        bottom: 8.0,
        right: 5.0), // Adiciona espaçamento à direita e à esquerda
    child: Row(
      crossAxisAlignment:
          CrossAxisAlignment.start, // Alinha o texto no início da linha
      children: [
        Expanded(
          flex: 2, // Flex para a coluna do título
          child:
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        ),
        Expanded(
          flex:
              3, // Flex para a coluna do valor, dando mais espaço para o conteúdo
          child: Text(value,
              overflow: TextOverflow.ellipsis,
              maxLines: 5), // Permite até 3 linhas para o texto
        ),
      ],
    ),
  );
}

String formatDate(String dateString) {
  DateTime date = DateTime.parse(dateString);
  if (date.hour != 0 || date.minute != 0 || date.second != 0) {
    // Se houver uma componente de hora na data, formate com data e hora
    return DateFormat('dd/MM/yyyy HH:mm:ss').format(date);
  } else {
    // Se não houver uma componente de hora, formate apenas com a data
    return DateFormat('dd/MM/yyyy').format(date);
  }
}
