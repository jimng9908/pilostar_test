import 'package:rockstardata_apk/app/features/auth/auth.dart';

class RegisterResponseModel extends RegisterResponse {
  const RegisterResponseModel({
    required super.id,
    required super.firstName,
    required super.lastName,
    required super.email,
    super.phone,
    super.picture,
    super.isActive,
    super.verificationCode,
    super.verificationCodeExpires,
  });

  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) {
    return RegisterResponseModel(
      id: json["id"],
      firstName: json["firstName"],
      lastName: json["lastName"],
      email: json["email"],
      phone: json["phone"] ?? '',
      picture: json["picture"] ?? '',
      isActive: json["isActive"] ?? false,
      verificationCode: json["verificationCode"] ?? '',
      verificationCodeExpires: json["verificationCodeExpires"] != null
          ? DateTime.tryParse(json["verificationCodeExpires"].toString())
          : null,
    );
  }

  factory RegisterResponseModel.fromEntity(RegisterResponse entity) {
    return RegisterResponseModel(
        id: entity.id,
        firstName: entity.firstName,
        lastName: entity.lastName,
        email: entity.email,
        phone: entity.phone,
        picture: entity.picture,
        isActive: entity.isActive,
        verificationCode: entity.verificationCode,
        verificationCodeExpires: entity.verificationCodeExpires);
  }

  RegisterResponse toEntity() => RegisterResponse(
        id: id,
        firstName: firstName,
        lastName: lastName,
        email: email,
        phone: phone,
        picture: picture,
        isActive: isActive,
        verificationCode: verificationCode,
        verificationCodeExpires: verificationCodeExpires,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "phone": phone,
        "picture": picture,
        "isActive": isActive,
        "verificationCode": verificationCode,
        "verificationCodeExpires": verificationCodeExpires,
      };
}
