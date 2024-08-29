import 'package:fluttertoast/fluttertoast.dart';

toastinfo(String msg) {
  return Fluttertoast.showToast(
    msg:msg,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.CENTER,
    

  );
}
