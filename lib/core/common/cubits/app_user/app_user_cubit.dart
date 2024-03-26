import 'package:blog_app/core/common/entities/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'app_user_state.dart';

//This cubit is used in main.dart file to display a login page or  a home page
class AppUserCubit extends Cubit<AppUserState> {
  AppUserCubit() : super(AppUserInitial());

  //We want to update the user whenever userSignUp,userLogin,currentUser is present or not
  //In all the above cases we want to send them to the home page
  void updateUser(User? user) {
    if (user == null) {
      emit(AppUserInitial());
    } else {
      emit(AppUserLoggedIn(user));
    }
  }
}
