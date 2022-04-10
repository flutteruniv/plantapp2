import 'package:flutter/material.dart';

class EventCard extends StatelessWidget {
  EventCard({this.imgURL, this.title, this.date, this.press});
  final String? imgURL, title, date;
  final void Function()? press;

  // "assets/images/image1.jpg"
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        padding: EdgeInsets.only(top: 30),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(36),
            topRight: Radius.circular(36),
          ),
        ),
        width: 350,
        child: Column(
          children: [
            Image.network(
              imgURL!,
              fit: BoxFit.cover,
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              decoration: const BoxDecoration(
                  color: Colors.blueGrey,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(36),
                    bottomRight: Radius.circular(36),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      spreadRadius: 1.0,
                      blurRadius: 10.0,
                      offset: Offset(10, 10),
                    ),
                  ]),
              child: Column(
                children: [
                  Text("$title"),
                  Text("$date"),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
