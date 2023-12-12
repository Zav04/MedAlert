import 'package:flutter/material.dart';
import '../Class/Class_User.dart';
import '../Class/Class_AppointmentInspect.dart';
import '../Controller/DataBaseConection.dart';
import '../Widgets/Cards_Inspection.dart';

class MainMenuInspection extends StatefulWidget {
  final User user;
  const MainMenuInspection({super.key, required this.user});
  @override
  State<MainMenuInspection> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenuInspection> {
  List<AppointmentInspect> appointmentFamily = [];
  List<AppointmentInspect> filtredappointmentFamily = [];
  Map<int, String> associatedPaciente = {};
  int? selectedPatient;

  @override
  void initState() {
    fetchFamilyAppointments(widget.user.userId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Estrutura do Scaffold...
      body: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 50.0),
            child: DropdownButtonHideUnderline(
              child: InputDecorator(
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.zero,
                  border: null,
                  labelText: 'Selecione um paciente',
                  alignLabelWithHint: true,
                ),
                child: DropdownButton<int>(
                  isExpanded: true,
                  value: selectedPatient,
                  items: associatedPaciente.entries.map((entry) {
                    return DropdownMenuItem<int>(
                      value: entry.key,
                      child: Text(
                        entry.value,
                        textAlign: TextAlign.center,
                      ),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      onSelectedPatientChanged(newValue);
                    });
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: filtredappointmentFamily.length,
                itemBuilder: (context, index) {
                  final appointment = filtredappointmentFamily[index];
                  return InspectionCard(
                    appointment: appointment,
                  );
                }),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blue,
        fixedColor: Colors.white,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.chair_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.white,
            icon: Icon(Icons.settings_outlined),
            label: 'Setting',
          ),
        ],
      ),
    );
  }

  void fetchFamilyAppointments(int familyUserId) async {
    var result = await getFamilyMemberMedicalHistory(familyUserId);
    if (result.data is List) {
      List<AppointmentInspect> tempAppointmentFamily = result.data
          .map<AppointmentInspect>((item) => AppointmentInspect.fromJson(item))
          .toList();

      setState(() {
        appointmentFamily = tempAppointmentFamily;
        fetchAssociatedNamePatients(familyUserId);
      });
    } else {
      setState(() {
        appointmentFamily = [];
      });
    }
  }

  void fetchAssociatedNamePatients(int userId) async {
    var result = await getPacientNameAssociated(userId); // Sua chamada de API
    if (result.data is List) {
      Map<int, String> tempAssociatedPatients = {};
      for (var item in result.data) {
        int id = item['patient_user_id'];
        String name = item['patient_name'];
        tempAssociatedPatients[id] = name;
      }

      setState(() {
        associatedPaciente = tempAssociatedPatients;
        selectedPatient = associatedPaciente.keys.first;
        filterAppointmentsForSelectedPatient(selectedPatient);
      });
    } else {
      setState(() {
        associatedPaciente = {};
      });
    }
  }

  void filterAppointmentsForSelectedPatient(int? selectedPatientId) {
    if (selectedPatientId == null) {
      setState(() {
        filtredappointmentFamily = [];
      });
      return; // Isto completa a função se selectedPatientId é null.
    }
    List<AppointmentInspect> filteredList = appointmentFamily
        .where((appointment) => appointment.iduser == selectedPatientId)
        .toList();

    setState(() {
      filtredappointmentFamily = filteredList;
    });
  }

  void onSelectedPatientChanged(int? newSelectedPatientId) {
    setState(() {
      selectedPatient = newSelectedPatientId;
    });
    filterAppointmentsForSelectedPatient(newSelectedPatientId);
  }
}
