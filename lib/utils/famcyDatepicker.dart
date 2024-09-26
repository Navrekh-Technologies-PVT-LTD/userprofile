import 'package:flutter/material.dart';

class FancyDateInput extends StatefulWidget {
  final Function(DateTime)? onDateSelected;

  const FancyDateInput({Key? key, this.onDateSelected}) : super(key: key);

  @override
  _FancyDateInputState createState() => _FancyDateInputState();
}

class _FancyDateInputState extends State<FancyDateInput> {
  DateTime? _selectedDate;

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')} / ${date.month.toString().padLeft(2, '0')} / ${date.year}';
  }

  void _showDatePicker() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1950),
        lastDate: DateTime(2100),

      // onConfirm: (date) {
      //   setState(() {
      //     _selectedDate = date;
      //     widget.onDateSelected?.call(date); // Call the callback with selected date
      //   });
      // },
      // currentTime: DateTime.now(),
    );

    setState(() {
      _selectedDate=pickedDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showDatePicker();
      },
      child: Container(
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.black,
            width: 0.5,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _selectedDate != null
                  ? _formatDate(_selectedDate!)
                  : 'DD / MM / YYYY',
              style: TextStyle(
                fontSize: 18.0,
                color: _selectedDate != null ? Colors.grey : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
