import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:task_list/app.dart';
import 'package:task_list/utils/http_overrides.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Handle the HandshakeException: CERTIFICATE_VERIFY_FAILED.
  HttpOverrides.global = MyHttpOverrides();

  // Load environment variables.
  await dotenv.load(fileName: 'assets/.env');

  // ignore: prefer_const_constructors
  runApp(TaskListApp());
}
