import 'package:flutter_dotenv/flutter_dotenv.dart';

// import 'constants/config.dart';
import '/app/my_app.dart';

void main() async {
  // Config.appFlavor = Development();
  await dotenv.load(fileName: ".env");

  await initApp();
}
