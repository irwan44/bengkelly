part of 'user_bloc.dart';

abstract class UserState extends Equatable{
  const UserState();

  @override
  List<Object> get props => [];
}

class UserLoading extends UserState {}

class UserLoaded extends UserState {
  final UserData userData;

  const UserLoaded({
    required this.userData,
  });

  UserLoaded copyWith({UserData? userData}) {
    return UserLoaded(
      userData: userData ?? this.userData,
    );
  }

  @override
  List<Object> get props => [userData];

  @override
  String toString() => 'NewsLoaded { data: $userData}';
}

class UserFailure extends UserState {
  final String dataError;

  const UserFailure({
    required this.dataError,
  });

  @override
  List<Object> get props => [dataError];

  @override
  String toString() => 'Failure { items: $dataError }';
}