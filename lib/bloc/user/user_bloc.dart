import 'package:bengkelly_apps/model/user.dart';
import 'package:bengkelly_apps/providers/auth.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState>{
  UserBloc() : super(UserLoading());

  UserState get initialState => UserLoading();

  @override
  Stream<UserState> mapEventToState(UserEvent event) async* {
    if (event is UserFetch) {
      try {
        final dataUser = await auth.getProfile();
        yield UserLoaded(userData: dataUser);
      } catch (error) {
        debugPrint(error.toString());
        yield UserFailure(dataError: error.toString());
      }
    }
    if (event is UserRefresh) {
      try {
        yield UserLoading();
        final dataUser = await auth.getProfile();
        yield UserLoaded(userData: dataUser);
      } catch (error) {
        debugPrint(error.toString());
        yield UserFailure(dataError: error.toString());
      }
    }
  }
}