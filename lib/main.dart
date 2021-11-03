import 'package:flutter/material.dart';
import 'package:learn_app/configs/routes/app_routes.dart';
import 'package:learn_app/configs/routes/app_routes_constants.dart';
import 'package:learn_app/providers/data_provider.dart';
import 'package:learn_app/views/main_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const LearnApp());
}

class LearnApp extends StatelessWidget {
  const LearnApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DataProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'LearnApp',
        theme: ThemeData(
          primarySwatch: Colors.grey,
          primaryTextTheme: const TextTheme(
            headline6: TextStyle(
              color: Colors.white
            ),
          )
        ),
        onGenerateRoute: AppRoutes.routes,
        initialRoute: kMainScreen,
        home: const MainScreen(),
      ),
    );
  }
}