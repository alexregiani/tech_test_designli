class CustomException implements Exception {
  CustomException({required this.error});

  final String error;

  @override
  String toString() {
    return 'CustomException{error: $error}';
  }
}
