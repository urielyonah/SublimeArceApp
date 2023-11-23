class UserData {
  static final UserData _instance = UserData._internal();

  factory UserData() {
    return _instance;
  }

  UserData._internal();

  String userName = '';
  String userEmail = '';
  int userId = 0;
}
