import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/models/entry.dart';
import '../providers/entries.dart';

class ChartBar extends StatelessWidget {
  final double height;
  final EntryCategory category;
  ChartBar(
    this.height,
    this.category,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height * .05,
      child: LayoutBuilder(
        builder: (ctx, constraints) {
          return Container(
            // height: height * .1,
            width: constraints.maxWidth * 8,
            child: Stack(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      // border: Border.all(
                      //     width: 1, color: Colors.grey),
                      borderRadius: BorderRadius.circular(20)),
                ),
                Consumer<Entries>(
                  builder: (ctx, entry, _) => FractionallySizedBox(
                    widthFactor: entry
                                    .completedItemsByCategory(category)
                                    .length +
                                entry.ongoingItemsByCategory(category).length ==
                            0
                        ? 0
                        : entry.completedItemsByCategory(category).length /
                            (entry.completedItemsByCategory(category).length +
                                entry.ongoingItemsByCategory(category).length),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [
                          Colors.blue,
                          Colors.purple,
                        ]),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
