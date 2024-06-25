class CustomException implements Exception {
  CustomException(this.error);

  final String error;

  @override
  String toString() {
    return error;
  }
}
