import 'package:Jot/data/jot/jot_model.dart';
import 'package:flutter/material.dart';

class JotContainerSmall extends StatelessWidget {
  const JotContainerSmall(this.jot,
      {this.isFirst, this.isLast, this.datePeriod});

  final Jot jot;
  final bool isFirst;
  final bool isLast;
  final Widget datePeriod;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 150,
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 16),
            child: Column(
              children: <Widget>[
                Container(
                    width: 5,
                    height: 60,
                    color: isFirst ? Colors.transparent : Colors.white),
                Container(
                  height: 30.0,
                  width: 12.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
                Container(
                    width: 5,
                    height: 60,
                    color: isLast ? Colors.transparent : Colors.white),
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width - 66,
            padding: EdgeInsets.all(8),
            height: 150,
            margin: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(5),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(child: datePeriod),
                    Row(
                      children: <Widget>[
                        if (jot.tags != null)
                          Container(
                            padding: EdgeInsets.all(8),
                            margin: jot.isImportant ? EdgeInsets.only(right: 8) : null,
                            decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Text(
                              jot.tags.first,
                              textAlign: TextAlign.left,
                              style:
                                  TextStyle(color: Colors.black, fontSize: 13),
                            ),
                          ),
                        if (jot.isImportant)
                          Icon(
                            Icons.star,
                            color: Color(0xff2ebf91),
                          )
                      ],
                    )
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width - 106,
                      height: 60,
                      child: Text(
                        jot.text,
                        softWrap: true,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                    Icon(
                      Icons.arrow_drop_down_circle,
                      color: Colors.blue,
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
