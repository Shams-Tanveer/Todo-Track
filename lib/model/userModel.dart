class UserFields{
  static const String id= "id";
  static const String email= "email";
}
class User{
  String? id;
  String email;
  
  
  User({
    this.id,
    required this.email
  });

  Map<String, dynamic> toJson()=>{
    UserFields.id: id,
    UserFields.email: email
  };

  static User fromJson(Map<String, Object?> json) => User(
    id: json[UserFields.id] as String,
    email: json[UserFields.email] as String
  );
}