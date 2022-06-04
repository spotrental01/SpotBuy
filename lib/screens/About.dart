import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class About extends StatelessWidget {
  const About({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(30.0),
          margin: const EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/images/About us page.png'),
               Text(
                  " 'Buy What You Don’t Have Nevertheless, Or What You Actually Wish, Which Might Be Mixed With What You Already Own. "
                      "Get Solely As A Result Of One Thing Excites You, Not Only For The Straightforward Act Of Looking.' ",
              style: GoogleFonts.lato(
                fontSize: 15,
              ),),
              const SizedBox(height: 10.0),
               Text(
                  "As A Reputation Says Spotbuy Which Suggests "
                      "You Don’t Get To Surround Anyplace To Shop For Things Associated With Automobile. ",
                style: GoogleFonts.lato(
                  fontSize:15,
                ),
              ),
              const SizedBox(height: 10.0),
              Text("All Things On The Market Below Your Tip.",
                style: GoogleFonts.lato(
                  fontSize:15,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
