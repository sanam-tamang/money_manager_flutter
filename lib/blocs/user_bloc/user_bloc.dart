import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/user.dart';

part 'user_event.dart';
part 'user_state.dart';

///this [UserBloc] helps to add new user
class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    on<LoadUserEvent>(_onLoadUserEvent);
    on<AddUserEvent>(_onAddUserEvent);
    on<UpdateUserEvent>(_onUpdateUserEvent);
    on<DeleteUserEvent>(_onDeleteUserEvent);
  }

  void _onLoadUserEvent(LoadUserEvent event, Emitter<UserState> emit) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? username = sharedPreferences.getString('username');
    emit(UserLoadedState(user: User(name: username ?? '')));
  }

  void _onDeleteUserEvent(DeleteUserEvent event, Emitter<UserState> emit) async{
    final state = this.state;
    if (state is UserLoadedState) {

  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sharedPreferences.remove('username');
      emit(const UserLoadedState(user: User(name: '')));
    }
  }

  void _onAddUserEvent(AddUserEvent event, Emitter<UserState> emit) async {
    __addUserToDB(event.user, emit);
  }

  void _onUpdateUserEvent(
      UpdateUserEvent event, Emitter<UserState> emit) async {
    __addUserToDB(event.user, emit);
  }

  ///this function add user to the db
  void __addUserToDB(User user, Emitter<UserState> emit) async {
    final state = this.state;
    if (state is UserLoadedState) {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.setString('username', user.name);
      emit(UserLoadedState(user: user));
    }
  }
}
