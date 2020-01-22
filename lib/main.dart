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
          create: (BuildContext context) => Authentication(),
        ),
        RepositoryProvider<ProfileApiBase>(
          create: (BuildContext context) => ProfileApi(),
        ),
        RepositoryProvider<JotApiBase>(
          create: (BuildContext context) => JotApi(),
        ),
      ],
      child: JotApp(),
    ),
  );
}

class JotApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: <BlocProvider<Bloc<dynamic, dynamic>>>[
        BlocProvider<ApplicationBloc>(
          create: (BuildContext context) => ApplicationBloc(
            authentication: RepositoryProvider.of<AuthenticationBase>(context),
          )..add(
              CheckIsAuthenticated(),
            ),
        ),
        BlocProvider<ProfileBloc>(
          create: (BuildContext context) => ProfileBloc(
            RepositoryProvider.of<ProfileApiBase>(context),
          ),
        ),
        BlocProvider<JotBloc>(
          create: (BuildContext context) => JotBloc(
            RepositoryProvider.of<JotApiBase>(context),
          ),
        ),
        BlocProvider<FilterBloc>(
          create: (BuildContext context) => FilterBloc(),
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
            return InstantRoute(
              builder: (_) => Home(),
            );
          } else if (settings.name == '/profile') {
            return InstantRoute(
              builder: (_) => Profile(),
            );
          } else if (settings.name == '/feedback') {
            return SlideLeftRoute(
              page: FeedbackPage(),
            );
          } else if (settings.name == '/create') {
            final Jot jot = settings.arguments;
            return SlideUpRoute(
              page: Create(
                jot: jot,
              ),
            );
          } else if (settings.name == '/tags') {
            return SlideLeftRoute(
              page: Tags(),
            );
          } else if (settings.name == '/plans') {
            return InstantRoute(
              builder: (_) => PlansPage(),
            );
          } else if (settings.name == '/metrics') {
            return InstantRoute(
              builder: (_) => MetricsPage(),
            );
          } else if (settings.name == '/create-plan') {
            return SlideUpRoute(
              page: CreatePlanPage(),
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
