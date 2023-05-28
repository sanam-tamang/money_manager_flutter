// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'filtered_transaction_bloc.dart';

abstract class FilteredTransactionEvent extends Equatable {
  const FilteredTransactionEvent();

  @override
  List<Object> get props => [];
}

class GetFilteredFrequencyTransaction extends FilteredTransactionEvent {
  final Frequency type;
  final DateTime dateTime;
  const GetFilteredFrequencyTransaction({
    this.type = Frequency.today,
     required this.dateTime,
  });

  @override
  List<Object> get props => [type,dateTime];
}
