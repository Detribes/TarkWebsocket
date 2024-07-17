import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:test_app/blocs/live_price_bloc.dart';
import 'package:test_app/repositories/repository.dart';
import 'package:test_app/screens/main_screen.dart';

class Bootstrap extends StatelessWidget{
  const Bootstrap({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return BlocProvider(
      create: (context) => LivePricesBloc(GetIt.instance.get<IRepository>()),
      child: MaterialApp(
        title: 'Tusk Socket',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MainScreen(),
      ),
    );
  }

}