import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../enum/frequency_enum.dart';

part 'frequency_state.dart';

///This [FrequencyCubit] shows which frequency is selected
///that means which time period is selected 
class FrequencyCubit extends Cubit<FrequencyState> {
  FrequencyCubit() : super(const FrequencyState());

  void changeFrequency(Frequency selectedFrequency) {
    emit(FrequencyState(selectedFrequency: selectedFrequency));
  }
}
