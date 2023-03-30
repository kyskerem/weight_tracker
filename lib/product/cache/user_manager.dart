import '../../core/model/user_model.dart';
import '../constants/hive_constants.dart';
import 'local_manager.dart';

class UserManager extends ILocalManager<User> {
  factory UserManager.getInstance() {
    return UserManager._init();
  }
  UserManager._init() : super(title: HiveConstants.userBoxName);

  static User? _user;
  User? get user {
    return _user ??= getItem(0);
  }
}
