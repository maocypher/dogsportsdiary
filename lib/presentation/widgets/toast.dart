import 'package:dog_sports_diary/core/di/service_provider.dart';
import 'package:fluttertoast/fluttertoast.dart' as fluttertoast;

class Toast {
  void showToast({
    required String msg
  }) {
    fluttertoast.Fluttertoast.showToast(
        msg: msg,
        toastLength: fluttertoast.Toast.LENGTH_SHORT,
        gravity: fluttertoast.ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        fontSize: 16.0);
  }

  static inject() {
    ServiceProvider.locator.registerFactory<Toast>(() => Toast());
  }

  static Toast get toast {
    return ServiceProvider.locator<Toast>();
  }
}