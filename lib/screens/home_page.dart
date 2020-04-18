// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:todoapp/models/entry.dart';
import '../widgets/category_tile.dart';

import 'package:provider/provider.dart';
import '../providers/entries.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
   
    final height = MediaQuery.of(context).size.height;
    // final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xffececec),

      body: Stack(
        children: <Widget>[
          Container(
            // width: width,
            height: height * .35,
            // color: Colors.white,
            decoration: BoxDecoration(
              color: Colors.white,
              // boxShadow: [
              //   BoxShadow(color: Colors.black12, offset: Offset(-1, 5))
              // ],
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.elliptical(200, 200),
                // bottomRight: Radius.elliptical(180, -90),
              ),
            ),
          ),
          // FutureBuilder(
          //   future: Provider.of<Entries>(context).fetchAndSetEntries(),
          //   builder: (ctx, snapshot) =>
          Container(
            padding: EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 40),
            child: FutureBuilder(
                  future: Provider.of<Entries>(context,listen: false).fetchAndSetEntries(),
                  builder: (ctx, snaphot) => 
                  snaphot.connectionState==ConnectionState.waiting?
                  Center(child: CircularProgressIndicator(
                    // strokeWidth: 1,
                    // value: 50,
                    // semanticsValue: 'loading',
                    backgroundColor:  Color(0xff0bb3d4),
                  ))
                  :
                         Column(
                children: <Widget>[
                  // height: height * .268,
                
                      // SizedBox(width: width * .1),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            alignment: Alignment.centerLeft,
                            width: double.infinity,
                            height: height * .1,
                            child: FittedBox(
                              child: Text(
                                'Hello !',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 52,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                    
                          Container(
                            alignment: Alignment.centerLeft,
                            width: double.infinity,
                            // height: height * .05,
                            child: Consumer<Entries>(builder:(ctx,entries,_)=> FittedBox(
                                child: Text(
                                  'You Have ${entries.totalCompletedItems} Completed Tasks.\n${entries.totalOngoingItems} Are Still Ongoing.',
                                  style: TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    
                  CategoryTile(
                    EntryCategory.work,
                  ),
                  CategoryTile(
                    EntryCategory.personal,
                  ),
                  CategoryTile(
                    EntryCategory.home,
                  ),
                  CategoryTile(
                    EntryCategory.office,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      //   ],
      // ),
    );
  }
}
