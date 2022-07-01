import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shimmer/shimmer.dart';
import '../../theme/basic_colors.dart';
import 'package:easy_localization/easy_localization.dart';

// import 'package:flutter/foundation.dart' show kIsWeb;
// final globalNavigatorKey = GlobalKey<NavigatorState>();
final routeObserver = RouteObserver<PageRoute>();

class BasicScreen {
  static Shimmer buildShimmer(bool loading, Widget child) {
    return Shimmer.fromColors(
      enabled: loading,
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: child,
    );
  }

  static Widget buildSectionHeader(String title, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0),
      child: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .subtitle1
            ?.apply(color: BasicColors.kTitle),
      ).tr(),
    );
  }

  static showErrorSnackBar(BuildContext context, String message,
      {SnackBarAction? action}) {
    print(message);

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        action: action,
        backgroundColor: Colors.red,
        content: Row(
          children: [
            Icon(FontAwesomeIcons.exclamation),
            Flexible(
              child: Container(
                child: Text(
                  message,
                  maxLines: 6,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .apply(color: Colors.white),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        )));
  }

  // static Future<void> openNotification(
  //     BuildContext context, int? type, int value) async {
  //   Future<void> getAndShowProduct() async {
  //     Product? item = await Database(context: context).getItem(value);
  //     if (item == null) {
  //       BasicScreen.showErrorSnackBar(context, 'noItemsFound'.tr());
  //       return;
  //     }
  //     showItem(context, item);
  //     // ServiceScreen(
  //     //     /// categoryId 6 rental items more than a day rent
  //     //     product: item,
  //     //     isOneDayRent: item.category.id != 6,

  //     //     /// no checkout for repair
  //     //     noCheckout: item.id == 3,
  //     //     // detailSection: ServiceDetailsWeb(
  //     //     //   product: product,
  //     //     // ),
  //     //   )
  //     // : categoryType == 1
  //     //     ? CourseScreen.route
  //     //     : ProductScreen.route
  //     // Responsive(
  //     //     mobile: categoryType == 1
  //     //         ? CourseScreen(
  //     //             product: item,
  //     //           )
  //     //         : ProductScreen(
  //     //             product: item,
  //     //           ),
  //     //     desktop: ProductScreenWeb(
  //     //       product: item,
  //     //       detailSection: CourseDetailsWeb(
  //     //         product: item,
  //     //       ),
  //     //     ))
  //     // ),
  //     // Navigator.push(
  //     //   context,
  //     //   MaterialPageRoute(
  //     //       builder: (context) => categoryType == 3
  //     //           ? ServiceScreen(
  //     //               /// categoryId 6 rental items more than a day rent
  //     //               product: item,
  //     //               isOneDayRent: item.category.id != 6,

  //     //               /// no checkout for repair
  //     //               noCheckout: item.id == 3,
  //     //               // detailSection: ServiceDetailsWeb(
  //     //               //   product: product,
  //     //               // ),
  //     //             )
  //     //           : Responsive(
  //     //               mobile: categoryType == 1
  //     //                   ? CourseScreen(
  //     //                       product: item,
  //     //                     )
  //     //                   : ProductScreen(
  //     //                       product: item,
  //     //                     ),
  //     //               desktop: ProductScreenWeb(
  //     //                 product: item,
  //     //                 detailSection: CourseDetailsWeb(
  //     //                   product: item,
  //     //                 ),
  //     //               ))),
  //     // );
  //   }

  //   try {
  //     if (type == null) return;
  //     switch (type) {
  //       case 1: //general
  //         // showProduct(); //delete saturday
  //         break;
  //       case 2: //serviceClaendar
  //         // Navigator.pushNamed(context, MyServiceBookingCalendarScreen.route);

  //         break;
  //       case 3: //request to change
  //         // Navigator.pushNamed(context, BookingRequestsScreen.route);
  //         break;
  //       case 4: //invoice
  //         // String invoiceData =
  //         await Database(context: context).getInvoiceByIdPdf(value);
  //         // var bytes = base64Decode(invoiceData.replaceAll('\n', ''));
  //         // final output = await getTemporaryDirectory();
  //         // final savedPath = "${output.path}/invoice-$value.pdf";
  //         // final file = File(savedPath);
  //         // await file.writeAsBytes(bytes.buffer.asUint8List());
  //         // print(savedPath);
  //         // await OpenFile.open(savedPath, type: "application/pdf");
  //         break;
  //       // case 5: //course time
  //       //   Navigator.push(
  //       //       context,
  //       //       FadePageRoute(
  //       //         builder: (context) => MyCoursesScreen(),
  //       //       ));
  //       //   break;
  //       case 6: //change price
  //         await getAndShowProduct();
  //         break;
  //       case 7:
  //         await getAndShowProduct();
  //         break;
  //       default:
  //     }
  //   } catch (e) {
  //     BasicScreen.showErrorSnackBar(context, e.toString());
  //   }
  // }

  // static showItem(BuildContext context, Product item) {
  //   // int categoryType = item.category.type;
  //   // Navigator.pushNamed(
  //   //     context,
  //   //     // ${categoryType == 3 ? ServiceScreen.route : categoryType == 1 ? CourseScreen.route : ProductScreen.route}
  //   //     "item?id=${item.id}",
  //   //     arguments: item);
  //   navigateTo(context, ItemLoaderScreen.route,
  //       queryParams: {"id": item.id.toString()}, arguments: item

  //       // item not sending because some data missing for view, will use getItem from the navigateTo page
  //       );
  // }

  static showSnackBar(BuildContext context, String message,
      {SnackBarAction? action}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: BasicColors.kDarkBlue,
        action: action,
        content: Row(
          children: [
            Flexible(
              child: Container(
                child: Text(
                  message,
                  maxLines: 2,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .apply(color: Colors.white),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        )));
  }
}
