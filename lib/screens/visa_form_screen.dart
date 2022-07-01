import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:tutvideo/models/ResponseModels/get_visa_nationalities.dart';
import 'package:tutvideo/models/ResponseModels/get_visa_types.dart';
import 'package:tutvideo/utils/services/rest_api_service.dart';

import '../models/ResponseModels/get_visa_requirements.dart';
import '../theme/basic_colors.dart';
import '../utils/helpers/basic_screen.dart';
import '../utils/helpers/no_items_found.dart';

class VisaFormScreen extends StatefulWidget {
  final VisaType visaType;
  final personCount;
  final VisaNationality visaNationality;
  const VisaFormScreen(
      { required this.visaType, Key? key,  required this.visaNationality
      ,required this.personCount});


  @override
  State<VisaFormScreen> createState() => _VisaFormScreenState();
}

class _VisaFormScreenState extends State<VisaFormScreen> {
  VisaRequirements? _visaRequirement;
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController midNameController = TextEditingController();
  TextEditingController motherNameController = TextEditingController();
  TextEditingController religionController = TextEditingController();
  TextEditingController currentAddressController = TextEditingController();
  TextEditingController dateTravelCtl = TextEditingController();
  TextEditingController dateReturnCtl = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController countryController = TextEditingController();


  TextEditingController contactPersonController = TextEditingController();
  TextEditingController uaeNumberController = TextEditingController();
  var _selectMaterialStatus ;
  List<VisaNationality>? _visaNationalities;
  VisaNationality? _visaNationality;

  // TextEditingController firstNameController = TextEditingController();
  @override
  void initState() {

    print(widget.personCount);

    Future.delayed(
        Duration.zero,
            () => RestApiService(context: context).visaNationalities.then((value) {
          setState(() => _visaNationalities = value);
        }));
    Future.delayed(Duration.zero, () {
      return RestApiService(context: context)
          .visaRequirements(widget.visaType.id, widget.visaNationality.id)
          .then((value) {
        setState(() => _visaRequirement = value);
      });
    });
    super.initState();
  }
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('visaForm').tr()),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: (() {
            if(_formKey.currentState!.validate()){

            }
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => VisaFormScreen(),
            //   ));
          }),
          icon: Icon(Icons.navigate_next),
          label: Text('submit'.tr())),
      body: _visaRequirement == null
          ? Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.all(15),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // HtmlWidget(_visaRequirement!.text ?? "")

                    Center(child: Text("------ Application Form1 -----")),
                    SizedBox(height: 18,),
                    Container(
                      // width: 270,
                      height: 53,
                      child: TextFormField(
                        controller: firstNameController,
                        textAlignVertical: TextAlignVertical.center,
                        validator: (val) => val!.isEmpty ? '* Required' : null,
                        decoration: new InputDecoration(
                          isDense: true,

                          labelText: 'First Name',
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(25.0),
                            borderSide: new BorderSide(),
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (val) {
                          // setState(() => );
                        },
                      ),
                    ),
                    SizedBox(height: 8,),
                    Container(
                      // width: 270,
                      height: 53,
                      child: TextFormField(
                        controller: midNameController,
                        textAlignVertical: TextAlignVertical.center,
                        validator: (val) => val!.isEmpty ? '* Required' : null,
                        decoration: new InputDecoration(
                          isDense: true,

                          labelText: 'Middle Name',
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(25.0),
                            borderSide: new BorderSide(),
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (val) {
                          // setState(() => );
                        },
                      ),
                    ),
                    SizedBox(height: 8,),
                    Container(
                      // width: 270,
                      height: 53,
                      child: TextFormField(
                        controller: lastNameController,
                        textAlignVertical: TextAlignVertical.center,
                        validator: (val) => val!.isEmpty ? '* Required' : null,
                        decoration: new InputDecoration(
                          isDense: true,

                          labelText: 'Last Name',
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(25.0),
                            borderSide: new BorderSide(),
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (val) {
                          // setState(() => );
                        },
                      ),
                    ),

                    SizedBox(height: 8,),
                    Container(
                      // width: 270,
                      height: 53,
                      child: TextFormField(
                        controller: motherNameController,
                        textAlignVertical: TextAlignVertical.center,
                        validator: (val) => val!.isEmpty ? '* Required' : null,
                        decoration: new InputDecoration(
                          isDense: true,

                          labelText: 'Mother Name',
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(25.0),
                            borderSide: new BorderSide(),
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (val) {
                          // setState(() => );
                        },
                      ),
                    ),
                    SizedBox(height: 8,),
                    Container(

                        height: 53,
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(40),
                        border:
                        Border.all(color: Colors.black38, width: 1),
                      ),
                      child:
                      DropdownButtonHideUnderline(

                        child: DropdownButton2(

                          isExpanded: true,
                          hint: Row(
                            children: const [
                              Expanded(
                                child: Text(
                                  'Marital Status',
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
                          items: ['Marital Status', 'Single', 'Married',]
                              .map((item) =>
                              DropdownMenuItem<
                                  String>(
                                value: item == null
                                    ? 'Marital Status'
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
                          value: _selectMaterialStatus??"Marital Status",
                          onChanged: (value) {
                            setState(() {
                              _selectMaterialStatus = value as String;
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
                    SizedBox(height: 8,),
                    Container(
                      // width: 270,
                      height: 53,
                      child: TextFormField(
                        controller: religionController,
                        textAlignVertical: TextAlignVertical.center,
                        validator: (val) => val!.isEmpty ? '* Required' : null,
                        decoration: new InputDecoration(
                          isDense: true,

                          labelText: 'Religion',
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(25.0),
                            borderSide: new BorderSide(),
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (val) {
                          // setState(() => );
                        },
                      ),
                    ),
                    SizedBox(height: 8,),
                    Container(
                      height: 53,
                      child: TextFormField(

                        decoration: new InputDecoration(
                          isDense: true,

                          labelText: 'Date Of Travel',
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(25.0),
                            borderSide: new BorderSide(),
                          ),
                        ),
                        readOnly: true,
                        style: TextStyle(
                            color: Colors.black
                        ),
                        controller: dateTravelCtl,

                        onTap: () async {
                          await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2015),
                            lastDate: DateTime(2025),
                          ).then((selectedDate) {
                            if (selectedDate != null) {
                              print(selectedDate);


                              var formatter = DateFormat.yMMMd("en_US");
                              String nowFormatted = formatter.format(selectedDate);
                              // String date = DateFormat("yyyy-MM-dd").format(selectedDate);
                              dateTravelCtl.text =nowFormatted.toString();
                            }
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '* Required' ;
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: 8,),
                    Container(
                      height: 53,
                      child: TextFormField(

                        decoration: new InputDecoration(
                          isDense: true,

                          labelText: 'Date Of Return',
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(25.0),
                            borderSide: new BorderSide(),
                          ),
                        ),
                        readOnly: true,
                        style: TextStyle(
                            color: Colors.black
                        ),
                        controller: dateReturnCtl,

                        onTap: () async {
                          await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2015),
                            lastDate: DateTime(2025),
                          ).then((selectedDate) {
                            if (selectedDate != null) {
                              print(selectedDate);


                              var formatter = DateFormat.yMMMd("en_US");
                              String nowFormatted = formatter.format(selectedDate);
                              // String date = DateFormat("yyyy-MM-dd").format(selectedDate);
                              dateReturnCtl.text =nowFormatted.toString();
                            }
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '* Required' ;
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: 8,),
                    Container(
                      // width: 270,
                      height: 53,
                      child: TextFormField(
                        controller: lastNameController,
                        textAlignVertical: TextAlignVertical.center,
                        validator: (val) => val!.isEmpty ? '* Required' : null,
                        decoration: new InputDecoration(
                          isDense: true,

                          labelText: 'Current Address',
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(25.0),
                            borderSide: new BorderSide(),
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (val) {
                          // setState(() => );
                        },
                      ),
                    ),
                    SizedBox(height: 18,),
                    Center(child: Text("------ Contact Details -----")),

                    SizedBox(height: 18,),

                    Container(
                      // width: 270,
                      height: 53,
                      child: TextFormField(
                        controller: mobileNumberController,
                        textAlignVertical: TextAlignVertical.center,
                        validator: (val) => val!.isEmpty ? '* Required' : null,
                        decoration: new InputDecoration(
                          isDense: true,

                          labelText: 'Mobile Number',
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(25.0),
                            borderSide: new BorderSide(),
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (val) {
                          // setState(() => );
                        },
                      ),
                    ),

                    SizedBox(height: 10,),
                    Container(
                      // width: 270,
                      height: 53,
                      child: TextFormField(
                        controller: countryController,
                        textAlignVertical: TextAlignVertical.center,
                        validator: (val) => val!.isEmpty ? '* Required' : null,
                        decoration: new InputDecoration(
                          isDense: true,

                          labelText: 'Country',
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(25.0),
                            borderSide: new BorderSide(),
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (val) {
                          // setState(() => );
                        },
                      ),
                    ),

                    SizedBox(height: 10,),
                    Container(
                      // width: 270,
                      height: 53,
                      child: TextFormField(
                        controller: emailController,
                        textAlignVertical: TextAlignVertical.center,
                        validator: (val) => val!.isEmpty ? '* Required' : null,
                        decoration: new InputDecoration(
                          isDense: true,

                          labelText: 'Email',
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(25.0),
                            borderSide: new BorderSide(),
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (val) {
                          // setState(() => );
                        },
                      ),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      // width: 270,
                      height: 53,
                      child: TextFormField(
                        controller: uaeNumberController,
                        textAlignVertical: TextAlignVertical.center,
                        validator: (val) => val!.isEmpty ? '* Required' : null,
                        decoration: new InputDecoration(
                          isDense: true,

                          labelText: 'Uae Number',
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(25.0),
                            borderSide: new BorderSide(),
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (val) {
                          // setState(() => );
                        },
                      ),
                    ),

                    SizedBox(height: 10,),
                    Container(
                      // width: 270,
                      height: 53,
                      child: TextFormField(
                        controller: contactPersonController,
                        textAlignVertical: TextAlignVertical.center,
                        validator: (val) => val!.isEmpty ? '* Required' : null,
                        decoration: new InputDecoration(
                          isDense: true,

                          labelText: 'Contact Person',
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(25.0),
                            borderSide: new BorderSide(),
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (val) {
                          // setState(() => );
                        },
                      ),
                    ),

                    SizedBox(height: 60,),
                    // _visaNationalities == null
                    //     ? Center(
                    //   child: CircularProgressIndicator(
                    //     strokeWidth: 2,
                    //   ),
                    // )
                    //     : _visaNationalities!.isEmpty
                    //     ? NoItemsFound()
                    //     : SingleChildScrollView(
                    //     padding: const EdgeInsets.all(10),
                    //     child: Column(
                    //       children: [
                    //         DropdownSearch<VisaNationality>(
                    //           mode: Mode.BOTTOM_SHEET,
                    //           showSearchBox: true,
                    //           dropdownSearchDecoration: InputDecoration(
                    //             labelText: "country".tr(),
                    //             hintText: "selectYourNationality".tr(),
                    //           ),
                    //           onFind: (String? filter) async {
                    //             return (filter == null
                    //                 ? _visaNationalities
                    //                 : _visaNationalities!
                    //                 .where((element) => element.name
                    //                 .toLowerCase()
                    //                 .startsWith(filter.toLowerCase()))
                    //                 .toList()) ??
                    //                 [];
                    //           },
                    //           itemAsString: (VisaNationality? u) => u?.name ?? "",
                    //           onChanged: (VisaNationality? data) => setState(() {
                    //             _visaNationality = data;
                    //           }),
                    //           // mode: Mode.BOTTOM_SHEET,
                    //           // showSearchBox: true,
                    //           // showSelectedItems: true,
                    //           // items: _visaNationalities,
                    //           // itemAsString: (visaNationality) =>
                    //           //     visaNationality?.name ?? "",
                    //           // dropdownSearchDecoration: InputDecoration(
                    //           //   labelText: "country",
                    //           //   hintText: "selectYourNationality",
                    //           // ),
                    //           // // popupItemDisabled: (String s) => s.startsWith('I'),
                    //           // onChanged: print,
                    //           // selectedItem: "Brazil",
                    //         ),
                    //         buildNationality()
                    //       ],
                    //     )),









                  ],
                ),
              )),
    );
  }


  Widget buildNationality() {
    return _visaNationality == null
        ? SizedBox.shrink()
        : Column(
      children: [
        // CachedNetworkImage(
        //   imageUrl: _visaNationality!.image,
        //   errorWidget: (_, error, __) {
        //     log(error);
        //     return SizedBox.shrink();
        //   },
        // ),
        if (_visaNationality!.text != null)
          Container(

              child: HtmlWidget(_visaNationality!.text ?? "")),
      ],
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
