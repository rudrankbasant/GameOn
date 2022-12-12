import 'package:flutter/material.dart';


import 'package:provider/provider.dart';
import '../models/Ground.dart';


class GroundDetails extends StatefulWidget {
  final Ground? ground;
  const GroundDetails({Key? key, this.ground}) : super(key: key);

  @override
  _GroundDetailsState createState() => _GroundDetailsState();
}

class _GroundDetailsState extends State<GroundDetails> {
  FocusNode GroundFocus = FocusNode();


  void updateGround() {
    Ground updatedGround = Ground(
      id: widget.ground!.id,
      name: widget.ground!.name,
    );


    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [],
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Text('Ground Details'),
            const SizedBox(height: 10),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                focusNode: GroundFocus,
                controller: TextEditingController(text: widget.ground!.name),
                decoration: const InputDecoration(
                  hintText: 'Ground Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text('Content'),
            const SizedBox(height: 10),
            Expanded(
              child: Container(
                height: 500,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  focusNode: GroundFocus,
                  minLines: 15,
                  maxLines: null,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter Ground',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}