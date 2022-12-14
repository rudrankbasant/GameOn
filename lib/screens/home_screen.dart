import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import '../utils/colors_util.dart';
import '../utils/date_utils.dart' as date_utils;
import 'ground_details.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String searchQuery = "";
  HexColor customGreen = HexColor('#088F81');
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
  String selectedDate = DateTime.now().toString().substring(0,10);

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
      height: 110,
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
              selectedDate = currentDateTime.toString().substring(0,10);
              print(currentDateTime.toString().substring(0,10));
            });
          },
          child: Container(
            width: 80,
            height: 40,
            decoration: BoxDecoration(
                color: currentDateTime.day == currentMonthList[index].day
                    ? customGreen
                    : Colors.white,
                borderRadius: BorderRadius.circular(15)),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                    child: Text(
                      DateFormat('MMM').format(currentMonthList[index]),
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.normal,
                          color:
                          (currentMonthList[index].day != currentDateTime.day)
                              ? HexColor("465876")
                              : Colors.white),
                    ),
                  ),
                  Text(
                    currentMonthList[index].day.toString(),
                    style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color:
                        (currentMonthList[index].day != currentDateTime.day)
                            ? HexColor("465876")
                            : Colors.white),
                  ),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                    child: Text(
                      date_utils.DateUtils
                          .weekdays[currentMonthList[index].weekday - 1],
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.normal,
                          color:
                          (currentMonthList[index].day != currentDateTime.day)
                              ? HexColor("465876")
                              : Colors.white),
                    ),
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
        resizeToAvoidBottomInset : false,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.0),
          child: AppBar(
          systemOverlayStyle: const SystemUiOverlayStyle(
            // Status bar color
            statusBarColor: Colors.transparent,
            // Status bar brightness (optional)
            statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
            statusBarBrightness: Brightness.light, // For iOS (dark icons)
          ),
          backgroundColor: customGreen,
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
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('grounds').where('datetime', isEqualTo: selectedDate).snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return const Text('Something went wrong');
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.data!.docs.isEmpty) {
                    return  Column(
                      children: [
                        top_calendar_view(),
                        const Center(child: Text('No Grounds')),
                      ],
                    );
                  }
                  return Column(
                    children: [
                      top_calendar_view(),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                IconButton(onPressed: (){}, icon: Icon(Icons.location_on_outlined, color: customGreen, size: 20,)),
                                const Text('Maharashtra, India', style: TextStyle(color: Colors.black, fontSize: 13, fontWeight: FontWeight.bold),),
                              ],
                            ),
                            Row(
                              children: [
                                Text("Change", style: TextStyle(color: customGreen, fontSize: 12),),
                                IconButton(onPressed:(){}, icon: Icon(Icons.arrow_forward_ios, color: customGreen, size: 15)),
                              ],
                            ),
                          ],
                          ),
                          Row(
                              children: [
                                Expanded(
                                  child: Container(
                                      margin: const EdgeInsets.only(left: 20.0, right: 20.0),
                                      child: const Divider(
                                        height: 0,
                                        thickness: 1,
                                      )),
                                ),
                              ]
                          )
                        ],
                      ),
                      ListView(
                        shrinkWrap: true,
                        children: snapshot.data!.docs.map((DocumentSnapshot document) {
                          Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => GroundDetails(
                                      data: data,
                                    ),
                                  ),
                                );
                              },
                              child: Card(
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                          width: 110.0,
                                          height: 120.0,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.rectangle,
                                              borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                                              image: DecorationImage(
                                                  fit: BoxFit.fill,
                                                  image: NetworkImage(
                                                      data['img'])
                                              )
                                          )
                                        ),
                                        Expanded(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              const Text("20 over", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                                              StreamBuilder<QuerySnapshot>(
                                                stream: FirebaseFirestore.instance.collection('slots').where('over_type', isEqualTo: '20').snapshots(),
                                                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                                  if (snapshot.hasError) {
                                                  return const Text('Something went wrong');
                                                  }
                                                  if (snapshot.connectionState == ConnectionState.waiting) {
                                                  return const Center(child: CircularProgressIndicator());
                                                  }
                                                  if (snapshot.data!.docs.isEmpty) {
                                                  return  const Center(child: Text('No Slots Available'));
                                                  }
                                                  return Container(
                                                    height: 30,
                                                    child: ListView(
                                                      shrinkWrap: true,
                                                      scrollDirection: Axis.horizontal,
                                                      children: snapshot.data!.docs.map((DocumentSnapshot document) {
                                                      Map<String, dynamic> slotData = document.data()! as Map<String, dynamic>;
                                                      return Card(
                                                        color: slotData['booked'] ? Colors.white : customGreen,
                                                        shape: RoundedRectangleBorder(
                                                          side: BorderSide(
                                                            color: slotData['booked'] ? Colors.red : customGreen ,
                                                          ),
                                                          borderRadius: BorderRadius.circular(5.0),
                                                        ),
                                                        child: Column(
                                                          children: [
                                                            Padding(
                                                              padding: const EdgeInsets.fromLTRB(5, 3, 5, 3),
                                                              child: Text(slotData['time'], style: TextStyle(color: slotData['booked'] ? Colors.red : Colors.white ,fontSize: 10, fontWeight: slotData['booked'] ? FontWeight.normal : FontWeight.bold)),
                                                            ),
                                                          ]
                                                        ),
                                                      );}).toList(),
                                                    ),
                                                  );
                                                }
                                              ),
                                              const Text("30 over", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                                              StreamBuilder<QuerySnapshot>(
                                                  stream: FirebaseFirestore.instance.collection('slots').where('over_type', isEqualTo: '30').snapshots(),
                                                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                                    if (snapshot.hasError) {
                                                      return const Text('Something went wrong');
                                                    }
                                                    if (snapshot.connectionState == ConnectionState.waiting) {
                                                      return const Center(child: CircularProgressIndicator());
                                                    }
                                                    if (snapshot.data!.docs.isEmpty) {
                                                      return  const Center(child: Text('No Slots Available '));
                                                    }
                                                    return Container(
                                                      height: 30,
                                                      child: ListView(
                                                        shrinkWrap: true,
                                                        scrollDirection: Axis.horizontal,
                                                        children: snapshot.data!.docs.map((DocumentSnapshot document) {
                                                          Map<String, dynamic> slotData = document.data()! as Map<String, dynamic>;
                                                          return Card(
                                                            color: slotData['booked'] ? Colors.white : customGreen,
                                                            shape: RoundedRectangleBorder(
                                                              side: BorderSide(
                                                                color: slotData['booked'] ? Colors.red : customGreen ,
                                                              ),
                                                              borderRadius: BorderRadius.circular(5.0),
                                                            ),
                                                            child: Column(
                                                                children: [
                                                                  Padding(
                                                                    padding: const EdgeInsets.fromLTRB(5, 3, 5, 3),
                                                                    child: Text(slotData['time'], style: TextStyle(color: slotData['booked'] ? Colors.red : Colors.white ,fontSize: 10, fontWeight: slotData['booked'] ? FontWeight.normal : FontWeight.bold)),
                                                                  ),
                                                                ]
                                                            ),
                                                          );}).toList(),
                                                      ),
                                                    );
                                                  }
                                              ),

                                            ],
                                          ),
                                        )]

                                    ),
                                    Row(
                                      children: [
                                        const SizedBox(width: 10,),
                                        Text(data['name'], style: const TextStyle(fontSize: 17.5, fontWeight: FontWeight.bold),),
                                      ],
                                    ),
                                    const SizedBox(height: 5),
                                    Row(
                                      children: [
                                        const SizedBox(width: 5),
                                        const Icon(Icons.location_on_outlined, color: Colors.grey),
                                        const SizedBox(width: 5),
                                        Text(data['location'], style: const TextStyle(color: Colors.grey, fontSize: 15, fontWeight: FontWeight.normal),),
                                      ],
                                    ),
                                    Row(
                                        children: [
                                          Expanded(
                                            child: Container(
                                                margin: const EdgeInsets.only(left: 10.0, right: 20.0),
                                                child: const Divider(
                                                  height: 15,
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
                                          Row(
                                            children: [
                                              const Text("Pitch Type: ", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300)),
                                              Text(data['pitch_type'], style: const TextStyle(fontSize: 15, fontWeight: FontWeight.normal)),
                                            ],
                                          ),
                                          Row(
                                            children:[
                                              Icon(Icons.assistant_navigation, color: customGreen),
                                              SizedBox(width: 5),
                                              Text("Navigate",  style: TextStyle(color: customGreen,fontSize: 15, fontWeight: FontWeight.normal)),
                                              SizedBox(width: 7),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        )
    );
  }

}