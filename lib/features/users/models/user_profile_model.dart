class UserProfileModel {
  final String uid;
  final String email;
  final String name;
  final String bio;
  final String link;
  final DateTime birthday;

  UserProfileModel({
    required this.uid,
    required this.email,
    required this.name,
    required this.bio,
    required this.link,
    required this.birthday,
  });

  UserProfileModel.empty()
    : uid = "",
      email = "",
      name = "",
      bio = "",
      link = "",
      birthday = DateTime.now();

  UserProfileModel.fromJson(Map<String, dynamic> json)
    : uid = json["uid"],
      email = json["email"],
      name = json["name"],
      bio = json["bio"],
      link = json["link"],
      birthday = DateTime.parse(json["birthday"]);

  Map<String, String> toJson() {
    return {
      "uid": uid,
      "email": email,
      "name": name,
      "bio": bio,
      "link": link,
      "birthday": birthday.toIso8601String(),
    };
  }
}
