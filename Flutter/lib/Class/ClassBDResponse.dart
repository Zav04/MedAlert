class CreateDBResponse {
  final bool success;
  final dynamic data;
  final String? errorMessage;

  CreateDBResponse({
    required this.success,
    this.data,
    this.errorMessage,
  });
}
