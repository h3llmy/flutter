class ResendOtpResponse {
  final String token;

  const ResendOtpResponse({required this.token});

  factory ResendOtpResponse.fromJson(Map<String, dynamic> json) {
    return ResendOtpResponse(
      token: json['token'] as String,
    );
  }
}
