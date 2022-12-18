import 'package:flutter/cupertino.dart';
import 'package:quickalert/quickalert.dart';

class MenssageHelper {

  static void successMenssage(String msg, BuildContext context, Function? onSuccess) {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.success,
      text: msg,
    ).then((value) => {
      if (onSuccess != null) {
        onSuccess()
      }
    });
  }

  static void errorMenssage(String msg, BuildContext context) {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.error,
      text: msg,
    );
  }
}