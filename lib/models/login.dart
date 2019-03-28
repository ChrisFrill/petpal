class LoginModel {
  final String token;

  LoginModel(this.token);

  LoginModel.fromJson(Map<String, dynamic> json) : token = json['token'];

  Map<String, dynamic> toJson() => {
        'token': token,
      };
}
