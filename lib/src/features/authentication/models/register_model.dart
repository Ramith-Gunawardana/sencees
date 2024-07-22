class UserModel {
  final String username;
  final String password;
  final String firstName;
  final String lastName;
  final String? surname;
  final String? nickName;

  UserModel({
    required this.username,
    required this.password,
    required this.firstName,
    required this.lastName,
    this.surname,
    this.nickName,
  });

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
      'names': {
        'f_name': firstName,
        'l_name': lastName,
        'surname': surname,
        'nick_name': nickName,
      },
    };
  }
}
