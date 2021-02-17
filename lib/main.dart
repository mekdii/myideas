import 'package:MyIdeas/ideas/data_provider/data_provider.dart';
import 'package:MyIdeas/ideas/screens/idea_rout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:http/http.dart' as http;

import 'bloc_observer.dart';
import 'ideas/bloc/bloc.dart';
import 'ideas/repository/repository.dart';

void main() {
  Bloc.observer = SimpleBlocObserver();

  final Idearepository idearepository = Idearepository(
    provider: IdeaDataProvider(),
  );

  runApp(
    CourseApp(idearepository: idearepository),
  );
}

class CourseApp extends StatelessWidget {
  final Idearepository idearepository;

  CourseApp({@required this.idearepository}) : assert(idearepository != null);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: this.idearepository,
      child: BlocProvider(
        create: (context) =>
            IdeaBloc(idearepository: idearepository)..add(IdeaLoad()),
        child: MaterialApp(
          title: 'Course App',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.deepOrange,
            accentColor: Colors.deepOrange,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          onGenerateRoute: CourseAppRoute.generateRoute,
        ),
      ),
    );
  }
}
