import 'package:dooit/providers/auth_provider.dart';
import 'package:dooit/providers/task_provider.dart';
import 'package:dooit/routes/app_routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(DooltApp());
}

class DooltApp extends StatelessWidget {
  const DooltApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => TaskProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Doolt',
        initialRoute: '/',
        routes: appRoutes,
      ),
    );
  }
}
