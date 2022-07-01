import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:tutvideo/models/ResponseModels/get_visa_nationalities.dart';
import 'package:tutvideo/models/ResponseModels/get_visa_types.dart';
import 'package:tutvideo/models/ResponseModels/get_visa_types.dart';
import 'package:tutvideo/screens/visa_screen.dart';
import 'package:tutvideo/utils/services/rest_api_service.dart';

import '../models/ResponseModels/get_visa_requirements.dart';
import '../theme/basic_colors.dart';
import '../utils/helpers/basic_screen.dart';
import 'visa_form_screen.dart';

class VisaRequirementScreen extends StatefulWidget {
  final VisaType visaType;
  final VisaNationality visaNationality;

  const VisaRequirementScreen(
      {required this.visaType, Key? key, required this.visaNationality})
      : super(key: key);

  @override
  State<VisaRequirementScreen> createState() => _VisaRequirementScreenState();
}

class _VisaRequirementScreenState extends State<VisaRequirementScreen> {
  VisaRequirements? _visaRequirement;

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      return RestApiService(context: context)
          .visaRequirements(widget.visaType.id, widget.visaNationality.id)
          .then((value) {
        setState(() {
          _visaRequirement = value;
          totalAmt = double.parse(_visaRequirement!.adultPrice.toString());
        });
      });
    });
    super.initState();
  }

  var _selectedAdult;
  var _selectedChild;
  var _selectedInfant;
  int _selectedAdultCount = 1;
  int _selectedChildCount = 0;
  int _selectedInfantCount = 0;
  int count = 1;
  double totalAmt = 0;
  List<int> _person = [0, 1, 2, 3];
  List<int> _personAdult = [1, 2, 3];
  var selectedPerson;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('visaRequirements').tr()),
      // floatingActionButton: FloatingActionButton.extended(
      //     onPressed: (() => Navigator.push(
      //         context,
      //         MaterialPageRoute(
      //           builder: (context) => VisaFormScreen(
      //               visaNationality: widget.visaNationality,
      //               visaType: widget.visaType),
      //         ))),
      //     icon: Icon(Icons.navigate_next),
      //     label: Text('proceed'.tr())),
      body: _visaRequirement == null
          ? Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            )
          : Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: MediaQuery.of(context).size.height / 1.2,
                  width: MediaQuery.of(context).size.width * 2,
                  // padding: const EdgeInsets.all(10.0),
                  child: Card(
                    elevation: 6,
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // HtmlWidget(_visaRequirement!.text ?? "")
                          Container(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: RichText(
                                text: TextSpan(
                                    text: '${"nationality".tr()} : ',
                                    style:
                                        Theme.of(context).textTheme.subtitle1,
                                    children: [
                                  TextSpan(
                                    text: widget.visaNationality.name,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6
                                        ?.apply(color: BasicColors.kDarkBlue),
                                  )
                                ])),
                          ),
                          // SizedBox(
                          //   height: 5,
                          // ),
                          Container(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: RichText(
                                text: TextSpan(
                                    text: '${"visaType".tr()} : ',
                                    style:
                                        Theme.of(context).textTheme.subtitle1,
                                    children: [
                                  TextSpan(
                                    text: widget.visaType.name,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6
                                        ?.apply(color: BasicColors.kDarkBlue),
                                  )
                                ])),
                          ),
                          // SizedBox(
                          //   height: 20,
                          // ),
                          Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: _buildBulletPoints(
                                  _visaRequirement!.requirements)),
                          Container(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: buildColonDetails(
                                attribute: "adultPrice".tr(),
                                value:
                                    '${_visaRequirement!.adultPrice} ${"AED".tr()}',
                                context: context),
                          ),

                          Container(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: buildColonDetails(
                                attribute: "childPrice".tr(),
                                value:
                                    '${_visaRequirement!.childPrice} ${"AED".tr()}',
                                context: context),
                          ),
                          Container(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: buildColonDetails(
                                attribute: "infantPrice".tr(),
                                value:
                                    '${_visaRequirement!.infantPrice} ${"AED".tr()}',
                                context: context),
                          ),
                          Container(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: buildColonDetails(
                                attribute: "processingTyme".tr(),
                                valueWidget: HtmlWidget(
                                    _visaRequirement!.processingTime),
                                context: context),
                          ),
                          Container(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: buildColonDetails(
                                attribute: "stayValidity".tr(),
                                valueWidget:
                                    HtmlWidget(_visaRequirement!.stayValidity),
                                context: context),
                          ),

                          Container(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: buildColonDetails(
                                attribute: "visaValidity".tr(),
                                valueWidget:
                                    HtmlWidget(_visaRequirement!.visaValidity),
                                context: context),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Expanded(
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              height: MediaQuery.of(context).size.height / 9,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 30.0),
                                height: MediaQuery.of(context).size.height / 9,

                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30.0)),
                                    shape: BoxShape.rectangle,
                                    border: Border.all(
                                      color: Colors.blue,
                                      width: 3,
                                    )),
                                // decoration: BoxDecoration(
                                //   border: BoxBorder(
                                //
                                //   )
                                // ),
                                // height: MediaQuery.of(context).size.height,
                                // width: MediaQuery.of(context).size.width/1.3,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    // SizedBox(
                                    //   height: 20,
                                    // ),
                                    Container(
                                      padding: EdgeInsets.only(left: 30),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Expanded(child: Text("No.OF.Adults")),
                                          Expanded(
                                              child: Center(
                                            child: Container(
                                              height: 50,
                                              // margin: EdgeInsets.symmetric(horizontal: 10),
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10, vertical: 0),
                                              // decoration: BoxDecoration(
                                              //   color: Colors.transparent,
                                              //   borderRadius: BorderRadius.circular(40),
                                              //   border:
                                              //   Border.all(color: Colors.black38, width: 1),
                                              // ),
                                              child:
                                                  DropdownButtonHideUnderline(
                                                child: DropdownButton2(
                                                  isExpanded: true,
                                                  hint: Row(
                                                    children: const [
                                                      Expanded(
                                                        child: Text(
                                                          '1',
                                                          style: TextStyle(
                                                            fontSize: 17,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color: Colors.black,
                                                          ),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  items: ['1', '2', '3']
                                                      .map((item) =>
                                                          DropdownMenuItem<
                                                              String>(
                                                            value: item == null
                                                                ? '1'
                                                                : item,
                                                            child: Text(
                                                              item,
                                                              style:
                                                                  const TextStyle(
                                                                fontSize: 17,
                                                                // fontWeight: FontWeight.w500,
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                          ))
                                                      .toList(),
                                                  value: _selectedAdult,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      _selectedAdult =
                                                          value as String;

                                                      count > _selectedAdultCount
                                                          ? count = count -
                                                              _selectedAdultCount
                                                          : count =
                                                              _selectedAdultCount -
                                                                  count;


                                                      totalAmt = totalAmt -
                                                          double.parse(
                                                                  _selectedAdultCount
                                                                      .toString()) *
                                                              double.parse(
                                                                  _visaRequirement!
                                                                      .adultPrice
                                                                      .toString());
                                                      _selectedAdultCount =
                                                          int.parse(
                                                              _selectedAdult);
                                                      count = count +
                                                          _selectedAdultCount;

                                                      totalAmt = totalAmt +
                                                          double.parse(
                                                                  _selectedAdultCount
                                                                      .toString()) *
                                                              double.parse(
                                                                  _visaRequirement!
                                                                      .adultPrice
                                                                      .toString());
                                                    });
                                                  },
                                                  icon: const Icon(
                                                    Icons
                                                        .arrow_drop_down_outlined,
                                                  ),
                                                  iconSize: 35,

                                                  iconEnabledColor:
                                                      Colors.black,
                                                  
                                                  buttonPadding:
                                                      const EdgeInsets.only(
                                                          left: 14, right: 14),
                                                  buttonDecoration:
                                                      BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            14),
                                                    // border: Border(
                                                    //
                                                    // ),

                                                    color: Colors.white,
                                                  ),
                                                  buttonElevation: 0,
                                                  // itemHeight: 40,

                                                  itemPadding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 14),

                                                  dropdownDecoration:
                                                      BoxDecoration(
                                                    // border: BoxBorder(),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            14),
                                                    // color: Colors.redAccent,
                                                  ),
                                                  dropdownElevation: 1,
                                                  scrollbarRadius:
                                                      const Radius.circular(40),
                                                  scrollbarThickness: 6,

                                                  // offset: const Offset(0, 0),
                                                ),
                                              ),
                                            ),
                                          )),
                                        ],
                                      ),
                                    ),

                                    // SizedBox(
                                    //   height: 20,
                                    // ),
                                    Container(
                                      padding: EdgeInsets.only(left: 30),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Expanded(child: Text("No.OF.Child")),
                                          Expanded(
                                              child: Center(
                                            child: Container(
                                              height: 50,
                                              // margin: EdgeInsets.symmetric(horizontal: 10),
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10, vertical: 0),
                                              // decoration: BoxDecoration(
                                              //   color: Colors.transparent,
                                              //   borderRadius: BorderRadius.circular(40),
                                              //   border:
                                              //   Border.all(color: Colors.black38, width: 1),
                                              // ),
                                              child:
                                                  DropdownButtonHideUnderline(
                                                child: DropdownButton2(
                                                  isExpanded: true,
                                                  hint: Row(
                                                    children: const [
                                                      // SizedBox(
                                                      //   width: 4,
                                                      // ),
                                                      Expanded(
                                                        child: Text(
                                                          '0',
                                                          style: TextStyle(
                                                            fontSize: 17,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color: Colors.black,
                                                          ),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  items: ['0', '1', '2', '3']
                                                      .map((item) =>
                                                          DropdownMenuItem<
                                                              String>(
                                                            value: item == null
                                                                ? '1'
                                                                : item,
                                                            child: Text(
                                                              item,
                                                              style:
                                                                  const TextStyle(
                                                                fontSize: 17,
                                                                // fontWeight: FontWeight.w500,
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                          ))
                                                      .toList(),
                                                  value: _selectedChild,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      _selectedChild =
                                                          value as String;

                                                      count > _selectedChildCount
                                                          ? count = count -
                                                              _selectedChildCount
                                                          : count =
                                                              _selectedChildCount -
                                                                  count;
                                                      totalAmt = totalAmt -
                                                          double.parse(
                                                                  _selectedChildCount
                                                                      .toString()) *
                                                              double.parse(
                                                                  _visaRequirement!
                                                                      .childPrice
                                                                      .toString());
                                                      _selectedChildCount =
                                                          int.parse(
                                                              _selectedChild);
                                                      totalAmt = totalAmt +
                                                          double.parse(
                                                                  _selectedChildCount
                                                                      .toString()) *
                                                              double.parse(
                                                                  _visaRequirement!
                                                                      .childPrice
                                                                      .toString());
                                                      count = count +
                                                          _selectedChildCount;
                                                    });
                                                  },
                                                  icon: const Icon(
                                                    Icons
                                                        .arrow_drop_down_outlined,
                                                  ),
                                                  iconSize: 35,
                                                  iconEnabledColor:
                                                      Colors.black,

                                                  buttonPadding:
                                                      const EdgeInsets.only(
                                                          left: 14, right: 14),
                                                  buttonDecoration:
                                                      BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            14),
                                                    // border: Border(
                                                    //
                                                    // ),

                                                    color: Colors.white,
                                                  ),
                                                  buttonElevation: 0,
                                                  // itemHeight: 40,

                                                  itemPadding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 14),

                                                  dropdownDecoration:
                                                      BoxDecoration(
                                                    // border: BoxBorder(),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            14),
                                                    // color: Colors.redAccent,
                                                  ),
                                                  dropdownElevation: 1,
                                                  scrollbarRadius:
                                                      const Radius.circular(40),
                                                  scrollbarThickness: 6,

                                                  // offset: const Offset(0, 0),
                                                ),
                                              ),
                                            ),
                                          )),
                                        ],
                                      ),
                                    ),

                                    // SizedBox(
                                    //   height: 20,
                                    // ),
                                    Container(
                                      padding: EdgeInsets.only(left: 30),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Expanded(child: Text("No.OF.Infant")),
                                          Expanded(
                                              child: Center(
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 10,
                                              ),
                                              // decoration: BoxDecoration(
                                              //   color: Colors.transparent,
                                              //   borderRadius: BorderRadius.circular(40),
                                              //   border:
                                              //   Border.all(color: Colors.black38, width: 1),
                                              // ),
                                              child:
                                                  DropdownButtonHideUnderline(
                                                child: DropdownButton2(
                                                  isExpanded: true,
                                                  hint: Row(
                                                    children: const [
                                                      Expanded(
                                                        child: Text(
                                                          '0',
                                                          style: TextStyle(
                                                            fontSize: 17,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color: Colors.black,
                                                          ),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  items: ['0', '1', '2', '3']
                                                      .map((item) =>
                                                          DropdownMenuItem<
                                                              String>(
                                                            value: item == null
                                                                ? '1'
                                                                : item,
                                                            child: Text(
                                                              item,
                                                              style:
                                                                  const TextStyle(
                                                                fontSize: 17,
                                                                // fontWeight: FontWeight.w500,
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                          ))
                                                      .toList(),
                                                  value: _selectedInfant,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      _selectedInfant =
                                                          value as String;
                                                      count > _selectedInfantCount
                                                          ? count = count -
                                                              _selectedInfantCount
                                                          : count =
                                                              _selectedInfantCount -
                                                                  count;

                                                      totalAmt = totalAmt -
                                                          double.parse(
                                                                  _selectedInfantCount
                                                                      .toString()) *
                                                              double.parse(
                                                                  _visaRequirement!
                                                                      .infantPrice
                                                                      .toString());
                                                      _selectedInfantCount =
                                                          int.parse(
                                                              _selectedInfant);
                                                      totalAmt = totalAmt +
                                                          double.parse(
                                                                  _selectedInfantCount
                                                                      .toString()) *
                                                              double.parse(
                                                                  _visaRequirement!
                                                                      .infantPrice
                                                                      .toString());
                                                      count = count +
                                                          _selectedInfantCount;
                                                    });
                                                  },
                                                  icon: const Icon(
                                                    Icons
                                                        .arrow_drop_down_outlined,
                                                  ),
                                                  iconSize: 35,
                                                  iconEnabledColor:
                                                      Colors.black,

                                                  buttonPadding:
                                                      const EdgeInsets.only(
                                                          left: 14, right: 14),
                                                  buttonDecoration:
                                                      BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            14),
                                                    // border: Border(
                                                    //
                                                    // ),

                                                    color: Colors.white,
                                                  ),
                                                  buttonElevation: 0,
                                                  // itemHeight: 40,

                                                  itemPadding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 14),

                                                  dropdownDecoration:
                                                      BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            14),
                                                    // color: Colors.redAccent,
                                                  ),
                                                  dropdownElevation: 1,
                                                  scrollbarRadius:
                                                      const Radius.circular(40),
                                                  scrollbarThickness: 6,
                                                ),
                                              ),
                                            ),
                                          )),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),

                          Expanded(
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                // height: 100,
                                height: MediaQuery.of(context).size.height / 12,
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  // borderRadius: BorderRadius.only(
                                  //   topLeft: Radius.circular(25),
                                  //   topRight: Radius.circular(25),
                                  // ),
                                ),
                                // margin: EdgeInsets.only(
                                //   top: 10.0,
                                // ),
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: Column(
                                  // mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    // SizedBox(height: 1,),

                                    Container(
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            "$count PERSON",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      // mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Expanded(
                                            flex: 2,
                                            child: Text(
                                              "$totalAmt AED",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            )),
                                        Expanded(flex: 1, child: Container()),
                                        Expanded(
                                          flex: 2,
                                          child: TextButton(
                                              onPressed: () {
                                                Navigator.push(context, MaterialPageRoute
                                                  (builder: (context)=>

                                                VisaFormScreen(visaType: widget.visaType,
                                                    visaNationality: widget.visaNationality,
                                                personCount: count,)));
                                              },
                                              style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty
                                                        .resolveWith<Color>(
                                                  (Set<MaterialState> states) {
                                                    if (states.contains(
                                                        MaterialState.pressed))
                                                      return Theme.of(context)
                                                          .colorScheme
                                                          .primary
                                                          .withOpacity(0.5);
                                                    return Colors.blue;
                                                  },
                                                ),
                                              ),
                                              child: Text(
                                                "Apply Now",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              )),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: IconButton(
                                            icon: Icon(
                                              Icons.arrow_right_outlined,
                                              size: 35,
                                              color: Colors.white,
                                            ),
                                            onPressed: () {

                                              Navigator.push(context, MaterialPageRoute
                                                (builder: (context)=>

                                                  VisaFormScreen(visaType: widget.visaType,
                                                    visaNationality: widget.visaNationality,
                                                    personCount: count,)));
                                            },
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    margin: EdgeInsets.symmetric(horizontal: 20),
                  ),
                ),
              ],
            ),
    );
  }

  Widget buildColonDetails(
      {required String attribute,
      String? value,
      Widget? valueWidget,
      required BuildContext context}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        RichText(
            text: TextSpan(
                text: '$attribute : ',
                style: Theme.of(context).textTheme.subtitle1,
                children: [
              if (value != null)
                TextSpan(
                  text: value,
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      ?.apply(color: BasicColors.kDarkBlue),
                )
            ])),
        valueWidget ?? SizedBox.shrink()
      ],
    );
  }

  Column _buildBulletPoints(List details) {
    List<Widget> _children = [
      BasicScreen.buildSectionHeader('requirements'.tr(), context)
    ];

    _children.addAll(details
        .map((e) => Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.chevron_right,
                    color: BasicColors.kDarkBlue,
                    size: 20,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Expanded(
                      child: Text(
                    e,
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
}
