import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medilink_app/screens/search/search_controller.dart';
import 'package:medilink_app/screens/search/search_screen.dart';
import 'package:medilink_app/utils/constants.dart';
// import 'package:medilink_client/utils/constatnts.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({
    super.key,
    required this.searchText,
    this.withFilteringBadge = false,
  });
  final String searchText;
  final bool withFilteringBadge;

  @override
  Widget build(BuildContext context) {
    final UsersSearchController _searchController =
        Get.put(UsersSearchController());

    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Flexible(
          flex: 5,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
              boxShadow: const [
                BoxShadow(
                  color: Color.fromARGB(84, 228, 226, 226),
                  blurRadius: 10.0, // soften the shadow
                  spreadRadius: 0.0, //extend the shadow
                )
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                const SizedBox(
                  width: 10,
                ),
                const Icon(
                  Icons.search,
                  size: 30,
                  color: Color.fromARGB(134, 37, 200, 237),
                ),
                Flexible(
                  child: TextField(
                    textInputAction: TextInputAction.search,
                    // onChanged: (String query) {},
                    onSubmitted: (query) {
                      _searchController.query = query;
                      Get.to(SearchScreen());
                    },
                    autofocus: false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      hintStyle: GoogleFonts.nunitoSans(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      fillColor: Colors.white,
                      hintText: searchText,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        Flexible(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(84, 228, 226, 226),
                  blurRadius: 15.0, // soften the shadow
                  spreadRadius: 4.0, //extend the shadow
                )
              ],
              color: primaryColor,
              borderRadius: BorderRadius.all(
                Radius.circular(12),
              ),
            ),
            child: const ImageIcon(
              AssetImage("assets/icons/selective.png"),
              color: Colors.white,
              size: 30,
            ),
          ),
        )
      ],
    );
  }
}
