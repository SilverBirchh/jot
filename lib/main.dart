import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import 'ui/screens/landing.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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

  runApp(
    Jot(),
  );
}

class Jot extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jot',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Landing(),
    );
  }
}
