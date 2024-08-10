import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePickerField extends StatelessWidget {
  final TextEditingController controller;

  DatePickerField({required this.controller});

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      String formattedDate = DateFormat('dd/MM/yyyy').format(pickedDate);
      controller.text = formattedDate;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _selectDate(context),
      child: AbsorbPointer(
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 1, horizontal: 20),
            suffixIcon: Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Icon(CupertinoIcons.calendar),
            ),
            hintStyle: TextStyle(
              fontSize: 14,
              color: Color(0xFFADA4A5),
              fontFamily: 'Poppins',
            ),
            filled: true,
            fillColor: Color(0xFFF7F8F8),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                color:  Color(0xFFF7F8F8),
              ),
            ),



          ),
        ),
      ),
    );
  }
}
