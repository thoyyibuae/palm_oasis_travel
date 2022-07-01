import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:downloads_path_provider_28/downloads_path_provider_28.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:tutvideo/models/ResponseModels/get_package_details.dart';
import 'package:tutvideo/models/ResponseModels/get_packages.dart';
import 'package:tutvideo/theme/basic_colors.dart';
import 'package:tutvideo/utils/helpers/basic_screen.dart';
import 'package:tutvideo/utils/helpers/no_items_found.dart';
import 'package:tutvideo/utils/helpers/sab_switcher.dart';
import 'package:tutvideo/utils/helpers/sabt.dart';
import 'package:tutvideo/utils/services/rest_api_service.dart';
import 'package:easy_localization/easy_localization.dart';
import 'dart:isolate';
import 'dart:ui';
import 'package:device_info/device_info.dart';
import 'package:permission_handler/permission_handler.dart';

import '../utils/helpers/screen_size.dart';

class PackageScreen extends StatefulWidget {
  final Package package;
  const PackageScreen({Key? key, required this.package}) : super(key: key);

  @override
  State<PackageScreen> createState() => _PackageScreenState();
}

String? _taskId;

class _PackageScreenState extends State<PackageScreen> {
  bool _loading = true;
  PackageDetails? _packageDetails;
  ReceivePort _port = ReceivePort();
  int? _progress;
  TargetPlatform? _platform;

  @override
  void initState() {
    Future.delayed(Duration.zero, _getPackageDetails);
    super.initState();
    IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    _port.listen((dynamic data) {
      String id = data[0];
      DownloadTaskStatus status = data[1];
      int progress = data[2];
      log('$progress %');
      // if (status.value == 3) {
      //   Future.delayed(Duration.zero, () {
      //     log('completed');
      //     if (_taskId != null) FlutterDownloader.open(taskId: _taskId!);
      //   });
      // }
      setState(() {
        _progress = progress;
      });
    });

    FlutterDownloader.registerCallback(downloadCallback);
  }

  @pragma('vm:entry-point')
  static void downloadCallback(
      String id, DownloadTaskStatus status, int progress) {
    final SendPort? send =
        IsolateNameServer.lookupPortByName('downloader_send_port');
    send?.send([id, status, progress]);
  }

  @override
  void dispose() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _platform = Theme.of(context).platform;

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            // backgroundColor: _packageDetails == null
            //     ? Theme.of(context).appBarTheme.backgroundColor
            //     : Colors.transparent,
            // elevation: 0,
            // floating: false,
            expandedHeight: 185,

            pinned: true,
            // automaticallyImplyLeading: false,

            flexibleSpace: _packageDetails == null
                ? buildTitleImage(context)
                : SABSwitcher(
                    fromChild: SizedBox(
                        width: double.infinity,
                        child: buildTitleImage(context)),
                    toChild: SizedBox(
                      width: double.infinity,
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl: _packageDetails!.packageImageHeader,
                        placeholder: (_, __) => SizedBox.shrink(),
                        errorWidget: (_, __, ___) => SafeArea(
                            child: Center(
                                child: Text(
                          widget.package.name,
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.apply(color: Colors.white),
                        ))),
                      ),
                    ),
                  ),
          ),
          if (_packageDetails != null)
            SliverPadding(
              padding: const EdgeInsets.all(8.0),
              sliver: SliverToBoxAdapter(
                child: HtmlWidget(
                  "${_packageDetails!.overview}",
                  textStyle: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            ),
          if (_packageDetails?.sliders.isNotEmpty ?? false)
            SliverToBoxAdapter(
              child: CarouselSlider.builder(
                itemCount: _packageDetails!.sliders.length,
                itemBuilder:
                    (BuildContext context, int itemIndex, int pageViewIndex) {
                  final slider = _packageDetails!.sliders[itemIndex];
                  return CachedNetworkImage(
                      // height: 400,
                      width: ScreenSize.width(context),
                      fit: BoxFit.cover,
                      imageUrl: slider.image,
                      placeholder: (_, __) {
                        // return Icon(Icons.abc);
                        return BasicScreen.buildShimmer(
                            true, buildTitleImage(context));
                      },
                      errorWidget: (_, __, ___) => SizedBox.shrink());
                },
                options: CarouselOptions(autoPlay: true, viewportFraction: 1),
              ),
            ),

          SliverPadding(
            padding: const EdgeInsets.all(8.0),
            sliver: SliverList(
                delegate: SliverChildListDelegate(
              _loading
                  ? [
                      Container(
                          height: 100,
                          alignment: Alignment.center,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                          ))
                    ]
                  : _packageDetails == null
                      ? [NoItemsFound()]
                      : [
                          SizedBox(
                            height: 10,
                          ),
                          _buildBulletPoints(_packageDetails!.inclusions, true),

                          SizedBox(
                            height: 10,
                          ),
                          _buildBulletPoints(
                              _packageDetails!.exclusions, false),
                          SizedBox(
                            height: 10,
                          ),
                          CachedNetworkImage(
                            imageUrl: _packageDetails!.map,
                            errorWidget: (_, __, ___) => SizedBox.shrink(),
                          ),

                          BasicScreen.buildSectionHeader(
                              "flightDetails", context),

                          // CachedNetworkImage(imageUrl: _packageDetails.)
                          _buildFlightDetails(),
                          SizedBox(
                            height: 10,
                          ),
                          BasicScreen.buildSectionHeader(
                              "transferDetails", context),
                          _buildTransferDetails(),
                          SizedBox(
                            height: 10,
                          ),
                          BasicScreen.buildSectionHeader(
                              "yourHolidayItinerary", context),
                          _buildItineraryDetails(),
                          SizedBox(
                            height: 10,
                          ),
                          BasicScreen.buildSectionHeader(
                              "yourHolidayItinerary", context),

                          HtmlWidget(_packageDetails!.cancellationPolicy),

                          _progress != null
                              ? _progress == 100
                                  ? ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        side: BorderSide(
                                            color:
                                                Theme.of(context).primaryColor),
                                        primary: Theme.of(context).primaryColor,
                                      ),
                                      onPressed: () {
                                        if (_taskId != null)
                                          FlutterDownloader.open(
                                              taskId: _taskId!);
                                      },
                                      child: Text('openPdf').tr(),
                                    )
                                  : LinearPercentIndicator(
                                      // width: double.maxFinite,
                                      lineHeight: kMinInteractiveDimension,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 6),

                                      percent: _progress! / 100,
                                      center: Text(
                                        '$_progress%',
                                        style: Theme.of(context)
                                            .textTheme
                                            .button
                                            ?.apply(
                                                color: Theme.of(context)
                                                    .primaryColorDark),
                                      ),
                                      isRTL:
                                          context.locale.languageCode == 'ar',
                                      barRadius: Radius.circular(5),

                                      backgroundColor:
                                          Theme.of(context).primaryColorLight,
                                      progressColor:
                                          Theme.of(context).primaryColor,
                                    )
                              : ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    // side: BorderSide(
                                    //     color: Theme.of(context).primaryColor),
                                    textStyle: Theme.of(context)
                                        .textTheme
                                        .button
                                        ?.apply(
                                            color: Theme.of(context)
                                                .primaryColorDark),
                                    primary:
                                        Theme.of(context).primaryColorLight,
                                  ),
                                  onPressed: () async {
                                    setState(() => _progress = 0);
                                    final _permissionReady =
                                        await _checkPermission();

                                    if (_permissionReady) {
                                      final downloadsDirectory =
                                          await DownloadsPathProvider
                                              .downloadsDirectory;
                                      if (downloadsDirectory == null) {
                                        BasicScreen.showErrorSnackBar(context,
                                            'Download directory not found');
                                        return;
                                      }
                                      try {
                                        _taskId =
                                            await FlutterDownloader.enqueue(
                                          url: _packageDetails!.pdf,
                                          savedDir: downloadsDirectory.path,
                                          saveInPublicStorage: true,
                                          showNotification:
                                              true, // show download progress in status bar (for Android)
                                          openFileFromNotification:
                                              true, // click on notification to open downloaded file (for Android)
                                        );
                                      } catch (e) {
                                        print(e);
                                      }
                                    }
                                    // else
                                    //   setState(() => _progress = null);
                                  },
                                  child: Text("downloadPdf",
                                          style: Theme.of(context)
                                              .textTheme
                                              .button
                                              ?.apply(
                                                  color: Theme.of(context)
                                                      .primaryColor))
                                      .tr()),
                          // _packageDetails.days.first.
                        ],
            )),
          )
          // Text(package.name)
          // Hero(
          //   tag: package.image,
          //   child: CachedNetworkImage(
          //     imageUrl: package.image,
          //     cacheKey: package.image,
          //     errorWidget: (_, __, ___) => SizedBox.shrink(),
          //   ),
          // ),
        ],
      ),
      // CustomScrollView(
      //   slivers: [
      //     SliverAppBar(
      //         expandedHeight: 220,
      //         flexibleSpace:
      //             //  Hero(
      //             //   tag: package.image,
      //             //   child:
      //             FlexibleSpaceBar(
      //           background: Hero(
      //             tag: widget.package.image,
      //             child: CachedNetworkImage(
      //               imageUrl: _packageDetails?.packageImageHeader != null
      //                   ? _packageDetails!.packageImageHeader
      //                   : widget.package.image,
      //               cacheKey: _packageDetails?.packageImageHeader != null
      //                   ? _packageDetails!.packageImageHeader
      //                   : widget.package.image,
      //               fit: BoxFit.fitWidth,
      //               errorWidget: (_, __, ___) => Container(
      //                 alignment: Alignment.center,
      //                 height: 220,
      //                 child: Row(
      //                   mainAxisAlignment: MainAxisAlignment.center,
      //                   children: [
      //                     Text(
      //                       widget.package.name,
      //                       style: Theme.of(context).textTheme.headlineMedium,
      //                     ),
      //                   ],
      //                 ),
      //               ),
      //               placeholder: (_, __) {
      //                 return BasicScreen.buildShimmer(
      //                     true,
      //                     Container(
      //                       height: 220,
      //                       width: double.maxFinite,
      //                     ));
      //               },
      //             ),
      //           ),
      //           // ),
      //         )),
      //     SliverPadding(
      //       padding: const EdgeInsets.all(8.0),
      //       sliver: SliverList(
      //           delegate: SliverChildListDelegate(
      //         _loading
      //             ? [CircularProgressIndicator()]
      //             : _packageDetails == null
      //                 ? [NoItemsFound()]
      //                 : [
      //                     HtmlWidget(
      //                       "${_packageDetails!.overview}",
      //                       textStyle: Theme.of(context).textTheme.bodyLarge,
      //                     ),
      //                     SizedBox(
      //                       height: 10,
      //                     ),
      //                     // Text(
      //                     //   _packageDetails!.pdf,
      //                     //   style: Theme.of(context)
      //                     //       .textTheme
      //                     //       .subtitle1
      //                     //       ?.apply(color: Colors.grey),
      //                     // ).tr(),

      //                     Text(
      //                       'yourDestination',
      //                       style: Theme.of(context)
      //                           .textTheme
      //                           .subtitle1
      //                           ?.apply(color: Colors.grey),
      //                     ).tr(),
      //                     SizedBox(
      //                       height: 5,
      //                     ),
      //                     CachedNetworkImage(imageUrl: _packageDetails!.map),
      //                     SizedBox(
      //                       height: 10,
      //                     ),
      //                     _buildBulletPoints(_packageDetails!.inclusions, true),
      //                     SizedBox(
      //                       height: 10,
      //                     ),
      //                     _buildBulletPoints(
      //                         _packageDetails!.exclusions, false),
      //                     BasicScreen.buildSectionHeader("flightDetails", context),

      //                     // CachedNetworkImage(imageUrl: _packageDetails.)
      //                     _buildFlightDetails(),
      //                     SizedBox(
      //                       height: 10,
      //                     ),
      //                     BasicScreen.buildSectionHeader("transferDetails", context),
      //                     _buildTransferDetails(),
      //                     SizedBox(
      //                       height: 10,
      //                     ),
      //                     BasicScreen.buildSectionHeader("yourHolidayItinerary", context),
      //                     _buildItineraryDetails(),
      //                     SizedBox(
      //                       height: 10,
      //                     ),
      //                     BasicScreen.buildSectionHeader("yourHolidayItinerary", context),

      //                     HtmlWidget(_packageDetails!.cancellationPolicy),

      //                     _progress != null
      //                         ? _progress == 100
      //                             ? ElevatedButton(
      //                                 style: ElevatedButton.styleFrom(
      //                                   side: BorderSide(
      //                                       color:
      //                                           Theme.of(context).primaryColor),
      //                                   primary: Theme.of(context).primaryColor,
      //                                 ),
      //                                 onPressed: () {
      //                                   if (_taskId != null)
      //                                     FlutterDownloader.open(
      //                                         taskId: _taskId!);
      //                                 },
      //                                 child: Text('openPdf').tr(),
      //                               )
      //                             : LinearPercentIndicator(
      //                                 // width: double.maxFinite,
      //                                 lineHeight: kMinInteractiveDimension,
      //                                 padding: const EdgeInsets.symmetric(
      //                                     vertical: 6),

      //                                 percent: _progress! / 100,
      //                                 center: Text(
      //                                   '$_progress%',
      //                                   style: Theme.of(context)
      //                                       .textTheme
      //                                       .button
      //                                       ?.apply(
      //                                           color: Theme.of(context)
      //                                               .primaryColorDark),
      //                                 ),
      //                                 isRTL:
      //                                     context.locale.languageCode == 'ar',
      //                                 barRadius: Radius.circular(5),

      //                                 backgroundColor:
      //                                     Theme.of(context).primaryColorLight,
      //                                 progressColor:
      //                                     Theme.of(context).primaryColor,
      //                               )
      //                         : ElevatedButton(
      //                             style: ElevatedButton.styleFrom(
      //                               // side: BorderSide(
      //                               //     color: Theme.of(context).primaryColor),
      //                               textStyle: Theme.of(context)
      //                                   .textTheme
      //                                   .button
      //                                   ?.apply(
      //                                       color: Theme.of(context)
      //                                           .primaryColorDark),
      //                               primary:
      //                                   Theme.of(context).primaryColorLight,
      //                             ),
      //                             onPressed: () async {
      //                               setState(() => _progress = 0);
      //                               final _permissionReady =
      //                                   await _checkPermission();

      //                               if (_permissionReady) {
      //                                 final downloadsDirectory =
      //                                     await DownloadsPathProvider
      //                                         .downloadsDirectory;
      //                                 if (downloadsDirectory == null) {
      //                                   BasicScreen.showErrorSnackBar(context,
      //                                       'Download directory not found');
      //                                   return;
      //                                 }
      //                                 try {
      //                                   _taskId =
      //                                       await FlutterDownloader.enqueue(
      //                                     url: _packageDetails!.pdf,
      //                                     savedDir: downloadsDirectory.path,
      //                                     saveInPublicStorage: true,
      //                                     showNotification:
      //                                         true, // show download progress in status bar (for Android)
      //                                     openFileFromNotification:
      //                                         true, // click on notification to open downloaded file (for Android)
      //                                   );
      //                                 } catch (e) {
      //                                   print(e);
      //                                 }
      //                               }
      //                               // else
      //                               //   setState(() => _progress = null);
      //                             },
      //                             child: Text("downloadPdf",
      //                                     style: Theme.of(context)
      //                                         .textTheme
      //                                         .button
      //                                         ?.apply(
      //                                             color: Theme.of(context)
      //                                                 .primaryColor))
      //                                 .tr()),
      //                     // _packageDetails.days.first.
      //                   ],
      //       )),
      //     )
      //     // Text(package.name)
      //     // Hero(
      //     //   tag: package.image,
      //     //   child: CachedNetworkImage(
      //     //     imageUrl: package.image,
      //     //     cacheKey: package.image,
      //     //     errorWidget: (_, __, ___) => SizedBox.shrink(),
      //     //   ),
      //     // ),
      //   ],
      // ),
    );
  }

  CachedNetworkImage buildTitleImage(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: widget.package.image,
      cacheKey: widget.package.image,
      fit: BoxFit.cover,
      errorWidget: (_, __, ___) => Container(
        alignment: Alignment.center,
        // height: _packageDetails == null ? 220 : null,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.package.name,
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium
                  ?.apply(color: Colors.white),
            ),
          ],
        ),
      ),
      placeholder: (_, __) {
        return BasicScreen.buildShimmer(
            true,
            Container(
              height: 220,
              width: double.maxFinite,
            ));
      },
    );
  }

  Widget _buildItineraryDetails() {
    List<TableRow> _list = [];
    for (var i = 0; i < (_packageDetails?.days.length ?? 0); i++) {
      final day = _packageDetails!.days[i];
      _list.add(TableRow(
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey))),
        children: [
          Container(
            margin: const EdgeInsets.all(30.0),
            color: BasicColors.kDarkBlue,
            padding: const EdgeInsets.all(10.0),
            child: Text(
              "${'day'.tr()} ${i + 1}",
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.apply(color: Colors.white),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(day.dayTitle),
                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: HtmlWidget(day.dayDescription),
                )
              ],
            ),
          ),
        ],
      ));
    }
    return Table(
      // border: TableBorder.all(),
      children: _list,
      columnWidths: {
        // 0: FlexColumnWidth(1),
        1: FlexColumnWidth(2),
        // 2: FlexColumnWidth(2)
      },
    );
  }

  Widget _buildTransferDetails() {
    List<TableRow> _list = [
      TableRow(
          decoration: BoxDecoration(color: BasicColors.kDarkBlue),
          children: [
            Container(
              padding: const EdgeInsets.all(3.0),
              alignment: Alignment.center,
              child: Text('type',
                  style: TextStyle(
                    color: Colors.white,
                  )).tr(),
            ),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(3.0),
              child: Text("pickup",
                  style: TextStyle(
                    color: Colors.white,
                  )).tr(),
            ),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(3.0),
              child: Text("dropoff",
                  style: TextStyle(
                    color: Colors.white,
                  )).tr(),
            ),
          ])
    ];
    _list.addAll(_packageDetails!.transfers
        .map((transfer) => TableRow(
              // mainAxisAlignment: MainAxisAlignment.start,
              // mainAxisSize: MainAxisSize.min,
              // crossAxisAlignment: CrossAxisAlignment.end,

              children: [
                // Flexible(
                //   child:
                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Text("${transfer.type}"),
                ),
                // ),
                // Text(flight.departureTo),
                // Flexible(
                //     flex: 2,
                //     child:
                // TableCell(
                //     verticalAlignment: TableCellVerticalAlignment.fill,
                //     child: Container(
                //       // color: Colors.amber,
                //       child: CachedNetworkImage(
                //           errorWidget: (context, url, error) => Icon(
                //                 Icons.flight,
                //                 color: BasicColors.kDarkBlue,
                //               ),
                //           width: 45,
                //           imageUrl: flight.segments.icon),
                //     )),
                // Flexible(
                //   flex: 2,
                //   child:
                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Text(transfer.pickupLocation),
                ),
                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Text(transfer.dropOffLocation),
                )
                // )
                ,
                // ),

                // Text(flight.segments.arrivalDate)

                // Column(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,mainAxisSize: MainAxisSize.min,
                // children: flight.segments.,
                // )
              ],
            ))
        .toList());
    return Table(
      border: TableBorder.all(),
      children: _list,
      columnWidths: {
        0: FlexColumnWidth(1),
        1: FlexColumnWidth(2),
        2: FlexColumnWidth(2)
      },
    );
  }

  Widget _buildFlightDetails() {
    List<TableRow> _list = [
      TableRow(
          decoration: BoxDecoration(color: BasicColors.kDarkBlue),
          children: [
            Container(
              padding: const EdgeInsets.all(3.0),
              alignment: Alignment.center,
              child: Text('destination',
                  style: TextStyle(
                    color: Colors.white,
                  )).tr(),
            ),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(3.0),
              child: Text("flight",
                  style: TextStyle(
                    color: Colors.white,
                  )).tr(),
            ),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(3.0),
              child: Text("departure",
                  style: TextStyle(
                    color: Colors.white,
                  )).tr(),
            ),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(3.0),
              child: Center(
                  child: Text("arrival",
                      style: TextStyle(
                        color: Colors.white,
                      )).tr()),
            )
          ])
    ];
    _list.addAll(_packageDetails!.flights
        .map((flight) => TableRow(
              // mainAxisAlignment: MainAxisAlignment.start,
              // mainAxisSize: MainAxisSize.min,
              // crossAxisAlignment: CrossAxisAlignment.end,

              children: [
                // Flexible(
                //   child:
                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child:
                      Text("${flight.departureFrom} - ${flight.departureTo}"),
                ),
                // ),
                // Text(flight.departureTo),
                // Flexible(
                //     flex: 2,
                //     child:
                TableCell(
                    verticalAlignment: TableCellVerticalAlignment.fill,
                    child: Container(
                      // color: Colors.amber,
                      child: CachedNetworkImage(
                          errorWidget: (context, url, error) => Icon(
                                Icons.flight,
                                color: BasicColors.kDarkBlue,
                              ),
                          width: 45,
                          imageUrl: flight.segments.icon),
                    )),
                // Flexible(
                //   flex: 2,
                //   child:
                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Text(flight.segments.departureFrom),
                ),
                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Text(flight.segments.arrivalTo),
                )
                // )
                ,
                // ),

                // Text(flight.segments.arrivalDate)

                // Column(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,mainAxisSize: MainAxisSize.min,
                // children: flight.segments.,
                // )
              ],
            ))
        .toList());
    return Table(
        border: TableBorder.all(),
        columnWidths: {
          0: FlexColumnWidth(2),
          1: FlexColumnWidth(1),
          2: FlexColumnWidth(3),
          3: FlexColumnWidth(3)
        },
        children: _list);
  }

  Column _buildBulletPoints(List details, bool include) {
    List<Widget> _children = [
      BasicScreen.buildSectionHeader(
          include ? "whatsIncluded" : "whatsNotIncluded", context)
    ];

    _children.addAll(details
        .map((e) => Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  include
                      ? Icon(
                          Icons.check,
                          color: BasicColors.kGreen,
                          size: 20,
                        )
                      : Icon(
                          Icons.close,
                          color: BasicColors.kRed,
                          size: 20,
                        ),
                  SizedBox(
                    width: 5,
                  ),
                  Expanded(
                      child: Text(
                    e.value,
                  )),
                ],
              ),
            ))
        .toList());
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: _children);
  }

  void _getPackageDetails() async {
    try {
      final value = await RestApiService(context: context).packageDetails(
          widget.package.id, widget.package.packageHotels.first.hotelId);
      setState(() {
        _loading = false;
        _packageDetails = value;
      });
    } catch (e) {
      if (mounted) {
        BasicScreen.showErrorSnackBar(context, e.toString(),
            action:
                SnackBarAction(label: 'retry', onPressed: _getPackageDetails));
        setState(() {
          _loading = false;
        });
      }
    }
  }

  Future<bool> _checkPermission() async {
    if (Platform.isIOS) return true;

    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    if (_platform == TargetPlatform.android &&
        androidInfo.version.sdkInt <= 28) {
      final status = await Permission.storage.status;
      if (status != PermissionStatus.granted) {
        final result = await Permission.storage.request();
        if (result == PermissionStatus.granted) {
          return true;
        }
      } else {
        return true;
      }
    } else {
      return true;
    }
    return false;
  }
}
