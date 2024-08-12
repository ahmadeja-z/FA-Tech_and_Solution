import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Utils/utils.dart';
import '../Color.dart';

class customizedTextField extends StatefulWidget {
  const customizedTextField({
    super.key,
    this.readOnly = false,
    this.height,
    this.width,
    this.currentFocus,
    this.nextFocus,
    required this.controller,
    this.keyboardType,
    this.prefixIcon,
    this.suffixWidget,
    this.hintText,
    this.obscure = false,
    this.dropDownItems,
  });

  final double? height;
  final double? width;
  final FocusNode? currentFocus;
  final FocusNode? nextFocus;
  final TextEditingController controller;
  final bool obscure;
  final TextInputType? keyboardType;
  final Icon? prefixIcon;
  final Widget? suffixWidget;
  final String? hintText;
  final bool readOnly;
  final List<String>? dropDownItems;

  @override
  _CustomizedTextFieldState createState() => _CustomizedTextFieldState();
}

class _CustomizedTextFieldState extends State<customizedTextField> {
  bool _hasError = false;
  String? _errorMessage;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height ?? 45,
      width: widget.width ?? 320,
      child: TextField(
        readOnly: widget.readOnly,
        controller: widget.controller,
        focusNode: widget.currentFocus,
        obscureText: widget.obscure,
        keyboardType: widget.keyboardType,
        cursorColor: _hasError ? Colors.red : Color(0xFFADA4A5),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 1, horizontal: 15),
          suffixIcon: widget.dropDownItems != null
              ? DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              items: widget.dropDownItems!
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: TextStyle(
                        color: Colors.white, fontFamily: 'Lato'),
                  ),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  widget.controller.text = newValue!;
                });
              },
              alignment: Alignment.center,
              borderRadius: BorderRadius.circular(15),
              style: TextStyle(fontFamily: 'Orbitron', fontSize: 15),
              icon: Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Icon(
                  CupertinoIcons.chevron_down,
                  color: FColor.secondaryColor1,
                ),
              ),
              elevation: 6,
              dropdownColor: FColor.GreyBrown,
            ),
          )
              : widget.suffixWidget,
          prefixIcon: widget.prefixIcon,
          hintText: widget.hintText,
          errorText: _hasError ? _errorMessage : null,
          hintStyle: TextStyle(
            fontSize: 14,
            color: Color(0xFFADA4A5),
            fontFamily: 'Poppins',
          ),
          filled: true,
          fillColor: Color(0xFFF7F8F8),

          errorBorder:  OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(

              color:  Colors.red ,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: _hasError ? Colors.red : Color(0xFFADA4A5),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: _hasError ? Colors.red : Color(0xFFF7F8F8),
            ),
          ),
        ),
        onChanged: (val) {
          if (_hasError) {
            setState(() {
              _hasError = false;
              _errorMessage = null;
            });
          }else{

          }
        },
        onSubmitted: (val) {
          if (val.isNotEmpty) {
            Utils.ChangeFieldFocus(context, widget.currentFocus!, widget.nextFocus!);
          } else {
            setState(() {

              _errorMessage = "This field cannot be empty.";
            });
          }
        },
      ),
    );
  }
}
