import 'package:flutter/cupertino.dart';

class  Utils{
  static void ChangeFieldFocus(
      BuildContext context, FocusNode Current, FocusNode NextNode) {
    Current.unfocus();
    FocusScope.of(context).requestFocus(NextNode);
  }
}