import 'package:flutter_dotenv/flutter_dotenv.dart';

class UrlContainer {
  static String baseUrl = dotenv.get('BASE_URL');
  static const _mobileAppPath = '/api';

  static const String login = '$_mobileAppPath/auth/login';
  static const String addticket = '$_mobileAppPath/ticket/add';
}
