class SendOtpResponse {
  final String accessToken;
  final String refreshToken;

  const SendOtpResponse(
      {required this.accessToken, required this.refreshToken});

  factory SendOtpResponse.fromJson(Map<String, dynamic> json) {
    return SendOtpResponse(
      accessToken: json['accessToken'] as String,
      refreshToken: json['refreshToken'] as String,
    );
  }
}
