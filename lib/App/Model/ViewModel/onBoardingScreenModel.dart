import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Resources/Color.dart';

class onBoardingPageModel extends StatelessWidget {
  onBoardingPageModel({super.key,required this.Mobj});
  final Map Mobj;

  @override
  Widget build(BuildContext context) {
    var media=MediaQuery.of(context).size;
    return SizedBox(
      height: media.height,
      width: media.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: media.height * .1,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              Mobj['title'].toString(),
              style:GoogleFonts.oswald(fontWeight: FontWeight.w600,
                  fontSize: 50)
            ),
          ),
          SizedBox(
            height: media.height * 0.02,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Text(
              Mobj['subtitle'].toString(),
              style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Poppins',
                  color: FColor.GreyBrown),
            ),
          ),
          Spacer(),
          Image.asset(
            Mobj['image'].toString(),
            fit: BoxFit.fitWidth,
            width: media.width,
          ),


        ],
      ),

    );
  }
}
