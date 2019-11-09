import 'package:Jot/api/authenticate.dart';
import 'package:Jot/bloc/application/bloc.dart';
import 'package:Jot/ui/screens/home.dart';
import 'package:Jot/ui/screens/splash.dart';
import 'package:Jot/ui/widgets/slide.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';

import 'ui/screens/landing.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Set up Firebase
  final FirebaseApp app = await FirebaseApp.configure(
    name: 'soar-education',
    options: const FirebaseOptions(
      googleAppID: '1:136915368866:android:da2b38974d46245023d0fb',
      apiKey: 'AIzaSyCARYZZjzMggJivgV2fKiJjV0gW1Kt_Zeg',
      databaseURL: 'https://soar-jot.firebaseio.com',
      projectID: 'soar-jot',
    ),
  );

  final Firestore firestore = Firestore(app: app);
  await firestore.settings(timestampsInSnapshotsEnabled: true);
  // End setting up Firebase

  runApp(
    MultiRepositoryProvider(
      providers: <RepositoryProvider<dynamic>>[
        RepositoryProvider<AuthenticationBase>(
          builder: (BuildContext context) => Authentication(),
        ),
      ],
      child: Jot(),
    ),
  );
}

class Jot extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: <BlocProvider<Bloc<dynamic, dynamic>>>[
        BlocProvider<ApplicationBloc>(
          builder: (BuildContext context) => ApplicationBloc(
            authentication: RepositoryProvider.of<AuthenticationBase>(context),
          )..add(
              CheckIsAuthenticated(),
            ),
        ),
      ],
      child: MaterialApp(
        title: 'Jot',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        onGenerateRoute: (settings) {
          if (settings.name == "/home") {
            return SlideLeftRoute(page: Home());
          } else if (settings.name == '/') {
            return SlideUpRoute(page: Landing());
          }
          // unknown route
          return MaterialPageRoute(builder: (context) => Container());
        },
        home: BlocListener<ApplicationBloc, ApplicationState>(
          listener: (BuildContext context, ApplicationState state) {
            if (state is Initialized) {
              Navigator.pushNamedAndRemoveUntil(
                  context, '/home', (Route<dynamic> route) => false);
            }
          },
          child: BlocBuilder<ApplicationBloc, ApplicationState>(
            builder: (BuildContext context, ApplicationState applicationState) {
              return (applicationState is Loading ||
                      applicationState is Initialized)
                  ? Splash(
                      showLoading: true,
                    )
                  : Landing();
            },
          ),
        ),
      ),
    );
  }
}
