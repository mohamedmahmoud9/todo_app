import 'package:todoapp/models/entry.dart';
import '../screens/category_page.dart';
import '../providers/entries.dart';
import './chart_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryTile extends StatelessWidget {
  final EntryCategory category;

  CategoryTile(this.category);
  @override
  Widget build(BuildContext context) {
    final items = Provider.of<Entries>(context, listen: false);
  final completed = items.completedItemsByCategory(category).length;
    final ongoing = items.ongoingItemsByCategory(category).length;
    final height = ((MediaQuery.of(context).size.height * .8) / 4);
    final persent = completed / (ongoing + completed) * 100;
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .pushNamed(CategoryPage.routeName, arguments: category);
      },
      child: Container(
        // width: MediaQuery.of(context).size.width * .85,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Colors.grey[300], offset: Offset(5, 5), blurRadius: 10)
          ],
        ),
        // padding: EdgeInsets.only(bottom:5),
        child: Card(
          elevation: 0.0,
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  // height: height * .3,
                  child: Text(category.toString().split('.')[1].toUpperCase(),
                      textAlign: TextAlign.start,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ),
                Container(
                  height: height * .4,
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      FittedBox(
                        child: Chip(
                          label: Text(
                            '$completed Completed',
                            style: TextStyle(
                                fontSize: 10,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          backgroundColor: Color(0xff0bb3d4),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      FittedBox(
                        child: Chip(
                          label: Text(
                            '$ongoing Ongoing',
                            style: TextStyle(
                                fontSize: 10,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          backgroundColor: Color(0xffff7272),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  alignment: AlignmentDirectional.centerEnd,
                  padding: EdgeInsets.only(bottom: 2),
                  height: height * 0.1,
                  child: FittedBox(
                    child: completed + ongoing == 0
                        ? Text('No tasks add yet!' , style: TextStyle(color: Colors.black54),)
                        : Text(
                            '${persent.toStringAsFixed(1)}%',
                            style: TextStyle(color: Colors.black54),
                          ),
                  ),
                ),
                Hero(
                    tag: category,
                    child: ChartBar(height*1.5, category)),    
              ],
            ),
          ),
        ),
      ),
    );
  }
}
