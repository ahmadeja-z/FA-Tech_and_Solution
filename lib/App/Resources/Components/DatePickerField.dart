import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePickerField extends StatelessWidget {
  final TextEditingController controller;

  DatePickerField({super.key, required this.controller});

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null && pickedDate != DateTime.now()) {
      String formattedDate = DateFormat('dd/MM/yyyy').format(pickedDate);
      // Update the text field with the formatted date
      controller.text = formattedDate;
      // Optionally, you can set the cursor position to the end of the text
      controller.selection = TextSelection.fromPosition(TextPosition(offset: controller.text.length));
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _selectDate(context),
      child: AbsorbPointer(
        child: TextField(
          readOnly: true,
          controller: controller,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(vertical: 1, horizontal: 20),
            suffixIcon: const Padding(
              padding: EdgeInsets.only(right: 20),
              child: Icon(CupertinoIcons.calendar),
            ),
            hintText: 'Select date',
            hintStyle: const TextStyle(
              fontSize: 14,
              color: Color(0xFFADA4A5),
              fontFamily: 'Poppins',
            ),
            filled: true,
            fillColor: const Color(0xFFF7F8F8),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(
                color: Color(0xFFF7F8F8),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(
                color: Colors.blue,
                width: 1.5,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
