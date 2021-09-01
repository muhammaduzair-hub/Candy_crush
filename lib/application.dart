import 'package:flutter_application2/bloc/bloc_provider.dart';
import 'package:flutter_application2/bloc/game_bloc.dart';
import 'package:flutter_application2/mains.dart';
import 'package:flutter_application2/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

class Application extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<GameBloc>(
      bloc: GameBloc(),
      child: MaterialApp(
        title: 'Candy Crush',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.orange,
        ),
        home: SplashScreen(
          seconds: 3,
          navigateAfterSeconds: HomePagee(),
          backgroundColor: Colors.purple,
          image: Image.asset('assets/images/background/Logo.png'),
           photoSize: 150.0,
          loaderColor: Colors.blue,
        ),
      ),
    );
  }
}
