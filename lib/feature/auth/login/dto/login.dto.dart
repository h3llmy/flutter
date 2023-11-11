class LoginDto {
  final String accessToken;
  final String refreshToken;

  const LoginDto({required this.accessToken, required this.refreshToken});

  factory LoginDto.fromJson(Map<String, dynamic> json) {
    return LoginDto(
      accessToken: json['accessToken'] as String,
      refreshToken: json['refreshToken'] as String,
    );
  }
}
