extension StringExtension on String {
  bool isSuccess() {
    if (this == 'Successful') {
      return true;
    } else {
      return false;
    }
  }
}
