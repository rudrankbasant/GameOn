import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import '../utils/colors_util.dart';
import '../utils/date_utils.dart' as date_utils;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String searchQuery = "";
  @override
  initState() {
    super.initState();
    currentMonthList = date_utils.DateUtils.daysInMonth(currentDateTime);
    currentMonthList.sort((a, b) => a.day.compareTo(b.day));
    currentMonthList = currentMonthList.toSet().toList();
    scrollController =
        ScrollController(initialScrollOffset: 70.0 * currentDateTime.day);
  }
  double width=0;
  double height=0;
  late ScrollController scrollController;
  List<DateTime> currentMonthList = List.empty();
  DateTime currentDateTime = DateTime.now();

  Widget top_calendar_view(){
    return Container(
      height: height * 0.18,
      width: width,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            horizontalCapsuleListView(),
          ]),
    );
  }

  Widget horizontalCapsuleListView() {
    return Container(
      width: width,
      height: 100,
      child: ListView.builder(
        controller: scrollController,
        scrollDirection: Axis.horizontal,
        physics: const ClampingScrollPhysics(),
        shrinkWrap: true,
        itemCount: currentMonthList.length,
        itemBuilder: (BuildContext context, int index) {
          return capsuleView(index);
        },
      ),
    );
  }

  Widget capsuleView(int index) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
        child: GestureDetector(
          onTap: () {
            setState(() {
              currentDateTime = currentMonthList[index];
            });
          },
          child: Container(
            width: 80,
            height: 40,
            decoration: BoxDecoration(
                color: currentDateTime.day == currentMonthList[index].day
                    ? Colors.green
                    : Colors.white,
                borderRadius: BorderRadius.circular(15)),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    DateFormat('MMM').format(currentMonthList[index]),
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color:
                        (currentMonthList[index].day != currentDateTime.day)
                            ? HexColor("465876")
                            : Colors.white),
                  ),
                  Text(
                    currentMonthList[index].day.toString(),
                    style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color:
                        (currentMonthList[index].day != currentDateTime.day)
                            ? HexColor("465876")
                            : Colors.white),
                  ),
                  Text(
                    date_utils.DateUtils
                        .weekdays[currentMonthList[index].weekday - 1],
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color:
                        (currentMonthList[index].day != currentDateTime.day)
                            ? HexColor("465876")
                            : Colors.white),
                  )
                ],
              ),
            ),
          ),
        ));
  }


  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          // Status bar color
          statusBarColor: Colors.transparent,
          // Status bar brightness (optional)
          statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
          statusBarBrightness: Brightness.light, // For iOS (dark icons)
        ),
        backgroundColor: Colors.red,
        leading: IconButton(
          onPressed: (){},
          icon: const Icon(Icons.menu),
        ) ,
        title: const Text('Grounds'),
        actions: [
          IconButton(
            onPressed: (){},
            icon: const Icon(Icons.search),
          ),
          IconButton(
            onPressed: (){},
            icon: const Icon(Icons.sort),
          )
        ],
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(15),
          ),
        ),
      ),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('grounds').snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Text('Something went wrong');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.data!.docs.isEmpty) {
              return  Center(child: Text('No Grounds ${snapshot.data!.docs}'));
            }
            return Column(
              children: [
                top_calendar_view(),
                ListView(
                  shrinkWrap: true,
                  children: snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                      child: Card(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                          margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                          width: 75.0,
                                          height: 100.0,
                                          decoration: const BoxDecoration(
                                              shape: BoxShape.rectangle,
                                              borderRadius: BorderRadius.all(Radius.circular(8.0)),
                                              image: DecorationImage(
                                                  fit: BoxFit.fill,
                                                  image: NetworkImage(
                                                      "https://upload.wikimedia.org/wikipedia/en/6/66/Matthew_Perry_as_Chandler_Bing.png")
                                              )
                                          )
                                      ),
                                Expanded(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text("20 over", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                                      StreamBuilder<QuerySnapshot>(
                                        stream: FirebaseFirestore.instance.collection('slots').snapshots(),
                                        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                          if (snapshot.hasError) {
                                          return const Text('Something went wrong');
                                          }
                                          if (snapshot.connectionState == ConnectionState.waiting) {
                                          return const Center(child: CircularProgressIndicator());
                                          }
                                          if (snapshot.data!.docs.isEmpty) {
                                          return  Center(child: Text('No Slots Available ${snapshot.data!.docs}'));
                                          }
                                          return Container(
                                            height: 50,
                                            child: ListView(
                                              shrinkWrap: true,
                                              scrollDirection: Axis.horizontal,
                                              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                                              Map<String, dynamic> slotData = document.data()! as Map<String, dynamic>;
                                              return Card(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(15.0),
                                                ),
                                                child: Container(
                                                  padding: const EdgeInsets.all(5),
                                                  height: 5,
                                                  width: 70,
                                                  decoration: BoxDecoration(
                                                      border: Border.all(color: Colors.green),
                                                      color: Colors.green
                                                  ),
                                                  child: Text(slotData['time'], style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.normal),),
                                                ),
                                              );}).toList(),
                                            ),
                                          );
                                        }
                                      ),
                                      const Text("30 over", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),

                                    ],
                                  ),
                                )]

                            ),
                            Row(
                              children: [
                                const SizedBox(width: 10,),
                                Text(data['name'], style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                              ],
                            ),
                            Row(
                              children: [
                                const SizedBox(width: 10,),
                                Text(data['location'], style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                              ],
                            ),
                            Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                        margin: const EdgeInsets.only(left: 10.0, right: 20.0),
                                        child: const Divider(
                                          height: 30,
                                          thickness: 1,
                                        )),
                                  ),
                                ]
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 15, 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(data['location'], style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                                  const Icon(Icons.navigation, color: Colors.black)
                                ],
                              ),
                            ),
                          ],
                        )
                      ),
                    );
                  }).toList(),
                ),
              ],
            );
          },
        )
    );
  }

}