import 'package:bloc/bloc.dart';
import 'package:chat_app_re/pages/register_cubit/register_state.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());


  Future<void> registerUser({required String email, required String password}) async
  {
    emit(RegisterLoadingState());
    try
    {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      emit(RegisterSuccessState());

    } on FirebaseAuthException catch (ex)
    {
      if (ex.code == 'weak-password')
      {
        emit(RegisterFailureState(errorMessage: 'Weak password'));
      }
      else if (ex.code == 'email-already-in-use')
      {
        emit(RegisterFailureState(errorMessage: 'Email already in use'));
      }
      else
      {
        emit(RegisterFailureState(errorMessage: ex.message));
      }
    }
    catch(ex)
    {
      emit(RegisterFailureState(errorMessage: ex.toString()));
    }
    

  }

    
}
