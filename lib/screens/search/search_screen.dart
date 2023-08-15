import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medilink_app/components/custom_app_bar.dart';
import 'package:medilink_app/models/user.dart';
import 'package:medilink_app/screens/search/search_controller.dart';
import 'package:medilink_app/screens/user/user_screen.dart';
import 'package:medilink_app/utils/constants.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  void navigateToUserCard(String userId) {
    Get.to(UserScreen(userId: userId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(
            top: defaultScreenPadding,
            right: defaultScreenPadding,
            left: defaultScreenPadding,
          ),
          child: GetX<UsersSearchController>(builder: (_) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomAppBar(
                  title: "Search",
                  onBack: () {
                    Get.back();
                  },
                ),
                _.searchResults.length > 0
                    ? Column(
                        children: [
                          const SizedBox(
                            height: 26,
                          ),
                          Text(
                            "Search Results ${_.searchResults.length}",
                            style: GoogleFonts.nunitoSans(
                              color: typingColor.withOpacity(0.75),
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      )
                    : Container(),
                const SizedBox(
                  height: 26,
                ),
                _.isLoading.value
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: primaryColor,
                        ),
                      )
                    : _.errorMessage.value.isNotEmpty
                        ? Text(_.errorMessage.value)
                        : _.searchResults.isEmpty
                            ? Text(
                                'No results found.',
                                style: GoogleFonts.nunitoSans(
                                  color: typingColor,
                                  fontSize: 18,
                                ),
                              )
                            : SizedBox(
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  itemCount: _.searchResults.length,
                                  itemBuilder: (context, index) {
                                    User user = _.searchResults[index];
                                    return GestureDetector(
                                      onTap: () {
                                        navigateToUserCard(user.id);
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                          top: index == 0 ? 0 : 12,
                                        ),
                                        child: searchResultRow(user),
                                      ),
                                    );
                                  },
                                ),
                              ),
              ],
            );
          }),
        ),
      ),
    );
  }

  Row searchResultRow(User user) {
    return Row(
      children: [
        CircleAvatar(
          maxRadius: 30,
          backgroundImage: user.picture != null
              ? CachedNetworkImageProvider(user.picture!)
              : const AssetImage(kProfile) as ImageProvider,
        ),
        const SizedBox(
          width: 12,
        ),
        Column(
          children: [
            user.role == 'HealthcareProvider'
                ? Text(
                    user.name,
                    style: GoogleFonts.nunitoSans(
                      color: typingColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  )
                : Text(
                    user.firstname!,
                    style: GoogleFonts.nunitoSans(
                      color: typingColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
            user.role == 'HealthcareProvider' && user.type == 'Doctor'
                ? Text(
                    user.speciality!,
                    style: GoogleFonts.nunitoSans(
                      color: typingColor.withOpacity(0.75),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                : user.role == 'HealthcareProvider' && user.type != 'Doctor'
                    ? Text(
                        '${user.type}',
                        style: GoogleFonts.nunitoSans(
                          color: typingColor.withOpacity(0.75),
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    : Text(
                        "${user.lastname}",
                        style: GoogleFonts.nunitoSans(
                          color: typingColor.withOpacity(0.75),
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      )
          ],
        )
      ],
    );
  }
}
