import 'package:firebase/cubit/cubit/auth_cubit.dart';
import 'package:firebase/data/repo.dart';
import 'package:firebase/firebase_options.dart';
import 'package:firebase/screens/auth_screen.dart';
import 'package:firebase/screens/home_screen.dart';
import 'package:firebase/screens/register_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      home: /* AuthRepo.currentUser != null
          ? HomeScreen()
          :*/ BlocProvider(
        create: (context) => AuthCubit(),
        child: RegisterScreen(),
      ),
    );
  }
}
