// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HorizontalDatePicker extends StatefulWidget {
  final Function(DateTime date) onChanged;
  const HorizontalDatePicker({
    Key? key,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<HorizontalDatePicker> createState() => _HorizontalDatePickerState();
}

class _HorizontalDatePickerState extends State<HorizontalDatePicker> {
  late DateTime currentDate;

  List getDates() {
    dateList = [];
    DateTime now = DateTime.now();

    DateTime startDate = now.subtract(const Duration(days: 2));
    for (var i = 0; i < 6; i++) {
      DateTime date = startDate.add(Duration(days: i));
      dateList.add(date);
    }

    currentDate = dateList[2];
    return dateList;
  }

  List dateList = [];

  @override
  void initState() {
    getDates();
    super.initState();
  }

  updateSelectedDate(DateTime date) {
    currentDate = date;
    widget.onChanged(date);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: List.generate(
          dateList.length,
          (index) {
            var date = dateList[index];
            var isToday = index == 2;
            String day = DateFormat("dd").format(date);
            bool selected = DateFormat("d MMM y").format(currentDate) ==
                DateFormat("d MMM y").format(date);

            return Expanded(
              child: InkWell(
                onTap: () => updateSelectedDate(date),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12.0,
                    vertical: 8.0,
                  ),
                  decoration: BoxDecoration(
                    color: selected ? const Color(0xfff6f7f6) : null,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(12.0),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      isToday ? "Today" : day,
                      style: TextStyle(
                        color: selected ? Colors.blue : const Color(0xffbebebe),
                        fontWeight: FontWeight.bold,
                        fontSize: 12.0,
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
