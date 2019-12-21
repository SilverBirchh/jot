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
        title: Text(
          'Profile',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Color(0xffF5C5BE),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Color(0xff539D8B),
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 24, 0, 8),
              child: Row(
                children: <Widget>[
                  Container(
                    height: 125,
                    width: 125,
                    child: photoUrl != null
                        ? CachedNetworkImage(
                            imageUrl: photoUrl,
                            imageBuilder: (BuildContext context,
                                    ImageProvider imageProvider) =>
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
                            errorWidget: (BuildContext context, String url,
                                    Object error) =>
                                Icon(Icons.error),
                          )
                        : Container(
                            width: 300.0,
                            height: 300.0,
                            child: Center(
                              child: Text(
                                "A",
                                style: TextStyle(
                                  fontSize: 30,
                                  color: Color(0xff539D8B),
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                            decoration: new BoxDecoration(
                              color: Color(0xffF5C5BE),
                              shape: BoxShape.circle,
                            ),
                          ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 30),
                    child: Text(
                      name == null ? "Signed in anonymously" : name,
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
            Divider(
              indent: 16,
              endIndent: 16,
              color: Color(0xffF5C5BE),
            ),
            Container(
              height: 70,
              width: MediaQuery.of(context).size.width,
              child: FlatButton(
                padding: const EdgeInsets.all(16),
                onPressed: () {
                  Navigator.pushNamed(context, '/tags');
                },
                child: Row(
                  children: const <Widget>[
                    Text(
                      'Manage Tags',
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
              ),
            ),
            Divider(
              indent: 16,
              endIndent: 16,
              color: Color(0xffF5C5BE),
            ),
            Container(
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
            Divider(
              indent: 16,
              endIndent: 16,
              color: Color(0xffF5C5BE),
            ),
            Container(
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
            Divider(
              indent: 16,
              endIndent: 16,
              color: Color(0xffF5C5BE),
            ),
            Container(
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
            Divider(
              indent: 16,
              endIndent: 16,
              color: Color(0xffF5C5BE),
            ),
          ],
        ),
      ),
    );
  }
}
