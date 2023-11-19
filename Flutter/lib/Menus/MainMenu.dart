import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import '../Class/Class_User.dart';
import '../Class/Class_MedicalPrescription.dart';
import '../Controller/DataBaseConection.dart';
import '../Widgets/Cards.dart';
import 'package:gap/gap.dart';

class MainMenu extends StatefulWidget {
  final User user;
  const MainMenu({super.key, required this.user});
  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  late DateTime _selectedDay; // Dia selecionado
  late DateTime _focusedDay; // Dia que o calendário está focando
  List<Appointment> appointmentMedication = [];
  @override
  void initState() {
    super.initState();
    _selectedDay = DateTime.now(); // Inicializa com o dia atual
    _focusedDay = _selectedDay;
    fetchAppointments(widget.user.userId); // Inicializa com o dia atual
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MedAlert'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          TableCalendar(
            locale: 'pt_PT',
            firstDay: DateTime.utc(1999, 01, 01),
            lastDay: DateTime.utc(2999, 12, 31),
            focusedDay: _focusedDay,
            calendarFormat: CalendarFormat.week,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: (selectedDay, focusedDay) {
              if (!isSameDay(_selectedDay, selectedDay)) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay =
                      focusedDay; // update `_focusedDay` here if this is also intended
                });
              }
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
            calendarStyle: const CalendarStyle(
              todayDecoration: BoxDecoration(
                color: Colors.orange,
                shape: BoxShape.circle,
              ),
              selectedDecoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
            ),
            headerStyle: const HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
              leftChevronIcon: Icon(Icons.chevron_left, size: 30),
              rightChevronIcon: Icon(Icons.chevron_right, size: 30),
              leftChevronMargin: EdgeInsets.only(left: 5),
              rightChevronMargin: EdgeInsets.only(right: 5),
            ),
            calendarBuilders: CalendarBuilders(dowBuilder: (context, day) {
              for (int i = 0; i <= 7; i++) {
                if (day.weekday == i) {
                  var text = DateFormat.E('pt_PT').format(day);
                  switch (text) {
                    case "segunda":
                      text = "SEG";
                      break;
                    case "terça":
                      text = "TER";
                      break;
                    case "quarta":
                      text = "QUA";
                      break;
                    case "quinta":
                      text = "QUI";
                      break;
                    case "sexta":
                      text = "SEX";
                      break;
                    case "sábado":
                      text = "SAB";
                      break;
                    case "domingo":
                      text = "DOM";
                      break;
                    default:
                  }
                  bool isToday = DateTime.now().weekday == day.weekday;
                  return Center(
                    child: Text(
                      text,
                      style: TextStyle(
                          color: isToday ? Colors.blue : Colors.black),
                    ),
                  );
                }
              }
            }),
          ),
          const Gap(10),
          Expanded(
            child: ListView.builder(
              itemCount: appointmentMedication.length,
              itemBuilder: (context, index) {
                return MedicationCard(
                  cardMedication: CardMedication(
                    nomdeMedicamento:
                        appointmentMedication![index].nomeDoMedicamento,
                    dosagem: appointmentMedication![index].dosagem,
                    status: appointmentMedication![index].status,
                  ),
                );
              },
            ),
          ),
          // Expanded(
          //   child: Center(
          //     child: Column(
          //       mainAxisSize: MainAxisSize.min,
          //       //Preciso de um butão para carregar a lista de medicamentos
          //       children: [
          //         const SizedBox(height: 10),
          //         ElevatedButton(
          //           onPressed: () {
          //             fetchAppointments(widget.user.userId);
          //           },
          //           child: const Text('Carregar lista de medicamentos'),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
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
            icon: Icon(Icons.settings),
            label: 'Setting',
          ),
        ],
      ),
    );
  }

  void fetchAppointments(int userId) async {
    var result = await getMedication(userId);
    if (result.data is List) {
      setState(() {
        appointmentMedication = result.data
            .map<Appointment>((item) => Appointment.fromJson(item))
            .toList();
      });
    } else {
      setState(() {
        appointmentMedication = [];
      });
    }
  }
}
