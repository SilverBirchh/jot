import 'package:Jot/api/authenticate.dart';
import 'package:Jot/bloc/application/bloc.dart';
import 'package:Jot/bloc/authentication/bloc.dart';
import 'package:Jot/ui/widgets/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Landing extends StatelessWidget {
  final GlobalKey<ScaffoldState> _authenticationKey =
      GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    final AuthenticationBloc authenticationBloc = AuthenticationBloc(
      authentication: RepositoryProvider.of<AuthenticationBase>(context),
    );

    return Scaffold(
      key: _authenticationKey,
      body: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        bloc: authenticationBloc,
        builder:
            (BuildContext context, AuthenticationState authenticationState) {
          return BlocListener<AuthenticationBloc, AuthenticationState>(
            bloc: authenticationBloc,
            listener: (BuildContext context, AuthenticationState state) {
              if (state is AuthenticationError) {
                final SnackBar snackBar = SnackBar(
                  duration: Duration(seconds: 1),
                  content: const Text(
                      'Hmm there was a problem getting started. Please try again.'),
                );

                _authenticationKey.currentState.showSnackBar(snackBar);
              }

              if (state is Authenticating) {
                Scaffold.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(
                      content: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const <Widget>[
                          Text('Logging In...'),
                          CircularProgressIndicator(),
                        ],
                      ),
                    ),
                  );
              }

              if (state is Success) {
                BlocProvider.of<ApplicationBloc>(context)
                    .add(InitialiseUser(user: state.user));
              }
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Color(0xff539D8B),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                    decoration: null,
                    margin: const EdgeInsets.only(top: 50.0),
                    child: Text(
                      'Jot.',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 70,
                          fontWeight: FontWeight.bold,
                          decoration: null),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    margin:
                        const EdgeInsets.only(top: 50.0, right: 16, left: 16),
                    child: Text(
                      'Keep track of your accomplishments over time. So when you need them the most you can easily recall the amazing things you\'ve been up to!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 18, letterSpacing: 1, color: Colors.white),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(top: 50.0),
                    child: GoogleSignInButton(
                      onPressed: () {
                        authenticationBloc.add(SignIn());
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
