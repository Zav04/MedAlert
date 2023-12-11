import 'package:flutter/material.dart';
import '../Class/Class_MedicalPrescription.dart';
import 'package:intl/intl.dart';
import '../Controller/Camera.dart';
import '../Widgets/MedicationTimer.dart';
import '../Widgets/Notification_Service.dart';

class MedicationCard extends StatefulWidget {
  final Appointment appointment;
  final bool isToday;
  final VoidCallback onUpdated;

  MedicationCard({
    Key? key,
    required this.appointment,
    this.isToday = false,
    required this.onUpdated,
  }) : super(key: key);

  @override
  State<MedicationCard> createState() => _MedicationCardState();
}

class _MedicationCardState extends State<MedicationCard> {
  bool isExpanded = false;
  bool showNotificationButton = false;
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
    bool isStatusThreeAndToday =
        (widget.appointment.status == 3 && widget.isToday);

    bool isStatusOneAndTimeZeroAndToday = (widget.appointment.status == 1 &&
        widget.appointment.timeToNextDoses?.timeUntilNextDose ==
            Duration.zero &&
        widget.isToday);
    if (widget.appointment.timeToNextDoses?.timeUntilNextDose != Duration.zero)
      showNotificationButton = false;

    // Configurar trailing widget
    Widget trailingWidget = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (showNotificationButton && widget.isToday)
          IconButton(
            icon: const Icon(Icons.notifications),
            color: Colors.blue, // Ou outra cor que você preferir
            onPressed: () {
              notificationMedication();
            },
          ),
        if (isStatusThreeAndToday || isStatusOneAndTimeZeroAndToday)
          ElevatedButton(
            onPressed: _openCamera,
            child: const Icon(Icons.camera_alt),
            style: ElevatedButton.styleFrom(backgroundColor: statusColor),
          ),
        if (!isStatusThreeAndToday && !isStatusOneAndTimeZeroAndToday)
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
            decoration: BoxDecoration(
              color: statusColor,
              borderRadius: BorderRadius.circular(20.0),
            ),
            child:
                Text(statusText, style: const TextStyle(color: Colors.white)),
          ),
      ],
    );

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      elevation: 4.0,
      child: ExpansionTile(
        title: Text(
          widget.appointment.nomeDoMedicamento,
          style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        subtitle: !isExpanded &&
                widget.appointment.timeToNextDoses != null &&
                widget.appointment.timeToNextDoses != Duration.zero &&
                widget.isToday == true
            ? MedicationTimerWidget(
                timeToNextDose: widget.appointment.timeToNextDoses!,
                onTimeEnds: onTimeEnds)
            : (!isExpanded
                ? Text('Dosagem: ${widget.appointment.dosagem}')
                : null),
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
      buildDetailRow('Dosagem:', widget.appointment.dosagem),
      buildDetailRow('Medicamento:', widget.appointment.nomeDoMedicamento),
      buildDetailRow('Médico:', widget.appointment.nomeDoMedico),
      buildDetailRow('Emissão:', formatDate(widget.appointment.dataDeEmissao)),
      buildDetailRow(
          'Validade:', formatDate(widget.appointment.dataDeValidade)),
      buildDetailRow(
          'Fim do Tratamento:', formatDate(widget.appointment.dataDeFim)),
    ];

    // Adicione o MedicationTimerWidget se timeToNextDoses não for nulo e o cartão estiver expandido
    if (isExpanded && widget.appointment.timeToNextDoses != null) {
      details.add(MedicationTimerWidget(
          timeToNextDose: widget.appointment.timeToNextDoses!,
          onTimeEnds: onTimeEnds));
    }

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
      widget.onUpdated();
    }
  }

  String formatDate(String dateString) {
    DateTime date = DateTime.parse(dateString);
    return DateFormat('dd/MM/yyyy').format(date);
  }

  void onImageCaptured(String imagePath) {
    setState(() {});
  }

  bool isWithinMedicationPeriod(String startDateString, String endDateString) {
    DateTime startDate = DateTime.parse(startDateString);
    DateTime endDate = DateTime.parse(endDateString);
    DateTime today = DateTime.now();

    // Verifica se a data atual está entre as datas de início e fim
    return today.isAfter(startDate.subtract(const Duration(days: 1))) &&
        today.isBefore(endDate.add(const Duration(days: 1)));
  }

  void onTimeEnds() {
    setState(() {
      showNotificationButton = true;
    });
  }

  void notificationMedication() {
    setState(() {
      LocalNotifications.showNotification(
          title: 'Não se es esqueça de continuar o tratamento',
          body: widget.appointment.nomeDoMedicamento.toString() +
              ' ' +
              widget.appointment.dosagem.toString(),
          payload: '');
      widget.onUpdated();
    });
  }
}
