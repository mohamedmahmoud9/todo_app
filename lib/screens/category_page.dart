import 'package:flutter/material.dart';
import 'package:todoapp/widgets/entry_item.dart';
import '../widgets/chart_bar.dart';
import '../widgets/new_entry.dart';
import '../providers/entries.dart';
import 'package:provider/provider.dart';

class CategoryPage extends StatelessWidget {
  static const routeName = '/category';
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final category = ModalRoute.of(context).settings.arguments;
    final categorystr = category.toString().split('.')[1].toUpperCase();
 
        void _startAddNewEntry(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            child: NewEntry(category),
            behavior: HitTestBehavior.opaque,
          );
        });
  }
    return Scaffold(
      backgroundColor: Color(0xffececec),
      body: SingleChildScrollView(
              child: Stack(
          children: <Widget>[
            Container(
              width: width,
              height: height * .35,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.elliptical(200, 200),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 30, right: 30, top: 10),
              child: Column(
                children: <Widget>[
                  Container(
                    height: height * .15,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        FittedBox(
                          child: Text(
                            'ToDo',
                            style: TextStyle(
                                color: Colors.black87,
                                fontSize: 40,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        FittedBox(
                            child: IconButton(
                                icon: Icon(Icons.arrow_back,
                                    size: 40, color: Colors.black87),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                }))
                      ],
                    ),
                  ),
                  Container(
                    height: height * 0.03,
                    child: FittedBox(
                      child: Consumer<Entries>(
                        builder: (ctx, entity, _) =>entity.allItems(category).isEmpty? Text('No tasks add yet!'): Text(
                          '${(entity.completedItemsByCategory(category).length / entity.allItems(category).length * 100).toStringAsFixed(1)}%',
                          style: TextStyle(color: Colors.black54),
                        ),
                      ),
                    ),
                  ),
                  Container(
                      padding: EdgeInsets.only(bottom: 30),
                      child: Hero(
                        tag: category,
                        child: ChartBar(height / 2,  category),
                      )),
                  Container(
                    width: width * .85,
                    height: height * .6,
                    padding: EdgeInsets.only(top: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey[300],
                            offset: Offset(5, 5),
                            blurRadius: 10)
                      ],
                    ),
                    // color: Colors.red,
                    child: Column(
                      children: <Widget>[
                        Text(
                          categorystr,
                          style: TextStyle(
                            fontSize: 40,
                            color: Colors.black87,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          // height: height * .3,
                          child: Consumer<Entries>(
                            builder: (ctx, entry, _) => Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                FittedBox(
                                  child: Chip(
                                    label: Text(
                                      '${entry.completedItemsByCategory(category).length} Completed',
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
                                      '${entry.ongoingItemsByCategory(category).length} Ongoing',
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
                        ),
                        Consumer<Entries>(
                          builder: (ctx,entry,_)=>entry.allItems(category).length==0? Padding(
                            padding: EdgeInsets.only(bottom: 20),
                            child: Image.asset('assets/images/waiting.png',width: double.infinity,height: 300,)):Container(
                            height: 320,
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            child: ListView.builder(
                              padding: EdgeInsets.all(0),
                              itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
                                value:entry.allItems(category)[i],
                                child: EntryItem(),
                              ),
                              itemCount:entry.allItems(category).length,
                            ),
                          ),
                        ),
                        Expanded(

                          child: Stack(
                            alignment: Alignment.center,
                            children: <Widget>[
                            
                              
                                  Container(
                                    width: width*.8,
                                
                                  decoration: BoxDecoration(
                                        color: Color(0xff0bb3d4),
                                    borderRadius: BorderRadius.only(topRight: Radius.circular(30),topLeft :Radius.circular(30),)
                                  ),
                                    ),
                              
                              
                                Container(
                                  // alignment: Alignment.center,
                                  // padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    // border: Border.all(width: 10,color:Colors.white)
                                  borderRadius: BorderRadius.circular(100)
                                
                                  ),
                                  child:
                                    FlatButton.icon(
// borderSide: BorderSide(color: Colors.transparent),
                                     label: Text('Add',style: TextStyle(color:Colors.white,),),
                        
                                      onPressed: (){
                                        _startAddNewEntry(context);
                                      },
                                      icon: Icon(Icons.add_alert,color: Colors.white,),
                                      // color: Colors.white,
                                    ),
                              ),
                               
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
