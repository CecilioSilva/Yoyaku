import 'package:yoyaku/classes/data_sync.dart';
import 'package:yoyaku/components/views/item_view.dart';
import 'package:yoyaku/models/database_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarTab extends StatefulWidget {
  const CalendarTab({Key? key}) : super(key: key);

  @override
  State<CalendarTab> createState() => _CalendarTabState();
}

class _CalendarTabState extends State<CalendarTab> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<DataSync>(context).reload();

    DateFormat _dateFormat = DateFormat.yMMMMd();

    return Column(
      children: [
        TableCalendar<Item>(
          onFormatChanged: (format) {},
          focusedDay: _focusedDay,
          firstDay: DateTime(1980),
          lastDay: DateTime(2100),
          selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
          onDaySelected: (DateTime selectedDay, DateTime focusedDay) {
            setState(() {
              _selectedDay = selectedDay;
              _focusedDay = focusedDay;
            });
          },
          startingDayOfWeek: StartingDayOfWeek.monday,
          rangeSelectionMode: RangeSelectionMode.disabled,
          eventLoader: (DateTime selectedDay) {
            var allItems = Provider.of<DataSync>(context).allItems;
            List<Item> items = [];
            for (Item item in allItems) {
              if (isSameDay(item.releaseDate, selectedDay) && !item.canceled) {
                items.add(item);
              }
            }
            return items;
          },
          calendarStyle: CalendarStyle(
            todayDecoration: ShapeDecoration(
              color: Colors.red.withOpacity(0.7),
              shape: const CircleBorder(),
            ),
            selectedDecoration: const ShapeDecoration(
              color: Colors.orange,
              shape: CircleBorder(),
            ),
            markerDecoration: const ShapeDecoration(
              color: Colors.red,
              shape: CircleBorder(),
            ),
          ),
        ),
        const SizedBox(height: 8.0),
        const Divider(
          height: 2,
          color: Colors.orange,
        ),
        Expanded(
          child: ItemView(
            itemFuture: Provider.of<DataSync>(context).getItemsByDay(
              _selectedDay!,
            ),
            title: _dateFormat.format(_selectedDay!),
            canChange: false,
          ),
        ),
      ],
    );
  }
}
