import 'package:flutter/material.dart';

class AcceptRemoveList extends StatefulWidget {
  List<String> claimableDiplomas = [
    'BS Computer Science, California Baptist University',
    'MS Software Development, University of California Riverside',
    'PHD Computer Engineering, Harvard'
  ];
//Possible Firebase/Firestore code

  /*
  FirebaseFirestore.instance.collection(<the collection in firebase>).get().then((value){
    value.docs.forEach((item){
      claimableDiplomas.add(item.get(<))
    })
  })

  */

  /*
  StreamBuilder<QuerySnapshot>(
    stream: FirebaseFirestore.instance.collection('diploma name').snapshots(),
    List<Map<String, dynamic>> claimableDiplomas = snapshot.data.docs.map((DocumentSnapshot document){
      return document.data() as Map<String, dynamic>;
    }).toList();
  )
  */

  // ignore: use_key_in_widget_constructors
  AcceptRemoveList({claimableDiplomas});

  @override
  _AcceptRemoveListState createState() => _AcceptRemoveListState();
}

class _AcceptRemoveListState extends State<AcceptRemoveList> {
  List<String> _claimableDiplomas = [];
  //late final List<String> claimDiplomas;
  //NotificationPreviewList({requied. this.ClaimDiplomas});

  @override
  initState() {
    super.initState();
    _claimableDiplomas = widget.claimableDiplomas;
  }

  void _removeItem(int index) {
    setState(() {
      _claimableDiplomas.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: ConstrainedBox(
        //constraints: BoxConstraints.loose(Size(700.0, 250.0)),
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.width * 0.3,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Container(
            height: 225,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              //border: Border.all(color: Colors.black),
              color: Colors.white70,
            ),
            child: Column(
                //crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 0)),
                  Text(
                    'Pending documents',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: _claimableDiplomas.length,
                      itemBuilder: (BuildContext, int index) {
                        return ListTile(
                            leading: Icon(Icons.notifications),
                            title: Text(_claimableDiplomas[index]),
                            trailing:
                                Row(mainAxisSize: MainAxisSize.min, children: [
                              IconButton(
                                icon: Icon(Icons.check),
                                onPressed: () {
                                  _removeItem(index);

                                  //Firebase Code
                                },
                              ),
                              IconButton(
                                  icon: Icon(Icons.remove),
                                  onPressed: () {
                                    _removeItem(index);

                                    //Firebase Code
                                  })
                            ]));
                      }),
                  SizedBox(height: 5),
                  _claimableDiplomas.length > 0
                      ? Text('')
                      : Text('No pending docuements'),
                ]),
          ),
        ),
      ),
    );
  }
}
