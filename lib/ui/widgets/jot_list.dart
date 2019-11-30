import 'package:Jot/bloc/application/bloc.dart';
import 'package:Jot/bloc/filter/bloc.dart';
import 'package:Jot/bloc/filter/filter_bloc.dart';
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
  bool onlyImportant;

  @override
  void initState() {
    super.initState();
    onlyImportant = BlocProvider.of<FilterBloc>(context).state.inportantOnly;
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
                'You have no entries yet...',
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
            );
          }
          return BlocBuilder<FilterBloc, FilterState>(
            builder: (BuildContext context, FilterState filterState) {
              List<Jot> allJots = List.from(jotState.jots);
              if (filterState.inportantOnly ||
                  filterState.tagsToApply.isNotEmpty) {
                allJots.retainWhere((Jot jot) {
                  if (filterState.tagsToApply.isNotEmpty &&
                      filterState.inportantOnly) {
                    bool shouldRetain = false;
                    for (String tag in jot.tags) {
                      if (filterState.tagsToApply.contains(tag)) {
                        shouldRetain = true;
                        break;
                      }
                    }
                    return jot.isImportant && shouldRetain;
                  }
                  if (filterState.tagsToApply.isEmpty &&
                      filterState.inportantOnly) {
                    return jot.isImportant;
                  }

                  if (filterState.tagsToApply.isNotEmpty &&
                      !filterState.inportantOnly) {
                    bool shouldRetain = false;
                    for (String tag in jot.tags) {
                      if (filterState.tagsToApply.contains(tag)) {
                        shouldRetain = true;
                        break;
                      }
                    }
                    return shouldRetain;
                  }
                  return true;
                });
              }
              return ListView.builder(
                itemCount: allJots.length,
                itemBuilder: (BuildContext context, int index) {
                  return JotContainer(
                    allJots[index],
                    isFirst: index == 0,
                    isLast: index == allJots.length - 1,
                  );
                },
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
