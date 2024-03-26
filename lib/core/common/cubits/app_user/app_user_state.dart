part of 'app_user_cubit.dart';

@immutable
sealed class AppUserState {}

final class AppUserInitial
    extends AppUserState {} // It is the state that shows that the user is logged out,it represents the logged out state

final class AppUserLoggedIn extends AppUserState {
  final User user;
  AppUserLoggedIn(this.user);
}
