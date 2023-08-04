import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_parcel/pages/Authentication/login/index.dart';
import 'package:student_parcel/pages/Authentication/register/index.dart';
import 'package:student_parcel/pages/Home/index.dart';
import 'package:student_parcel/providers/student_provider.dart';

void main() async {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(studentProvider).initState();

    return MaterialApp(
      title: 'Kedai Siswa Uitm Dungun Student',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: ref.watch(studentProvider).token.isEmpty
          ? const Login()
          : const Home(),
      debugShowCheckedModeBanner: false,
      routes: {
        '/Login': (context) => const Login(),
        '/Register': (context) => const Register(),
        '/Home': (context) => const Home(),
      },
    );
  }
}
