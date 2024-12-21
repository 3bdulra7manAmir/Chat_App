import 'package:chat_app_re/constants.dart';
import 'package:chat_app_re/helper/show_snack_bar.dart';
import 'package:chat_app_re/pages/chat_page.dart';
import 'package:chat_app_re/pages/register_cubit/register_cubit.dart';
import 'package:chat_app_re/pages/register_cubit/register_state.dart';
import 'package:chat_app_re/widgets/custom_button.dart';
import 'package:chat_app_re/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';



class RegisterPage extends StatelessWidget
{
  RegisterPage({super.key});
  
  String? email, password;
  bool isLoading = false;
  static String id = 'RegisterPage';
  
  GlobalKey<FormState> formKey = GlobalKey();


  @override
  Widget build(BuildContext context)
  {
    return BlocConsumer<RegisterCubit, RegisterStates>(
      listener: (context, state)
      {
        if (state is RegisterLoadingState)
        {
          isLoading = true;
        }
        else if (state is RegisterSuccessState)
        {
          Navigator.pushNamed(context, ChatPage.id);
          isLoading = false;
        }
        else if (state is RegisterFailureState)
        {
          showSnackBar(context, state.errorMessage!);
          isLoading = false;
        }
      },
      builder: (context, state) => ModalProgressHUD(
        inAsyncCall: isLoading,
        child: Scaffold(
          backgroundColor: kPrimaryColor,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Form(
              key: formKey,
              child: ListView(
                children: [
                  const SizedBox(height: 75,),
                  Image.asset('assets/images/scholar.png', height: 100,),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Scholar Chat', style: TextStyle(fontSize: 32, color: Colors.white, fontFamily: 'pacifico',),
                      ),
                    ],
                  ),
                  const SizedBox(height: 75,),
                  const Row(
                    children: [
                      Text('REGISTER', style: TextStyle( fontSize: 24, color: Colors.white,),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20,),
                  CustomFormTextField(
                    onChanged: (data)
                    {
                      email = data;
                    },
                    hintText: 'Email',
                  ),
                  const SizedBox(height: 10,),
                  CustomFormTextField(
                    onChanged: (data)
                    {
                      password = data;
                    },
                    hintText: 'Password',
                  ),
                  const SizedBox(height: 20,),
                  CustomButon(
                    onTap: () async
                    {
                      if (formKey.currentState!.validate())
                      {
                        BlocProvider.of<RegisterCubit>(context).registerUser(email: email!, password: password!);
                      }
                      else
                      {
                        
                      }
                    },
                    text: 'REGISTER',
                  ),
                  const SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('already have an account?', style: TextStyle(color: Colors.white,),
                      ),
                      GestureDetector(
                        onTap: ()
                        {
                          Navigator.pop(context);
                        },
                        child: const Text('Login', style: TextStyle( color: Color(0xffC7EDE6),),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

}
