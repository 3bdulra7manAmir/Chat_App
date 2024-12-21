import 'package:chat_app_re/pages/blocs/auth_bloc/auth_bloc.dart';
import 'package:chat_app_re/pages/chat_cubit/chat_cubit.dart';
import 'package:chat_app_re/pages/chat_page.dart';
import 'package:chat_app_re/pages/login_cubit/login_cubit.dart';
import 'package:chat_app_re/pages/login_page.dart';
import 'package:chat_app_re/pages/register_cubit/register_cubit.dart';
import 'package:chat_app_re/pages/resgister_page.dart';
import 'package:chat_app_re/simple_bloc_observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'firebase_options.dart';

void main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);

  BlocOverrides.runZoned( ()
  {
    runApp(ScholarChat());
  },

  blocObserver: SimpleBlocObserver(),
  );

  //runApp(ScholarChat());
}

class ScholarChat extends StatelessWidget
{
  const ScholarChat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context)
  {
    return MultiBlocProvider(
      providers:
      [
        BlocProvider<LoginCubit>(create: (context) => LoginCubit(),),
        BlocProvider<RegisterCubit>(create: (context) => RegisterCubit(),),
        BlocProvider<ChatCubit>(create: (context) => ChatCubit(),),
        BlocProvider(create: (context) => AuthBloc(),),
      ],
      child: MaterialApp(
        routes: {
          LoginPage.id: (context) => LoginPage(),
          RegisterPage.id: (context) => RegisterPage(),
          ChatPage.id: (context) => ChatPage()
        },
        initialRoute: LoginPage.id,
      ),
    );
  }
}
