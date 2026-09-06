import 'package:flutter/material.dart';
import 'package:servicios_modelo_ui/theme.dart';
import 'package:servicios_modelo_ui/ui/User/user_view.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      title: 'Material App',
      home: const UserView(),
    );
  }
}

@Deprecated('Usa App en lugar de MyApp')
class MyApp extends App {
  const MyApp({super.key});
}
