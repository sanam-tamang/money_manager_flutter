import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

part 'currency_formatter_state.dart';

class CurrencyFormatterCubit extends Cubit<CurrencyFormatterState> {
  CurrencyFormatterCubit()
      : super(CurrencyFormatterState(
            formatCurrency:
                NumberFormat.currency(locale: "en_US", symbol: "\$")));
  void currencyFormat({String locale = "en_US", String symbol = "\$"}) {
    final currentcyFormattor =
        NumberFormat.currency(locale: locale, symbol: symbol,);

    emit(CurrencyFormatterState(formatCurrency: currentcyFormattor));
  }
}
