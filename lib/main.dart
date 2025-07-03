import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:lembrebem/telas/tela_login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://gvkwpxllzerjbvlrdacv.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imd2a3dweGxsemVyamJ2bHJkYWN2Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTEwMzUyOTgsImV4cCI6MjA2NjYxMTI5OH0.phmMY-ToZZ8Mq965SBon7OCX7zASYxYQYUdZQyRp9HI',
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'LembreBem', home: TelaLogin());
  }
}
