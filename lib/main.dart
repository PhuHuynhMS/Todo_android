import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'features/presentation/screens/home_screen.dart';
import 'features/domain/entities/task.dart';
import 'core/app_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Khởi tạo Hive
  await Hive.initFlutter();

  // Đăng ký adapters
  Hive.registerAdapter(TaskAdapter());
  Hive.registerAdapter(TaskPriorityAdapter());

  // Mở box trước khi chạy app
  await Hive.openBox<Task>('tasks');

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Tasks',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        textTheme: appTextTheme,
      ),
      home: const MyHomePage(title: 'Task Flow'),
      debugShowCheckedModeBanner: false,
    );
  }
}
