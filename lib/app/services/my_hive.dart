import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import '/app/models/user_model.dart';

class MyHive {
  // prevent making instance
  MyHive._();

  // hive box to store user data
  // box name its like table name
  static const String userBoxName = 'user';
  static const String currentUserKey = 'my_profile';

  static final userBox = Hive.box<UserModel>(name: userBoxName);

  /// initialize local db (HIVE)
  /// pass testPath only if you are testing hive
  static init() async {
    final directory = await getApplicationDocumentsDirectory();
    Hive.defaultDirectory = directory.path;
    Hive.registerAdapter(userBoxName, (json) => UserModel.fromJson(json));
  }
}
