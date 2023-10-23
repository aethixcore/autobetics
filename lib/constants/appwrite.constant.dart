class User {
  String id;
  DateTime createdAt;
  DateTime updatedAt;
  String name;
  String password;
  String hash;
  Map<String, dynamic> hashOptions;
  DateTime registration;
  bool status;
  String labels;
  DateTime passwordUpdate;
  String email;
  String phone;
  bool emailVerification;
  bool phoneVerification;
  UserPrefs prefs;
  DateTime accessedAt;

  User({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.name,
    required this.password,
    required this.hash,
    required this.hashOptions,
    required this.registration,
    required this.status,
    required this.labels,
    required this.passwordUpdate,
    required this.email,
    required this.phone,
    required this.emailVerification,
    required this.phoneVerification,
    required this.prefs,
    required this.accessedAt,
  });
}

class UserPrefs {
  String theme;
  String timezone;

  UserPrefs({required this.theme,   required this.timezone});
}
