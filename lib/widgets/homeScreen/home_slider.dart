import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tutvideo/models/ResponseModels/get_sliders.dart';
import 'package:tutvideo/utils/helpers/basic_screen.dart';
import 'package:tutvideo/utils/services/rest_api_service.dart';

import '../../utils/helpers/screen_size.dart';

class HomeSlider extends StatefulWidget {
  const HomeSlider({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeSlider> createState() => _HomeSliderState();
}

class _HomeSliderState extends State<HomeSlider> {
  List<SliderData> _sliders = [];

  @override
  void initState() {
    Future.delayed(
        Duration.zero,
        () => RestApiService(context: context).sliders.then((value) {
              setState((() => _sliders = value ?? []));
            }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: _sliders.isEmpty ? 3 : _sliders.length,
      itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) {
        if (_sliders.isEmpty) return buildPlaceHolder(context);

        final slider = _sliders[itemIndex];
        return CachedNetworkImage(
          height: 400,
          width: ScreenSize.width(context),
          imageUrl: slider.image,
          placeholder: (_, __) {
            // return Icon(Icons.abc);
            return buildPlaceHolder(context);
          },
        );
      },
      options: CarouselOptions(autoPlay: true, viewportFraction: 1),
    );
  }

  Shimmer buildPlaceHolder(BuildContext context) {
    return BasicScreen.buildShimmer(
        true,
        Container(
          height: 400,
          width: double.maxFinite,
          // width: ScreenSize.width(context),
        ));
  }
}
