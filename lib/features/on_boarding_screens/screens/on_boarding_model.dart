import 'package:se7ety/core/constants/app_icons.dart';

class OnBoardingModel {
  final String image;
  final String title;
  final String description;

  OnBoardingModel({
    required this.image,
    required this.title,
    required this.description,
  });
}

final List<OnBoardingModel> pages = [
  OnBoardingModel(
    image: AppIcons.onBoarding1,
    title: "ابحث عن دكتور متخصص",
    description:
        "اكتشف مجموعة واسعة من الأطباء الخبراء والمتخصصين في مختلف المجالات.",
  ),
  OnBoardingModel(
    image: AppIcons.onBoarding4,
    title: "سهولة الحجز",
    description: "احجز المواعيد بضغطة زرار في أي وقت وفي أي مكان",
  ),
  OnBoardingModel(
    image: AppIcons.onBoarding5,
    title: "آمن وسري",
    description: "كن مطمئنًا لأن خصوصيتك وأمانك هما أهم أولوياتنا.",
  ),
];
