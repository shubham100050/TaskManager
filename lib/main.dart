
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/routes/app_router.dart';
import 'package:todo/bloc_state_observer.dart';
import 'package:todo/routes/pages.dart';
import 'package:todo/tasks/data/local/data_sources/tasks_data_provider.dart';
import 'package:todo/tasks/data/repository/task_repository.dart';
import 'package:todo/tasks/presentation/bloc/tasks_bloc.dart';
import 'package:todo/utils/color_palette.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = BlocStateOberver();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  runApp( MyApp(
    preferences: preferences,),
  );

}

class MyApp extends StatelessWidget {
  final SharedPreferences preferences;

  const MyApp({super.key, required this.preferences,});

  @override
  Widget build(BuildContext context) {
        return RepositoryProvider(
            create: (context) =>
                TaskRepository(taskDataProvider: TaskDataProvider(preferences)),
            child: BlocProvider(
                create: (context) => TasksBloc(context.read<TaskRepository>()),
                child: MaterialApp(
                  title: 'ToDo',
                  debugShowCheckedModeBanner: false,
                  initialRoute: Pages.initial,
                  onGenerateRoute: onGenerateRoute,
                  theme: ThemeData(
                    fontFamily: 'Sora',
                    visualDensity: VisualDensity.adaptivePlatformDensity,
                    canvasColor: Colors.transparent,
                    colorScheme: ColorScheme.fromSeed(seedColor: kRed),
                    useMaterial3: true,
                  ),
                ),
            ),
        );
      }

  }

