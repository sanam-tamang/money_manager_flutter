enum TransactionType {
  expense,
  income,
}

TransactionType decodeTransactionType(String transactionType) {
  return TransactionType.values
      .firstWhere((v) => v.toString() == transactionType);
}

String encodeTransactionType(TransactionType transactionType) {
  return transactionType.toString();
}
