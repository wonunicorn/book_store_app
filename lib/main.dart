import 'package:book_app/core/utils/enums.dart';
import 'package:book_app/feature/presentation/bloc/bloc.dart';
import 'package:book_app/feature/presentation/screens/screens.dart';
import 'package:book_app/service_locator.dart' as sl;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  sl.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl.serviceLocator<BooksBloc>()),
        BlocProvider(create: (_) => sl.serviceLocator<AuthBloc>(),),
      ],
      child: MaterialApp(
        title: 'Book App',
        debugShowCheckedModeBanner: false,
        home: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state){
            state.whenOrNull(
              status: (status){
                if(status == AuthStatus.authenticated){
                  return const HomeScreen();
                }
                else{
                  return const LoginScreen();
                }
              },
            );
          },
            builder: (context, state){
              return state.when(
                status: (status){
                  if(status == AuthStatus.authenticated){
                    return const HomeScreen();
                  }
                  else{
                    return const LoginScreen();
                  }
                },
                loading: () => const Center(child: CircularProgressIndicator(),),
                error: (String? error) => Center(child: Text(error.toString()),),
              );
            },
        ),
      ),
    );
  }
}

