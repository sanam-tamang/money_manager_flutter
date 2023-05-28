part of 'currency_formatter_cubit.dart';

class CurrencyFormatterState extends Equatable {
  const CurrencyFormatterState({required this.formatCurrency  
 });
  final NumberFormat formatCurrency;
  @override
  List<Object> get props => [formatCurrency];
}
