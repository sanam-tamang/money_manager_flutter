double getPercentage(double amount, double totalAmount) {
  String result = ((amount / totalAmount) * 100).toStringAsFixed(2);
  return double.parse(result);
}
