import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tutvideo/models/ResponseModels/get_visa_types.dart';
import 'package:tutvideo/screens/visa_nationality_screen.dart';
import 'package:tutvideo/utils/helpers/basic_screen.dart';
import 'package:tutvideo/utils/services/rest_api_service.dart';

class VisaScreen extends StatelessWidget {
  // final Visa blog;
  const VisaScreen({
    Key? key,
    // required this.blog,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBodyBehindAppBar: true,
      appBar: AppBar(
        // backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('selectVisaType'.tr()),
      ),
      body: VisaTypesSection(),

      //  SingleChildScrollView(
      //     padding: EdgeInsets.all(15),
      //     child: Column(
      //       mainAxisSize: MainAxisSize.min,
      //       mainAxisAlignment: MainAxisAlignment.start,
      //       crossAxisAlignment: CrossAxisAlignment.start,
      //       children: [
      //         // BasicScreen.buildSectionHeader('visaTypes', context),
      //         VisaTypesSection(),
      //         SizedBox(
      //           height: 10,
      //         ),
      //         // City(
      //         //   image: ,
      //         // )
      //         // if (widget.blog.image.isNotEmpty)
      //         //   Hero(
      //         //     tag: widget.blog.image,
      //         //     child: CachedNetworkImage(
      //         //       cacheKey: widget.blog.image,
      //         //       imageUrl: widget.blog.image,
      //         //       placeholder: (_, __) => SizedBox.shrink(),
      //         //       errorWidget: (_, __, ___) => SizedBox.shrink(),
      //         //     ),
      //         //   ),
      //         // Padding(
      //         //   padding: const EdgeInsets.all(8.0),
      //         //   child: Hero(
      //         //     tag: widget.blog.name,
      //         //     child: Text(
      //         //       widget.blog.name,
      //         //       style: Theme.of(context).textTheme.headline6,
      //         //     ),
      //         //   ),
      //         // ),
      //         // Padding(
      //         //   padding: const EdgeInsets.only(left: 15.0, right: 15, top: 10),
      //         //   child: HtmlWidget(widget.blog.info),
      //         // ),
      //       ],
      //     ))

      //  Text(widget.blog.info),
    );
  }
}

class VisaTypesSection extends StatefulWidget {
  const VisaTypesSection({Key? key}) : super(key: key);

  @override
  State<VisaTypesSection> createState() => _VisaTypesSectionState();
}

class _VisaTypesSectionState extends State<VisaTypesSection> {
  List<VisaType>? _visaTypes;

  @override
  void initState() {
    Future.delayed(
        Duration.zero,
        () => RestApiService(context: context).visaTypes.then((visaTypes) {
              setState(
                () => _visaTypes = visaTypes,
              );
            }));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      // padding: EdgeInsets.all(10),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: 20, crossAxisCount: 2, childAspectRatio: 1.1),
      itemCount: _visaTypes == null ? 5 : _visaTypes!.length,
      itemBuilder: (_, index) =>
          _buildTile(_visaTypes == null ? null : _visaTypes![index]),
    );
  }

  Widget _buildTile(VisaType? visaType) {
    return InkWell(
      highlightColor: Colors.grey,
      onTap: visaType == null
          ? null
          : () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => VisaNationalityScreen(visaType: visaType),
              )),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: visaType == null
                ? BasicScreen.buildShimmer(true, buildTileFrame())
                : CachedNetworkImage(
                    imageUrl: visaType.image,
                    imageBuilder: (_, imageProvider) {
                      return buildTileFrame(
                          imageProvider: imageProvider, visaType: visaType);
                    },
                    placeholder: (_, __) => BasicScreen.buildShimmer(
                        true, buildTileFrame(visaType: visaType)),
                    errorWidget: (_, error, __) {
                      log(error);
                      return buildTileFrame(visaType: visaType);
                    },
                  ),
          ),
          // SizedBox(
          //   height: 10,
          // ),
          visaType == null
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: BasicScreen.buildShimmer(true, _buildName()),
                )
              : _buildName(visaType.name)
        ],
      ),
    );
  }

  Widget buildTileFrame(
      {VisaType? visaType, ImageProvider<Object>? imageProvider}) {
    return Container(
      margin: const EdgeInsets.all(10),
      // height: 80,
      // width: 100,
      alignment: Alignment.center,
      child: imageProvider == null ? Icon(Icons.image) : null,
      decoration: BoxDecoration(
          color: imageProvider == null ? Colors.grey : null,
          image: imageProvider == null
              ? null
              : DecorationImage(image: imageProvider)),
    );
  }

  Widget _buildName([String? visaType]) => visaType == null
      ? Container(
          width: double.infinity,
          height: 15,
          color: Colors.black,
        )
      : Text(
          visaType,
          style: Theme.of(context).textTheme.button,
        );
}
