import 'package:flutter/material.dart';
import '../Class/Class_MedicalPrescription.dart';

class MedicationCard extends StatelessWidget {
  final CardMedication cardMedication;

  MedicationCard({Key? key, required this.cardMedication}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String statusText;
    Color statusColor;

    switch (cardMedication.status) {
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
      default:
        statusText = 'Desconhecido';
        statusColor = Colors.grey;
    }

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      elevation: 4.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.grey[200],
              child: const Icon(Icons.medication, color: Colors.black54),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cardMedication.nomdeMedicamento,
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text('Dosagem: ${cardMedication.dosagem}'),
                    // Outros detalhes podem ser adicionados aqui
                  ],
                ),
              ),
            ),
            Container(
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
            ),
          ],
        ),
      ),
    );
  }
}
