import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotelsgo/business_logi/cubit/app_cubit.dart';
import 'package:hotelsgo/screens/home_screen.dart';

void main() {
  runApp(const HotelsGo());
}

class HotelsGo extends StatelessWidget {
  const HotelsGo({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (context) => AppCubit())],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'hotelsGO',
        home: HomeScreen(),
      ),
    );
  }
}
