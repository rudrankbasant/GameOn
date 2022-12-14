import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';


import 'package:provider/provider.dart';
import '../models/Ground.dart';
import '../utils/colors_util.dart';


class GroundDetails extends StatefulWidget {
  final Map<String, dynamic> data;
  const GroundDetails({Key? key, required this.data}) : super(key: key);

  @override
  _GroundDetailsState createState() => _GroundDetailsState();
}

class _GroundDetailsState extends State<GroundDetails> {
  FocusNode GroundFocus = FocusNode();
  HexColor customGreen = HexColor('#088F81');


  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            title: const Text('Grounds Details'),
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
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/calendar_icon.png', height: 20, width: 20,),
                const SizedBox(width: 5),
                Text("${DateFormat("EEEE").format(DateTime.parse(widget.data['datetime']))}, ${DateFormat("dd MMMM yyyy").format(DateTime.parse(widget.data['datetime']))}",
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Container(
                margin: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                width: double.infinity,
                height: 225.0,
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(
                           widget.data['img']
                    )
                )
                )
            ),
             const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(widget.data['name'],
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children:[
                      Icon(Icons.assistant_navigation, color: customGreen),
                      SizedBox(width: 5),
                      Text("Navigate",  style: TextStyle(color: customGreen,fontSize: 15, fontWeight: FontWeight.normal, decoration: TextDecoration.underline,)),
                      SizedBox(width: 7),
                    ],
                  ),
                  Row(
                    children: [
                      const Text("Pitch Type: ", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300)),
                      Text(widget.data['pitch_type'], style: const TextStyle(fontSize: 15, fontWeight: FontWeight.normal)),
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset('assets/food_icon.png',height: 40, width: 40),
                      Image.asset('assets/toilet_icon.png', height: 40, width: 40),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 12, 0),
                    child: Card(
                      color: HexColor('#E7E7E7')  ,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: HexColor('#E7E7E7')  ,
                        ),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(5, 3, 5, 3),
                              child: Row(
                                children: [
                                  Icon(Icons.navigation, color: customGreen, size: 15),
                                  SizedBox(width: 5),
                                  Text('2 Km far', style: TextStyle(color: customGreen ,fontSize: 12.5, fontWeight:  FontWeight.normal)),
                                ],
                              ),
                            ),
                          ]
                      ),
                    ),
                  )
                ],

              ),
            ),

            //For 20 Overs
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: const [
                              SizedBox(width: 20),
                              Text("For 20 overs ", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                            child: Card(
                              color: Colors.white ,
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  color: customGreen ,
                                ),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(5, 3, 5, 3),
                                      child: Text('10:00 AM', style: TextStyle(color: customGreen ,fontSize: 12.5, fontWeight:  FontWeight.normal)),
                                    ),
                                  ]
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 15),
                      Row(
                        children: [
                          Column(
                            children: [
                              const Text("Team 1: ", style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal, color: Colors.grey)),
                              Text(widget.data['team1_20overs'], style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                child: Card(
                                  color: HexColor('#E7E7E7') ,
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                      color: HexColor('#E7E7E7')  ,
                                    ),
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  child: Column(
                                      children: const [
                                        Padding(
                                          padding: EdgeInsets.fromLTRB(10,5,10,5),
                                          child: Text('Booked', style: TextStyle(color: Colors.black ,fontSize: 12.5, fontWeight:  FontWeight.normal)),
                                        ),
                                      ]
                                  ),
                                ),
                              )

                            ],
                          ),
                          const SizedBox(width: 60),
                          Column(
                            children: [
                              const Align(
                                 alignment: Alignment.centerLeft,
                                  child: Text("Team 2: ", textAlign: TextAlign.left, style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal, color: Colors.grey))),
                              Text(widget.data['team2_20overs'], style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                child: Card(
                                  color: HexColor('#E7E7E7') ,
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                      color: HexColor('#E7E7E7')  ,
                                    ),
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  child: Column(
                                      children: const [
                                        Padding(
                                          padding: EdgeInsets.fromLTRB(10,5,10,5),
                                          child: Text('Booked', style: TextStyle(color: Colors.black ,fontSize: 12.5, fontWeight:  FontWeight.normal)),
                                        ),
                                      ]
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                      Row(
                          children: [
                            Expanded(
                              child: Container(
                                  margin: const EdgeInsets.only(left: 10.0, right: 10.0),
                                  child: const Divider(
                                    height: 10,
                                    thickness: 1,
                                  )),
                            ),
                          ]
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children:[
                                const Text("Ball Provided", style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                                Checkbox(value: widget.data['ball_provided_20overs'], onChanged: (value) {  }, checkColor: customGreen, activeColor: HexColor('#E7E7E7')),
                              ]
                            ),
                            Row(
                                children:[
                                  const Text("Umpire Provided", style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                                  Checkbox(value: widget.data['umpire_provided_20overs'], onChanged: (value) {  },checkColor: customGreen, activeColor: HexColor('#E7E7E7')),
                                ]
                            ),
                            Row(
                                children:[
                                  const Text("Ball Detail: ", style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                                  Text(widget.data['ball_detail_20overs'], style: const TextStyle(fontSize: 12, fontWeight: FontWeight.normal)),
                                ]
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                const SizedBox(height: 10),
                                Text('\u{20B9} ${widget.data['price_20overs'].toString()}', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: customGreen)),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                              child: Card(
                                color: customGreen  ,
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                    color: customGreen,
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Column(
                                    children: const [
                                      Padding(
                                        padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                                        child: Text('Book now', style: TextStyle(color: Colors.white ,fontSize: 17.5, fontWeight:  FontWeight.normal)),
                                      ),
                                    ]
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),



            //For 30 Overs
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: const [
                              SizedBox(width: 20),
                              Text("For 30 overs ", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                            child: Card(
                              color: Colors.white ,
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  color: customGreen ,
                                ),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(5, 3, 5, 3),
                                      child: Text('2:00 PM', style: TextStyle(color: customGreen ,fontSize: 12.5, fontWeight:  FontWeight.normal)),
                                    ),
                                  ]
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 15),
                      Row(
                        children: [
                          Column(
                            children: [
                              const Text("Team 1: ", style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal, color: Colors.grey)),
                              Text(widget.data['team1_30overs'], style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                child: Card(
                                  color: HexColor('#E7E7E7') ,
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                      color: HexColor('#E7E7E7')  ,
                                    ),
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  child: Column(
                                      children: const [
                                        Padding(
                                          padding: EdgeInsets.fromLTRB(10,5,10,5),
                                          child: Text('Booked', style: TextStyle(color: Colors.black ,fontSize: 12.5, fontWeight:  FontWeight.normal)),
                                        ),
                                      ]
                                  ),
                                ),
                              )

                            ],
                          ),
                          const SizedBox(width: 60),
                          Column(
                            children: [
                              const Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text("Team 2: ", textAlign: TextAlign.left, style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal, color: Colors.grey))),
                              Text(widget.data['team2_30overs'], style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                child: Card(
                                  color: HexColor('#E7E7E7') ,
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                      color: HexColor('#E7E7E7')  ,
                                    ),
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  child: Column(
                                      children: const [
                                        Padding(
                                          padding: EdgeInsets.fromLTRB(10,5,10,5),
                                          child: Text('Booked', style: TextStyle(color: Colors.black ,fontSize: 12.5, fontWeight:  FontWeight.normal)),
                                        ),
                                      ]
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                      Row(
                          children: [
                            Expanded(
                              child: Container(
                                  margin: const EdgeInsets.only(left: 10.0, right: 10.0),
                                  child: const Divider(
                                    height: 10,
                                    thickness: 1,
                                  )),
                            ),
                          ]
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                                children:[
                                  const Text("Ball Provided", style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                                  Checkbox(value: widget.data['ball_provided_30overs'], onChanged: (value) {  }, checkColor: customGreen, activeColor: HexColor('#E7E7E7')),
                                ]
                            ),
                            Row(
                                children:[
                                  const Text("Umpire Provided", style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                                  Checkbox(value: widget.data['umpire_provided_30overs'], onChanged: (value) {  },checkColor: customGreen, activeColor: HexColor('#E7E7E7')),
                                ]
                            ),
                            Row(
                                children:[
                                  const Text("Ball Detail: ", style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                                  Text(widget.data['ball_detail_30overs'], style: const TextStyle(fontSize: 12, fontWeight: FontWeight.normal)),
                                ]
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                const SizedBox(height: 10),
                                Text('\u{20B9} ${widget.data['price_30overs'].toString()}', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: customGreen)),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                              child: Card(
                                color: customGreen  ,
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                    color: customGreen,
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Column(
                                    children: const [
                                      Padding(
                                        padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                                        child: Text('Book now', style: TextStyle(color: Colors.white ,fontSize: 17.5, fontWeight:  FontWeight.normal)),
                                      ),
                                    ]
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}