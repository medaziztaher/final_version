import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medilink_app/utils/constants.dart';

class SpecialityCard extends StatelessWidget {
  const SpecialityCard({
    super.key,
    required this.index,
    required this.item,
  });

  final int index;
  final Map<String, dynamic> item;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(22),
        ),
      ),
      height: 100,
      width: 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: ImageIcon(
              AssetImage(item["image"]!),
              color: item["theme"],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            item["name"]!,
            style: GoogleFonts.nunitoSans(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: typingColor,
            ),
          ),
        ],
      ),
    );
  }
}
