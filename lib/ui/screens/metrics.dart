import 'package:Jot/bloc/application/bloc.dart';
import 'package:Jot/bloc/jot/bloc.dart';
import 'package:Jot/ui/widgets/jot_drawer.dart';
import 'package:Jot/ui/widgets/monthChart.dart';
import 'package:Jot/ui/widgets/numberOfJots.dart';
import 'package:Jot/ui/widgets/significantJotPie.dart';
import 'package:Jot/ui/widgets/tagsChart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MetricsPage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _metricsKey = GlobalKey<ScaffoldState>();

  Widget columCreator({int number, String title}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          number.toString(),
          style: TextStyle(fontSize: 36, color: Color(0xffF5C5BE),)
        ),
        Text(
          title,
          style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold)
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _metricsKey,
      drawer: JotDrawer(),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: const Text(
          'Metrics',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: Color(0xffF5C5BE),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Color(0xff539D8B),
        child: BlocBuilder<JotBloc, JotState>(
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
                          BlocProvider.of<ApplicationBloc>(context)
                              .state
                              .user
                              .uid;
                      BlocProvider.of<JotBloc>(context).add(
                        StreamJots(userId),
                      );
                    },
                  )
                ],
              );
            }
            if (jotState is LoadedJots) {
              return ListView(
                children: <Widget>[
                  NumberOfJots(jotState: jotState,),
                  SignificantJotsPie(jotState: jotState,),
                  TagsChart(jotState: jotState,),
                  MonthChart(jotState: jotState,),
                ],
              );
            }
            return ListView(
              children: <Widget>[],
            );
          },
        ),
      ),
    );
  }
}
