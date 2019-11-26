import 'package:Jot/bloc/jot/bloc.dart';
import 'package:Jot/data/jot/jot_model.dart';
import 'package:Jot/main_exports.dart';
import 'package:flutter/material.dart';

class JotContainerLarge extends StatelessWidget {
  const JotContainerLarge(
    this.jot, {
    this.isFirst,
    this.isLast,
    this.datePeriod,
    this.onTap,
  });

  final Jot jot;
  final bool isFirst;
  final Widget datePeriod;
  final bool isLast;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(5),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.edit),
                color: Colors.blue[300],
                onPressed: () {
                  Navigator.pushNamed(context, '/create', arguments: jot);
                  onTap();
                },
              ),
              IconButton(
                icon: Icon(Icons.delete),
                color: Colors.red[300],
                onPressed: () {
                  BlocProvider.of<JotBloc>(context).add(
                    DeleteJot(jot.uid),
                  );
                },
              ),
            ],
          ),
          Divider(),
          if (jot.tags != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Wrap(
                alignment: WrapAlignment.start,
                crossAxisAlignment: WrapCrossAlignment.start,
                children: jot.tags.map(
                  (dynamic tag) {
                    return Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        tag,
                        textAlign: TextAlign.left,
                        style: TextStyle(color: Colors.black, fontSize: 13),
                      ),
                    );
                  },
                ).toList(),
              ),
            ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(child: datePeriod),
                if (jot.isImportant)
                  Icon(
                    Icons.star,
                    color: Color(0xff2ebf91),
                  )
              ],
            ),
          ),
          GestureDetector(
            onTap: () => this.onTap(),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width - 82,
                  child: Text(
                    jot.text,
                    maxLines: null,
                    style: TextStyle(fontSize: 15),
                  ),
                ),
                RotationTransition(
                  turns: new AlwaysStoppedAnimation(180 / 360),
                  child: Icon(
                    Icons.arrow_drop_down_circle,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
