import 'package:bloc/bloc.dart';
import 'package:chat_app_re/helper/show_snack_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginStates>
{
  LoginCubit() : super(LoginInitialState());

  Future<void> login({required String email, required String password}) async
  {
    emit(LoginLoadingState());
    print("LoginLoadingState");
    try
    {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      // if( email == "141" && password == "141")
      // {
      //   emit(LoginSuccessState());
      //   print("LoginSuccessState");
      // }
      emit(LoginSuccessState());
    }
    on FirebaseAuthException catch (ex)
    {
      if (ex.code == 'user-not-found')
      {
        emit(LoginFailureState(errorMessage: 'User not found'));
      }
      else if (ex.code == 'wrong-password')
      {
        emit(LoginFailureState(errorMessage: 'Wrong password'));
      }
      else
      {
        emit(LoginFailureState(errorMessage: ex.message));
      }
    }
    catch(ex)
    {
      emit(LoginFailureState(errorMessage: ex.toString()));
      print("LoginFailureState");
    }
  }
}
