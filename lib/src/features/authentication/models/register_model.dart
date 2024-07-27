class UserModel {
  final String username;
  final String password;
  final String firstName;
  final String lastName;
  final String? surname;
  final String? nickName;
  final String birthDate;
  final String address;
  final String mobileNumber;
  final String? guardianMobileNumber;
  final String? email;
  final String aboutMe;

  UserModel({
    required this.username,
    required this.password,
    required this.firstName,
    required this.lastName,
    this.surname,
    this.nickName,
    required this.birthDate,
    required this.address,
    required this.mobileNumber,
    this.guardianMobileNumber,
    this.email,
    required this.aboutMe,
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
      'birth_date': birthDate,
      'address': address,
      'mobile_number': mobileNumber,
      'guardian_mobile_number': guardianMobileNumber,
      'email': email,
      'about_me': aboutMe
    };
  }
}
