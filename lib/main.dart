import 'package:Jot/ui/screens/create.dart';
import 'package:Jot/ui/screens/feedback_page.dart';

import './main_exports.dart';

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
        RepositoryProvider<ProfileApiBase>(
          builder: (BuildContext context) => ProfileApi(),
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
        BlocProvider<ProfileBloc>(
          builder: (BuildContext context) => ProfileBloc(
            RepositoryProvider.of<ProfileApiBase>(context),
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
            return SlideLeftRoute(
              page: Home(),
            );
          } else if (settings.name == '/profile') {
            return SlideLeftRoute(
              page: Profile(),
            );
          } else if (settings.name == '/feedback') {
            return SlideLeftRoute(
              page: FeedbackPage(),
            );
          } else if (settings.name == '/create') {
            return SlideLeftRoute(
              page: Create(),
            );
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
