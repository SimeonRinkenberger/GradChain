import 'package:flutter/material.dart';

class ClaimWidget extends StatelessWidget {
  //late final List<String> claimDiplomas;
  //NotificationPreviewList({requied. this.ClaimDiplomas});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Center(
        child: ConstrainedBox(
          //constraints: BoxConstraints.loose(Size(700.0, 250.0)),
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.width * 0.3,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Container(
              //height: MediaQuery.of(context).size.width * 0.3,
              height: 225,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.black),
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 0)),
                  Text(
                    'New documents are available for you to claim',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  //crossAxisAlignment: CrossAxisAlignment.center,
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount:
                          3, //Placeholder value, will need to change to the value of the string's length
                      itemBuilder: (BuildContext, int index) {
                        return ListTile(
                            leading: Icon(Icons.notifications),
                            title: Text('Placeholder'),
                            trailing: Wrap(spacing: 8, children: <Widget>[
                              IconButton(
                                onPressed: () => {},
                                icon: Icon(Icons.cancel_outlined),
                              ),
                              IconButton(
                                  onPressed: () => {},
                                  icon: Icon(
                                    Icons.check_circle_outline,
                                  ))
                            ]));
                      })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
