import 'package:bloc/bloc.dart';
import 'package:chat_app_re/pages/register_cubit/register_state.dart';

class RegisterCubit extends Cubit<RegisterStates>
{
  RegisterCubit() : super(RegisterInitialState());

  void registerUser()
  {
    try
    {
      //await registerUser();

      Navigator.pushNamed(context, ChatPage.id);
    } on FirebaseAuthException catch (ex)
    {
      if (ex.code == 'weak-password')
      {
        showSnackBar(context, 'weak password');
      } else if (ex.code == 'email-already-in-use')
      {
        showSnackBar(context, 'email already exists');
      }
    } catch (ex)
    {
      showSnackBar(context, 'there was an error');
    }
  }
}
