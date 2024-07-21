import 'package:fluttertoast/fluttertoast.dart' as fluttertoast;

class Toast {
  static void showToast({
    required String msg
  }) {
    fluttertoast.Fluttertoast.showToast(
        msg: msg,
        toastLength: fluttertoast.Toast.LENGTH_SHORT,
        gravity: fluttertoast.ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        fontSize: 16.0);
  }
}