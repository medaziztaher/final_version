import 'package:get/get.dart';

class UnbordingContent {
  String image;
  String title;
  String discruption;

  UnbordingContent(
      {required this.image, required this.title, required this.discruption});
}

List<UnbordingContent> contents = [
  UnbordingContent(
    image: 'assets/images/Doctor2.jpg',
    title: "ktitle1".tr,
    discruption: "kdiscruption1".tr,
  ),
  UnbordingContent(
      image: 'assets/images/Doctor1.jpg',
      title: "ktitle2".tr,
      discruption: "kdiscruption2".tr),
  UnbordingContent(
      image: 'assets/images/Doctor3.jpg',
      title: "ktitle3".tr,
      discruption: "kdiscruption3".tr)
];
