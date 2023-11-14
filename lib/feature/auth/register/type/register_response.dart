class RegisterResponse {
  final String token;

  const RegisterResponse({required this.token});

  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    return RegisterResponse(
      token: json['token'] as String,
    );
  }
}
