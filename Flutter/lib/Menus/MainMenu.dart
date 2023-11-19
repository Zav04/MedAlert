import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import '../Class/Class_User.dart';
import '../Class/Class_MedicalPrescription.dart';
import '../Controller/DataBaseConection.dart';

class MainMenu extends StatefulWidget {
  final User user;
  const MainMenu({super.key, required this.user});
  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  late DateTime _selectedDay; // Dia selecionado
  late DateTime _focusedDay; // Dia que o calendário está focando
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
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay; // Atualiza o dia selecionado
                _focusedDay = focusedDay; // Atualiza o dia focado
              });
            },
            onPageChanged: (focusedDay) {
              // Atualiza apenas o dia focado
              _focusedDay = focusedDay;
            },
            calendarFormat: CalendarFormat.week,
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
          Expanded(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                //Preciso de um butão para carregar a lista de medicamentos
                children: [
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      fetchAppointments(widget.user.userId);
                    },
                    child: const Text('Carregar lista de medicamentos'),
                  ),
                ],
              ),
            ),
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
            icon: Icon(Icons.settings),
            label: 'Setting',
          ),
        ],
      ),
    );
  }

  void fetchAppointments(int userId) async {
    var result = await getMedication(userId);
    appointmentMedication = result.data;
  }
}
