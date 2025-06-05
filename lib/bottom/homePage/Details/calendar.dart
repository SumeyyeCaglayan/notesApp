import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class CalendarAA extends StatefulWidget {
  const CalendarAA({super.key});

  @override
  State<CalendarAA> createState() => _CalendarAAState();
}

class _CalendarAAState extends State<CalendarAA> {
  DateTime today = DateTime.now();
  DateTime? _selectedDay;

  Map<String, List<CalendarEvent>> specailEvent = {
    '2024-12-31': [CalendarEvent("Makine Öğrenmesi Sınavı")],
  };

  Map<DateTime, List<CalendarEvent>> events = {};
  final TextEditingController _calcontroller = TextEditingController();
  late final ValueNotifier<List<CalendarEvent>> _selectedEvents;

  @override
  void initState() {
    super.initState();
    _selectedDay = today;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
    _loadEvents();
  }

  Future<void> _loadEvents() async {
    final prefs = await SharedPreferences.getInstance();
    final String? eventsString = prefs.getString('events');
    if (eventsString != null) {
      final decoded = jsonDecode(eventsString) as Map<String, dynamic>;
      events = decoded.map((key, value) {
        final dateTime = DateTime.parse(key);
        final eventList = (value as List).map((e) => CalendarEvent(e)).toList();
        return MapEntry(dateTime, eventList);
      });
      _selectedEvents.value = _getEventsForDay(_selectedDay!);
    }
  }

  Future<void> _saveEvents() async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = events.map((key, value) {
      final dateTimeString = key.toIso8601String();
      final eventList = value.map((e) => e.title).toList();
      return MapEntry(dateTimeString, eventList);
    });
    prefs.setString('events', jsonEncode(encoded));
  }

  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      today = day;
      _selectedDay = day;
      _selectedEvents.value = _getEventsForDay(day);
    });
  }

  List<CalendarEvent> _getEventsForDay(DateTime day) {
    final DateFormat formatter = DateFormat("yyyy-MM-dd");
    var formattedDay = formatter.format(day);
    return events[day] ?? specailEvent[formattedDay] ?? [];
  }

  void _deleteEvent(CalendarEvent event) {
    final DateFormat formatter = DateFormat("yyyy-MM-dd");
    var formattedDay = formatter.format(_selectedDay!);

    if (specailEvent[formattedDay] != null &&
        specailEvent[formattedDay]!.contains(event)) {
      return;
    }

    setState(() {
      events[_selectedDay]?.remove(event);
      if (events[_selectedDay]?.isEmpty ?? false) {
        events.remove(_selectedDay);
      }
      _selectedEvents.value = _getEventsForDay(_selectedDay!);
    });
    _saveEvents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70.0),
        child: AppBar(
          automaticallyImplyLeading: true,
          flexibleSpace: Container(
            color: Color(0xFFE9E9D9),
            alignment: Alignment.center,
            child: Text(
              "Takvim",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(bottom: 20),
                  child: Text(
                    today.toString().split(" ")[0],
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: TableCalendar(
                    rowHeight: 43,
                    headerStyle: HeaderStyle(
                      formatButtonVisible: false,
                      titleCentered: true,
                      titleTextStyle: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      leftChevronIcon: Icon(
                        Icons.chevron_left,
                        color: Color(0xFF87986A),
                      ),
                      rightChevronIcon: Icon(
                        Icons.chevron_right,
                        color: Color(0xFF87986A),
                      ),
                    ),
                    calendarStyle: CalendarStyle(
                      isTodayHighlighted: true,
                      outsideDaysVisible: true,
                      selectedDecoration: BoxDecoration(
                        color: Color(0xFF87986A),
                        shape: BoxShape.circle,
                      ),
                      todayDecoration: BoxDecoration(
                        color: Color.fromARGB(255, 247, 247, 188),
                        shape: BoxShape.circle,
                      ),
                      selectedTextStyle: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      todayTextStyle: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      weekendTextStyle: TextStyle(color: Colors.red),
                    ),
                    availableGestures: AvailableGestures.all,
                    selectedDayPredicate: (day) => isSameDay(day, today),
                    focusedDay: today,
                    firstDay: DateTime.utc(2000, 01, 01),
                    lastDay: DateTime.utc(2050, 12, 31),
                    onDaySelected: _onDaySelected,
                    eventLoader: _getEventsForDay,
                  ),
                ),
                const SizedBox(height: 20),
                ValueListenableBuilder<List<CalendarEvent>>(
                  valueListenable: _selectedEvents,
                  builder: (context, value, _) {
                    return Expanded(
                      child: ListView.builder(
                        itemCount: value.length,
                        itemBuilder: (context, index) {
                          final event = value[index];
                          final formattedDay = DateFormat(
                            "yyyy-MM-dd",
                          ).format(_selectedDay!);
                          final isSpecialEvent =
                              specailEvent[formattedDay]?.contains(event) ??
                              false;

                          return Container(
                            margin: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: ListTile(
                              title: Text(event.title),
                              trailing:
                                  isSpecialEvent
                                      ? null
                                      : IconButton(
                                        icon: Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ),
                                        onPressed: () {
                                          _deleteEvent(event);
                                        },
                                      ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 100,
            right: 80,
            width: 250,
            child: FloatingActionButton.extended(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
                side: BorderSide(color: Colors.black, width: 2),
              ),
              elevation: 5,
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      scrollable: true,
                      title: Text(
                        "Yapılacak İşler",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      content: Padding(
                        padding: EdgeInsets.all(10),
                        child: TextField(
                          controller: _calcontroller,
                          decoration: InputDecoration(
                            hintText: "Bir iş ekleyin",
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      actions: [
                        ElevatedButton(
                          onPressed: () {
                            if (_selectedDay != null &&
                                _calcontroller.text.isNotEmpty) {
                              setState(() {
                                if (events[_selectedDay] != null) {
                                  events[_selectedDay]!.add(
                                    CalendarEvent(_calcontroller.text),
                                  );
                                } else {
                                  events[_selectedDay!] = [
                                    CalendarEvent(_calcontroller.text),
                                  ];
                                }
                                _selectedEvents.value = _getEventsForDay(
                                  _selectedDay!,
                                );
                              });
                              _saveEvents();
                              _calcontroller.clear();
                              Navigator.of(context).pop();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                            side: BorderSide(color: Colors.grey, width: 1),
                          ),
                          child: Text(
                            "Ekle",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
              label: Center(
                child: Text(
                  "Eklenilecek Görev",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w800,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CalendarEvent {
  final String title;
  CalendarEvent(this.title);
}
