part of 'frequency_cubit.dart';

class FrequencyState extends Equatable {
  const FrequencyState({this.selectedFrequency = Frequency.today});
  final Frequency selectedFrequency;
  @override
  List<Object> get props => [selectedFrequency];
}
