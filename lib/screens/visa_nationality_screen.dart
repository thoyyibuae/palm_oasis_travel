import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:tutvideo/models/ResponseModels/get_visa_nationalities.dart';
import 'package:tutvideo/models/ResponseModels/get_visa_types.dart';
import 'package:tutvideo/screens/visa_requirements_screen.dart';
import 'package:tutvideo/screens/visa_screen.dart';
import 'package:tutvideo/utils/helpers/no_items_found.dart';
import 'package:tutvideo/utils/services/rest_api_service.dart';

class VisaNationalityScreen extends StatefulWidget {
  final VisaType visaType;
  const VisaNationalityScreen({required this.visaType, Key? key})
      : super(key: key);

  @override
  State<VisaNationalityScreen> createState() => _VisaNationalityScreenState();
}

class _VisaNationalityScreenState extends State<VisaNationalityScreen> {
  List<VisaNationality>? _visaNationalities;
  VisaNationality? _visaNationality;
  @override
  void initState() {
    Future.delayed(
        Duration.zero,
        () => RestApiService(context: context).visaNationalities.then((value) {
              setState(() => _visaNationalities = value);
            }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('selectNationality').tr()),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: (() => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => VisaRequirementScreen(
                    visaNationality: _visaNationality!,
                    visaType: widget.visaType),
              ))),
          icon: Icon(Icons.navigate_next),
          label: Text('proceed'.tr())),
      body: _visaNationalities == null
          ? Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            )
          : _visaNationalities!.isEmpty
              ? NoItemsFound()
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      DropdownSearch<VisaNationality>(
                        mode: Mode.BOTTOM_SHEET,
                        showSearchBox: true,
                        dropdownSearchDecoration: InputDecoration(
                          labelText: "country".tr(),
                          hintText: "selectYourNationality".tr(),
                        ),
                        onFind: (String? filter) async {
                          return (filter == null
                                  ? _visaNationalities
                                  : _visaNationalities!
                                      .where((element) => element.name
                                          .toLowerCase()
                                          .startsWith(filter.toLowerCase()))
                                      .toList()) ??
                              [];
                        },
                        itemAsString: (VisaNationality? u) => u?.name ?? "",
                        onChanged: (VisaNationality? data) => setState(() {
                          _visaNationality = data;
                        }),
                        // mode: Mode.BOTTOM_SHEET,
                        // showSearchBox: true,
                        // showSelectedItems: true,
                        // items: _visaNationalities,
                        // itemAsString: (visaNationality) =>
                        //     visaNationality?.name ?? "",
                        // dropdownSearchDecoration: InputDecoration(
                        //   labelText: "country",
                        //   hintText: "selectYourNationality",
                        // ),
                        // // popupItemDisabled: (String s) => s.startsWith('I'),
                        // onChanged: print,
                        // selectedItem: "Brazil",
                      ),
                      buildNationality()
                    ],
                  )),
    );
  }

  Widget buildNationality() {
    return _visaNationality == null
        ? SizedBox.shrink()
        : Column(
            children: [
              CachedNetworkImage(
                imageUrl: _visaNationality!.image,
                errorWidget: (_, error, __) {
                  log(error);
                  return SizedBox.shrink();
                },
              ),
              if (_visaNationality!.text != null)
                HtmlWidget(_visaNationality!.text ?? ""),
            ],
          );
  }
}
