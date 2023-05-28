
part of 'temp_frequency_cubit.dart';

class TempFrequencyState extends Equatable {
  const TempFrequencyState(
    {required this.frequency}
  );
  final Frequency frequency;
  @override
  List<Object> get props => [frequency];
}
