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

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      username: json['username'],
      password: json['password'],
      firstName: json['names']['f_name'],
      lastName: json['names']['l_name'],
      surname: json['names']['surname'],
      nickName: json['names']['nick_name'],
      birthDate: json['birth_date'],
      address: json['address'],
      mobileNumber: json['mobile_number'],
      guardianMobileNumber: json['guardian_mobile_number'],
      email: json['email'],
      aboutMe: json['about_me'],
    );
  }

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
