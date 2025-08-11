import 'package:flutter_dotenv/flutter_dotenv.dart';

class UrlContainer {
  static String baseUrl = dotenv.get('BASE_URL');
  static const _mobileAppPath = '/api/mobile';

  static const String login = '$_mobileAppPath/login';
  static const String register = '$_mobileAppPath/register';
  static const String shoplist = '$_mobileAppPath/shops';
  static const String generatecode = '$_mobileAppPath/generate-code';
  static const String verifycode = '$_mobileAppPath/verify-code';
}
