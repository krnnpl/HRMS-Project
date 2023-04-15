import 'package:hrmsapp/constants/db_constants.dart';
import 'package:http/http.dart' as http;

class RemoteServices {
  static var client = http.Client();
  static var id = DbConstants.id;
}
