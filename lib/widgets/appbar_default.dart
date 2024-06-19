// import 'package:flutter/material.dart';
// class AppBarDefault extends StatelessWidget {
//   AppBarDefault({
//     super.key,
//     this.isWithAdds = true,
//     this.onTapMenu = defaultTapMenu,
//     this.onTapSearch = defaultTapSearch,
//     this.onTapBack = defaultTapBack,
//     this.isNavigation = false,
//     this.isWithBack = false,
//   });

//   final bool isWithAdds;
//   final bool isNavigation;
//   final bool isWithBack;
//   final VoidCallback onTapSearch;
//   final VoidCallback onTapMenu;
//   final VoidCallback onTapBack;

//   static defaultTapSearch() {
//     Get.toNamed(RouteName.search);
//   }

//   static defaultTapMenu() {
//     // Get.toNamed(RouteName.home);
//   }

//   static defaultTapBack() {
//     Get.back();
//   }

//   BannerController bannerController = Get.find();
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: kColorWhite,
//       padding: EdgeInsets.only(
//         top: MediaQuery.of(context).viewPadding.top + 16,
//         right: 16,
//         left: 16,
//         bottom: 14,
//       ),
//       alignment: Alignment.centerLeft,
//       child: Row(
//         children: [
//           isWithBack
//               ? ButtonAction(
//                   onTap: defaultTapBack,
//                   child: SvgPicture.asset(
//                     AssetConstant.icArrowBack,
//                     width: 24,
//                     color: kColorNeutralBlack,
//                   ),
//                 )
//               : const SizedBox(),
//           ButtonAction(
//             onTap: defaultTapMenu,
//             child: Image.asset(
//               AssetConstant.icLogoKuatBaca,
//               width: 120,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
