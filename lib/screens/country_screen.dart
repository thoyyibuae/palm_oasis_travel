import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:tutvideo/models/ResponseModels/get_country_details.dart';
import 'package:tutvideo/utils/helpers/basic_screen.dart';
import 'package:tutvideo/utils/helpers/no_items_found.dart';
import 'package:tutvideo/utils/services/rest_api_service.dart';
import 'package:easy_localization/easy_localization.dart';

import '../models/ResponseModels/country.dart';
import '../models/ResponseModels/get_country_details.dart';

class CountryScreen extends StatefulWidget {
  final Country country;
  const CountryScreen({Key? key, required this.country}) : super(key: key);

  @override
  State<CountryScreen> createState() => _CountryScreenState();
}

class _CountryScreenState extends State<CountryScreen> {
  bool _loading = true;
  CountryDetails? _countryDetails;

  @override
  void initState() {
    Future.delayed(Duration.zero, _getCountryDetails);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: true,
            expandedHeight: 210,
            backgroundColor: Colors.transparent,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: false,
              titlePadding: const EdgeInsets.all(5),
              title: _countryDetails == null
                  ? null
                  : CachedNetworkImage(
                      imageUrl: _countryDetails!.flag,
                      height: 25,
                      width: 50,
                    ),
              background: Hero(
                tag: widget.country.image,
                child: _countryDetails == null
                    ? buildTitleImage(context)
                    : CachedNetworkImage(
                        fit: BoxFit.cover,
                        placeholder: (_, __) => buildTitleImage(context),
                        errorWidget: (_, __, ___) => Stack(
                              children: [
                                Positioned.fill(
                                    child: Container(
                                  alignment: Alignment.center,
                                  color: Theme.of(context).primaryColor,
                                  child: Text(
                                    _countryDetails!.name,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineLarge
                                        ?.apply(color: Colors.white),
                                  ),
                                )),
                                Positioned.fill(
                                    child: Align(
                                  alignment: Alignment.bottomRight,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: RichText(
                                        text: TextSpan(
                                      text: 'aed'.tr(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall
                                          ?.apply(color: Colors.white),
                                      children: [
                                        TextSpan(
                                          text:
                                              ' ${_countryDetails!.startPrice.replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineMedium
                                              ?.apply(color: Colors.white),
                                        )
                                      ],
                                    )),
                                  ),
                                ))
                              ],
                            ),
                        cacheKey: _countryDetails!.image,
                        imageUrl: _countryDetails!.image),
              ),
            ),
            // ),
            // ),
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
                  : _countryDetails == null
                      ? [NoItemsFound()]
                      : [
                          if (_countryDetails!.intro != null)
                            HtmlWidget(
                              "${_countryDetails!.intro}",
                              textStyle: Theme.of(context).textTheme.bodyLarge,
                            ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                  "${'capital'.tr()} : ${_countryDetails!.capital}"),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                  "${'currency'.tr()} : ${_countryDetails!.currency}"),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text("${_countryDetails!.convertCurrency}"),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                              "${'officialLanguages'.tr()} : ${_countryDetails!.officialLang}"),
                          SizedBox(
                            height: 10,
                          ),
                          HtmlWidget(_countryDetails!.visaInfo),
                        ],
            )),
          )
        ],
      ),
    );
  }

  CachedNetworkImage buildTitleImage(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: widget.country.image,
      cacheKey: widget.country.image,
      fit: BoxFit.cover,
      errorWidget: (_, __, ___) => Container(
        alignment: Alignment.center,
        // height: _countryDetails == null ? 220 : null,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.country.name,
              style: Theme.of(context).textTheme.headlineMedium,
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

  void _getCountryDetails() async {
    try {
      final value = await RestApiService(context: context)
          .countryDetails(widget.country.id);
      setState(() {
        _loading = false;
        _countryDetails = value;
      });
    } catch (e) {
      if (mounted) {
        BasicScreen.showErrorSnackBar(context, e.toString(),
            action:
                SnackBarAction(label: 'retry', onPressed: _getCountryDetails));
        setState(() {
          _loading = false;
        });
      }
    }
  }
}
