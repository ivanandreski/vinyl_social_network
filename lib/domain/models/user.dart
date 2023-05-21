import 'package:vinyl_social_network/domain/enum/user_profile_visibility_enum.dart';

class User {
  late final int id;
  late String firstName;
  late String lastName;
  late String email;
  late DateTime createdAt;
  late String visibility;

  User(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.email,
      required this.createdAt,
      required this.visibility});


  User.fromResponse(Map<String, dynamic> userResponse) {
    id = userResponse['id'];
    email = userResponse['email'];
    firstName = userResponse['first_name'];
    lastName = userResponse['last_name'];
    createdAt = DateTime.parse(userResponse['created_at']);
    visibility = userResponse['visibility'];
  }

  String get fullName => "$firstName $lastName";
}
