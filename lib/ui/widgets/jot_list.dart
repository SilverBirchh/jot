import 'package:Jot/bloc/application/bloc.dart';
import 'package:Jot/bloc/jot/bloc.dart';
import 'package:Jot/data/jot/jot_model.dart';
import 'package:Jot/ui/widgets/jot_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class JotList extends StatefulWidget {
  @override
  _JotListState createState() => _JotListState();
}

class _JotListState extends State<JotList> {
  JotBloc jotBloc;

  @override
  void initState() {
    super.initState();
    jotBloc = BlocProvider.of<JotBloc>(context);
    final String userId =
        BlocProvider.of<ApplicationBloc>(context).state.user.uid;
    jotBloc.add(
      StreamJots(userId),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<JotBloc, JotState>(
      builder: (BuildContext context, JotState jotState) {
        if (jotState is LoadingJots) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        if (jotState is ErrorJots) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Text(
                  'Could not load Jots.\nPlease try again.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
              IconButton(
                splashColor: Colors.grey,
                icon: Icon(
                  Icons.refresh,
                  color: Colors.white,
                ),
                onPressed: () {
                  final String userId =
                      BlocProvider.of<ApplicationBloc>(context).state.user.uid;
                  jotBloc.add(
                    StreamJots(userId),
                  );
                },
              )
            ],
          );
        }

        if (jotState is LoadedJots) {
          if (jotState.jots.isEmpty) {
            return Center(
              child: Text(
                'You have no Jots yet',
                style: TextStyle(color: Colors.white),
              ),
            );
          }
          return ListView.builder(
            itemCount: jotState.jots.length,
            itemBuilder: (BuildContext context, int index) {
              return JotContainer(
                jotState.jots[index],
                isFirst: index == 0,
                isLast: index == jotState.jots.length - 1,
              );
            },
          );
        }

        return Container(
          width: 0,
          height: 0,
        );
      },
    );
  }
}
