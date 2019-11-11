import 'package:Jot/bloc/application/application_bloc.dart';
import 'package:Jot/bloc/application/application_event.dart';
import 'package:Jot/bloc/profile/bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Profile extends StatelessWidget {
  Future<void> _logout(BuildContext context) async {
    BlocProvider.of<ProfileBloc>(context).add(LogOut());
    BlocProvider.of<ApplicationBloc>(context).add(UninitialiseUser());
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/', ModalRoute.withName('/landing'));
  }

  Future<void> _deleteUser(BuildContext context) async {
    final String userId =
        BlocProvider.of<ApplicationBloc>(context).state.user.uid;
    BlocProvider.of<ProfileBloc>(context).add(DeleteAccount(userId));
    BlocProvider.of<ApplicationBloc>(context).add(UninitialiseUser());

    Navigator.of(context)
        .pushNamedAndRemoveUntil('/', ModalRoute.withName('/landing'));
  }

  final GlobalKey<ScaffoldState> _profileKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final String photoUrl =
        BlocProvider.of<ApplicationBloc>(context).state.user.photoUrl;
    final String name =
        BlocProvider.of<ApplicationBloc>(context).state.user.username;

    return Scaffold(
      key: _profileKey,
      appBar: AppBar(
        title: Text('Profile'),
        centerTitle: true,
        backgroundColor: Color(0xff2ebf91),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: <Color>[Color(0xff2ebf91), Color(0xff8360c3)],
              begin: FractionalOffset.topCenter,
              end: FractionalOffset.bottomCenter,
              stops: <double>[0.0, 1.0],
              tileMode: TileMode.clamp),
        ),
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 0, 50),
              child: Row(
                children: <Widget>[
                  Container(
                    height: 125,
                    width: 125,
                    child: CachedNetworkImage(
                      imageUrl: photoUrl,
                      imageBuilder:
                          (BuildContext context, ImageProvider imageProvider) =>
                              Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      placeholder: (BuildContext context, String url) =>
                          const CircularProgressIndicator(),
                      errorWidget:
                          (BuildContext context, String url, Object error) =>
                              Icon(Icons.error),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 30),
                    child: Text(
                      name,
                      style: const TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                        letterSpacing: .5,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: Colors.white12),
                ),
              ),
              margin: EdgeInsets.only(top: 16),
              height: 70,
              width: MediaQuery.of(context).size.width,
              child: FlatButton(
                padding: const EdgeInsets.all(16),
                onPressed: () {
                  Navigator.pushNamed(context, '/feedback');
                },
                child: Row(
                  children: const <Widget>[
                    Text(
                      'Send Feedback',
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: Colors.white12),
                ),
              ),
              height: 70,
              width: MediaQuery.of(context).size.width,
              child: FlatButton(
                padding: const EdgeInsets.all(16),
                onPressed: () => _logout(context),
                child: Row(
                  children: const <Widget>[
                    Text(
                      'Log Out',
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: Colors.white12),
                  bottom: BorderSide(color: Colors.white12),
                ),
              ),
              height: 70,
              width: MediaQuery.of(context).size.width,
              child: FlatButton(
                padding: const EdgeInsets.all(16),
                onPressed: () => _deleteUser(context),
                child: Row(
                  children: const <Widget>[
                    Text(
                      'Delete Account',
                      style: TextStyle(fontSize: 15, color: Colors.amber),
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
