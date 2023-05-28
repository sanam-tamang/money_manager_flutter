// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'transaction_category.dart';

class Transaction extends Equatable {
  final String id;
  final TransactionCategory category;
  final double transactionAmount;
  final String dateTime;
  const Transaction({
    required this.id,
    required this.category,
    required this.transactionAmount,
    required this.dateTime,
  });

  @override
  List<Object> get props => [id, category, dateTime];

  Transaction copyWith({
    TransactionCategory? category,
    String? dateTime,
    double? transactionAmount,
  }) {
    return Transaction(
      id: id,
      category: category ?? this.category,
      dateTime: dateTime ?? this.dateTime,
      transactionAmount: transactionAmount ?? this.transactionAmount,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'category': category.toMap(),
      'dateTime': dateTime,
      'transaction_amount': transactionAmount,
    };
  }

  factory Transaction.fromMap(Map<String, dynamic> map) {
    return Transaction(
      id: map['id'] as String,
      category:
          TransactionCategory.fromMap(map['category'] as Map<String, dynamic>),
      dateTime: map['dateTime'],
      transactionAmount: map['transaction_amount'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory Transaction.fromJson(String source) =>
      Transaction.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;
}
