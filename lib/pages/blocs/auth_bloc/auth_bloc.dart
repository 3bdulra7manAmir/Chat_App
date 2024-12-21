import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthStates>
{
  AuthBloc() : super(AuthInitial())
  {
    on<AuthEvent>((event, emit) async
    {
      if (event is LoginEvent)
      {
        emit(LoginLoadingState());
        print("LoginLoadingState");
        try
        {
          await FirebaseAuth.instance.signInWithEmailAndPassword(email: event.email, password: event.password);
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
    });
  }
}
