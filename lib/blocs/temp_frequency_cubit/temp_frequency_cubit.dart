
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../enum/frequency_enum.dart';

part 'temp_frequency_state.dart';
///this cubit holds the last frequency from [FrequencyCubit]
///the only purpose of this cubit is to hold the last frequenct from 
///[FrequencyCubit] and basically what it does that it hold frequency which
///changes from [ShowTransactionPage] and later if go to [StatPage] basically
///[FrequencyCubit] maybe changes there so later to keep the same state over
///[ShowTransactionPage] this Temporary data is needed
class TempFrequencyCubit extends Cubit<TempFrequencyState> {
  TempFrequencyCubit()
      : super(const TempFrequencyState(frequency: Frequency.today));

  void setLastTransactionPageFrequency(Frequency frequency) {
    emit(TempFrequencyState(frequency: frequency));
  }
}
