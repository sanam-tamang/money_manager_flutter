import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../enum/category_type.dart';

class TransactionCategory extends Equatable {
  final String id;
  final String name;
  final TransactionType type;
  const TransactionCategory(
      {required this.id, required this.name, required this.type});

  @override
  List<Object> get props => [id, name, type];

  TransactionCategory copyWith({
    String? name,
    TransactionType? type,
  }) {
    return TransactionCategory(
      id: id,
      name: name ?? this.name,
      type: type ?? this.type,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'category_id': id,
      'name': name,
      'type': encodeTransactionType(type),
    };
  }

  factory TransactionCategory.fromMap(Map<String, dynamic> map) {
    return TransactionCategory(
        id: map['category_id'] as String,
        name: map['name'] as String,
        type: decodeTransactionType(map['type']));
  }

  String toJson() => json.encode(toMap());

  factory TransactionCategory.fromJson(String source) =>
      TransactionCategory.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;
}
