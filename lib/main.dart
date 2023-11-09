import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:rt_innovation/bloc/add_employee.dart';
import 'package:rt_innovation/bloc/cubit.dart';

import 'package:rt_innovation/screens/employee_list.dart';

late Box box;
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  box = await Hive.openBox("box");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => EmployeeData()),
        BlocProvider(create: (_) => AddRole()),
        BlocProvider(create: (_) => AddToday()),
        BlocProvider(create: (_) => NoToday()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: EmployeeList(),
      ),
    );
  }
}

