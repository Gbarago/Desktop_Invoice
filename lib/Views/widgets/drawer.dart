import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../models/invoice_model.dart';
import '../../utils/boya_Assets.dart';
import '../../utils/colors.dart';
import '../../utils/helpers.dart';
import '../Controllers/home_screen_controllers.dart';
import '../home_screen.dart';
import 'general_wiidgets.dart';

class DrawerWidget extends StatefulWidget {
  DrawerWidget({
    super.key,
    required this.width,
    required this.context,
  });
  final BuildContext context;
  final double width;

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

String? formatDueDate;
String _selectedDate = '';
int? paymentTermsVa;

TextEditingController streetAddressController = TextEditingController();
TextEditingController cityController = TextEditingController();
TextEditingController clientCityController = TextEditingController();
TextEditingController postCodeController = TextEditingController();
TextEditingController clientPostCodeController = TextEditingController();
TextEditingController countryController = TextEditingController();
TextEditingController clientCountryController = TextEditingController();
TextEditingController cliientAddressController = TextEditingController();
TextEditingController cliientEmailController = TextEditingController();
TextEditingController cliientNameController = TextEditingController();
TextEditingController invoiceDateController = TextEditingController();
TextEditingController descriptionController = TextEditingController();
TextEditingController itemNameController = TextEditingController();
TextEditingController itemQtyController = TextEditingController();
TextEditingController itemPriceController = TextEditingController();
int paymentDuration = 0;
String paymentDueDate = '';
bool areAllControllersFilled() {
  // List of controllers
  List<TextEditingController> controllers = [
    streetAddressController,
    cityController,
    clientCityController,
    postCodeController,
    clientPostCodeController,
    countryController,
    clientCountryController,
    cliientAddressController,
    cliientEmailController,
    cliientNameController,
    invoiceDateController,
    descriptionController,
    // itemNameController,
    // itemQtyController,
    // itemPriceController,
  ];

  // Check if any controller value is empty
  for (TextEditingController controller in controllers) {
    if (controller.text.isEmpty) {
      return false; // Not all controllers are filled
    }
  }

  return true; // All controllers are filled
}

List<CustDropdownMenuItem<dynamic>> get paymentTermsDropDownItems {
  List<CustDropdownMenuItem<dynamic>> menuItems2 = [
    CustDropdownMenuItem(
      value: 1,
      child: Container(
        padding: const EdgeInsets.only(left: 10),
        child: const Text(
          "Net 1 Day",
          style: TextStyle(
              color: AppColors.appWhiteFade,
              fontWeight: FontWeight.w500,
              fontSize: 14,
              fontFamily: "sf-ui-display"),
        ),
      ),
    ),
    CustDropdownMenuItem(
      value: 2,
      child: Container(
        padding: const EdgeInsets.only(left: 10),
        child: const Text(
          "Net 7 Days",
          style: TextStyle(
              color: AppColors.appWhiteFade,
              fontWeight: FontWeight.w500,
              fontSize: 14,
              fontFamily: "sf-ui-display"),
        ),
      ),
    ),
    CustDropdownMenuItem(
      value: 3,
      child: Container(
        padding: const EdgeInsets.only(left: 10),
        child: const Text(
          "Net 14 Days",
          style: TextStyle(
              color: AppColors.appWhiteFade,
              fontWeight: FontWeight.w500,
              fontSize: 14,
              fontFamily: "sf-ui-display"),
        ),
      ),
    ),
    CustDropdownMenuItem(
      value: 4,
      child: Container(
        padding: const EdgeInsets.only(left: 10),
        child: const Text(
          "Net 30 Days",
          style: TextStyle(
              color: AppColors.appWhiteFade,
              fontWeight: FontWeight.w500,
              fontSize: 14,
              fontFamily: "sf-ui-display"),
        ),
      ),
    ),
  ];
  return menuItems2;
}

class _DrawerWidgetState extends State<DrawerWidget> {
  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      if (args.value is DateTime) {
        _selectedDate = args.value.toString();

        String formatDueDate = DateFormat('dd MMM yyyy').format(args.value);

        invoiceDateController.text = formatDueDate;
      }
    });

    togglePickerVisibility();
  }

  bool showPicker = false;

  void togglePickerVisibility() {
    setState(() {
      showPicker = !showPicker;
    });
  }

  setPaymentTermsVal(val) {
    setState(() {
      paymentTermsVa = val;
    });
  }

  List<Item>? items = [];
  final controller = Get.put(InvoiceController());

  setItems() {
    setState(() {
      items = controller.items;
    });
  }

  void clearControllers() {
    streetAddressController.clear();
    cityController.clear();
    clientCityController.clear();
    postCodeController.clear();
    clientPostCodeController.clear();
    countryController.clear();
    clientCountryController.clear();
    cliientAddressController.clear();
    cliientEmailController.clear();
    cliientNameController.clear();
    invoiceDateController.clear();
    descriptionController.clear();
    itemNameController.clear();
    itemQtyController.clear();
    itemPriceController.clear();
  }

  @override
  void initState() {
    // setItems();
    // TODO: implement initState
    super.initState();
  }

// set payment due date duration
  setPaymenterms(paymentTermsVal) {
    if (paymentTermsVal == 1) {
      setState(() {
        paymentDuration = 1;
      });
    } else if (paymentTermsVal == 2) {
      setState(() {
        paymentDuration = 7;
      });
    } else if (paymentTermsVal == 3) {
      setState(() {
        paymentDuration = 14;
      });
    } else if (paymentTermsVal == 4) {
      setState(() {
        paymentDuration = 30;
      });
    }
    final dateFormat = DateFormat('dd MMM yyyy');

    if (invoiceDateController.text.isNotEmpty) {
      final parsedDate = dateFormat.parse(invoiceDateController.text);

      final paymentDue = parsedDate.add(Duration(days: paymentDuration));
      paymentDueDate = paymentDue.toString();
    }

    print(' chck durratioon::::____++ didn  $paymentDueDate');
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Container(
        width: widget.width * 0.45,
        margin: EdgeInsets.only(left: widget.width * 0.08),
        child: Drawer(
          backgroundColor: AppColors.backgroundColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(left: 30, right: 30, top: 40),
                child: const Text(
                  ' New Invooice',
                  style: TextStyle(
                    color: AppColors.appWhite,
                    fontSize: 16,
                  ),
                ),
              ),
              Container(
                height: height * 0.82,
                padding: const EdgeInsets.only(left: 30, right: 30, top: 20),
                child: SingleChildScrollView(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 40, bottom: 0),
                          child: const Text(
                            ' Bill Frome',
                            style: TextStyle(
                              color: AppColors.addButtonColor,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        FormFieldWidgets(
                          title: 'Street Address',
                          conttroller: streetAddressController,
                        ),
                        SizedBox(
                            child: Row(
                          children: [
                            Flexible(
                              // flex: 1,
                              child: FormFieldWidgets(
                                title: 'City',
                                conttroller: cityController,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Flexible(
                              // flex: 1,
                              child: FormFieldWidgets(
                                title: 'Post Code',
                                conttroller: postCodeController,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Flexible(
                              // flex: 1,
                              child: FormFieldWidgets(
                                title: 'Country',
                                conttroller: countryController,
                              ),
                            ),
                          ],
                        )),
                        Container(
                          margin: const EdgeInsets.only(top: 40, bottom: 0),
                          child: const Text(
                            ' Bill To',
                            style: TextStyle(
                              color: AppColors.addButtonColor,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        FormFieldWidgets(
                          title: 'Client Name',
                          conttroller: cliientNameController,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        FormFieldWidgets(
                          title: 'Client Email',
                          conttroller: cliientEmailController,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        FormFieldWidgets(
                          title: 'Street Address',
                          conttroller: cliientAddressController,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          child: Row(
                            children: [
                              Flexible(
                                //  flex: 1,
                                child: FormFieldWidgets(
                                  title: 'City',
                                  conttroller: clientCityController,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Flexible(
                                // flex: 1,
                                child: FormFieldWidgets(
                                  title: 'Post Code',
                                  conttroller: clientPostCodeController,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Flexible(
                                // flex: 1,
                                child: FormFieldWidgets(
                                  title: 'Country',
                                  conttroller: clientCountryController,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Flexible(
                              //flex: 1,
                              child: Container(
                                margin: const EdgeInsets.only(top: 20),
                                height: 104,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Invoice Date',
                                      style: TextStyle(color: Colors.white54),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(
                                          bottom: 30, top: 10),
                                      child: Expanded(
                                        child: GestureDetector(
                                          onTap: togglePickerVisibility,
                                          child: TextFormField(
                                            keyboardType:
                                                TextInputType.datetime,
                                            textAlign: TextAlign.justify,
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 12),
                                            controller: invoiceDateController,
                                            // int
                                            enabled: false,
                                            decoration: InputDecoration(
                                                suffixIcon: GestureDetector(
                                                    onTap:
                                                        togglePickerVisibility,
                                                    child: SizedBox(
                                                      height: 5,
                                                      width: 5,
                                                      child: SvgPicture.asset(
                                                        BoyaAssets.calenderIcon,
                                                        fit: BoxFit.scaleDown,
                                                        // width: 10,
                                                        // height: 5,
                                                      ),
                                                    )),
                                                contentPadding:
                                                    const EdgeInsets.only(
                                                        left: 20, bottom: 10),
                                                labelText: '',
                                                filled: true,
                                                border: InputBorder
                                                    .none, // Remove input border

                                                fillColor: AppColors
                                                    .priimaryFillColor),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Flexible(
                                //  flex: 1,
                                child: Container(
                              margin: const EdgeInsets.only(top: 20),
                              height: 104,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Payment Terms',
                                    style: TextStyle(color: Colors.white54),
                                  ),
                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.only(
                                          bottom: 30, top: 10),
                                      child: CustDropDown(
                                        maxListHeight: 200,
                                        margin: EdgeInsets.only(top: 30),
                                        borderRadius: 5,
                                        hintText: '',
                                        items: paymentTermsDropDownItems,
                                        onChanged: (val) {
                                          setPaymenterms(val);
                                          setPaymentTermsVal(val);
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ))
                          ],
                        ),
                        if (showPicker)
                          Container(
                            // width: 80, // Set the desired width
                            height: 200,
                            //  margin: EdgeInsets.only(right: 30),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    5)), //double.maxFinite, // Adjust the width as needed
                            child: Padding(
                              padding: EdgeInsets.only(right: width * 0.21),
                              child: SfDateRangePicker(
                                backgroundColor: AppColors.priimaryFillColor,
                                onSelectionChanged: _onSelectionChanged,
                                selectionMode:
                                    DateRangePickerSelectionMode.single,
                                //showActionButtons: true,
                                selectionColor: AppColors.appWhiteFade,
                                monthCellStyle:
                                    const DateRangePickerMonthCellStyle(
                                        textStyle: TextStyle(
                                            color: AppColors.appWhiteFade)),
                                yearCellStyle:
                                    const DateRangePickerYearCellStyle(
                                        textStyle: TextStyle(
                                            color: AppColors.appWhiteFade)),

                                headerStyle: const DateRangePickerHeaderStyle(
                                    textStyle: TextStyle(
                                        color: AppColors.appWhiteFade)),
                                showNavigationArrow: true,
                              ),
                            ),
                          ),
                        FormFieldWidgets(
                          title: 'Project Address',
                          conttroller: descriptionController,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        const Text(
                          'Items List',
                          style: TextStyle(
                              color: Colors.white54,
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: width * 0.15,
                              child: const Text(
                                'Items Name',
                                style: TextStyle(
                                  color: Colors.white54,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            SizedBox(
                              width: width * 0.05,
                              child: const Text(
                                'Qty.',
                                style: TextStyle(
                                  color: Colors.white54,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            SizedBox(
                              width: width * 0.07,
                              child: const Text(
                                'Price',
                                style: TextStyle(
                                  color: Colors.white54,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            const Text(
                              'Total',
                              style: TextStyle(
                                color: Colors.white54,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 150,
                          child: items?.length == 0
                              // controller.items?.length == 0
                              ? const Center(
                                  child: Text(
                                    'Yoou have no Added Items',
                                    style: TextStyle(
                                        color: Colors.white54,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600),
                                  ),
                                )
                              : ListView.separated(
                                  itemCount: items?.length ?? 0,
                                  //controller.items?.length ?? 0,
                                  separatorBuilder: (context, index) =>
                                      const Divider(
                                    //height: 5,
                                    color: Colors.transparent,
                                  ),
                                  itemBuilder: (context, index) {
                                    if (items == null || index >= items!.length)
                                      return null;
                                    final item = items![index];
                                    return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.only(
                                              bottom: 2, top: 0),
                                          padding: const EdgeInsets.only(
                                              left: 0, bottom: 20, top: 10),
                                          width: width * 0.15,
                                          decoration: BoxDecoration(
                                            color: AppColors.priimaryFillColor,
                                          ),
                                          child: Center(
                                            child: Text(
                                              '      ${item.name}',
                                              // textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 10),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Container(
                                          margin: const EdgeInsets.only(
                                              bottom: 2, top: 0),
                                          padding: const EdgeInsets.only(
                                              left: 0, bottom: 20, top: 10),
                                          width: width * 0.05,
                                          decoration: BoxDecoration(
                                            color: AppColors.priimaryFillColor,
                                          ),
                                          child: Center(
                                            child: Text(
                                              '      ${item.quantity}',
                                              // textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 10),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Container(
                                          margin: const EdgeInsets.only(
                                              bottom: 2, top: 0),
                                          padding: const EdgeInsets.only(
                                              left: 0, bottom: 20, top: 10),
                                          width: width * 0.07,
                                          decoration: BoxDecoration(
                                            color: AppColors.priimaryFillColor,
                                          ),
                                          child: Center(
                                            child: Text(
                                              '      ${item.price}',
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 10),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        SizedBox(
                                            width: width * 0.07,
                                            child: Text(" ${item.total}",
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 10))),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        GestureDetector(
                                            onTap: () async {
                                              controller.removeItem(item);
                                              await setItems();
                                            },
                                            child: SizedBox(
                                              width: 10,
                                              child: SvgPicture.asset(
                                                  BoyaAssets.deleteIcon),
                                            ))
                                      ],
                                    );
                                  },
                                ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Buttons(
                            title: 'Add New Item',
                            butttonColor: AppColors.priimaryFillColor,
                            onPressed: () async {
                              _showItemDialog(
                                context,
                                controller,
                              );
                            },
                            buttoniWdth: width * 0.7,
                            hoverColor: AppColors.appBlackColorLite),
                        const SizedBox(
                          height: 150,
                        )
                      ]),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Buttons(
                      textColor: AppColors.appBlackColorLite,
                      title: 'Discard',
                      butttonColor: AppColors.appWhite,
                      onPressed: () {
                        controller.clearItems();
                        clearControllers();
                        Navigator.of(context).pop(); // Close the drawer
                      },
                      buttoniWdth: 100,
                      hoverColor: AppColors.discardHoverColor),
                  Row(
                    children: [
                      Buttons(
                          title: 'Save as Draft',
                          butttonColor: AppColors.appBlackColorLite,
                          onPressed: () {
                            final dateFormat =
                                DateFormat('yyyy-MM-dd HH:mm:ss.S');

                            try {
                              final parsedDate =
                                  dateFormat.parse(paymentDueDate);

                              controller.createInvoice(Invoice(
                                createdAt: DateTime.now(),
                                paymentDue: parsedDate,
                                paymentTerms: paymentTermsVa,
                                clientName: cliientNameController.text,
                                clientEmail: cliientEmailController.text,
                                clientAddress: Address(
                                    street: cliientAddressController.text,
                                    city: clientCityController.text,
                                    postCode: clientPostCodeController.text,
                                    country: Country.EMPTY),
                                description: descriptionController.text,
                                status: 'draft',
                                total: controller.totalPrice,
                                senderAddress: Address(
                                    street: streetAddressController.text,
                                    city: cityController.text,
                                    postCode: postCodeController.text,
                                    country: Country.EMPTY),
                                items: controller.items,
                              ));
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => MyHomePage()));
                              controller.clearItems();
                              clearControllers();
                            } catch (e) {
                              print('this is error $e');
                            }
                            // Navigator.of(context).pop();
                          },
                          buttoniWdth: 110,
                          hoverColor: AppColors.priimaryFillColor),
                      Buttons(
                          title: 'Save And Send',
                          butttonColor: AppColors.addButtonColor,
                          onPressed: () {
                            final dateFormat =
                                DateFormat('yyyy-MM-dd HH:mm:ss.S');
                            try {
                              final parsedDate =
                                  dateFormat.parse(paymentDueDate);

                              if (areAllControllersFilled()
                                  // &
                                  // controller.items!.isNotEmpty

                                  ) {
                                controller.createInvoice(Invoice(
                                  createdAt: DateTime.now(),
                                  paymentDue: parsedDate,
                                  paymentTerms: paymentTermsVa,
                                  clientName: cliientNameController.text,
                                  clientEmail: cliientEmailController.text,
                                  clientAddress: Address(
                                      street: cliientAddressController.text,
                                      city: clientCityController.text,
                                      postCode: clientPostCodeController.text,
                                      country: Country.EMPTY),
                                  description: descriptionController.text,
                                  status: 'pending',
                                  total: controller.totalPrice,
                                  senderAddress: Address(
                                      street: streetAddressController.text,
                                      city: cityController.text,
                                      postCode: postCodeController.text,
                                      country: Country.EMPTY),
                                  items: controller.items,
                                ));

                                controller.clearItems();
                                clearControllers();

                                Future.delayed(const Duration(seconds: 2), () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => MyHomePage()));
                                });
                              } else {
                                Get.snackbar(
                                  'Validation Error',
                                  'Please fill in all required fields.',
                                  snackPosition: SnackPosition.BOTTOM,
                                );
                              }
                            } catch (e) {
                              print('logg the erro $e');
                            }
                          },
                          buttoniWdth: 110,
                          hoverColor: AppColors.buttonHoverColor),
                    ],
                  ),
                ],
              )
            ],
          ),
        ));
  }

  void _showItemDialog(
    BuildContext context,
    InvoiceController controller,
  ) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          clearItemControllers() {
            itemQtyController.clear();
            itemNameController.clear();
            itemPriceController.clear();
          }

          return Theme(
              data: Theme.of(context).copyWith(
                dialogBackgroundColor: AppColors.priimaryFillColor,
              ),
              child: AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                title: const Text(
                  'Add Item',
                  style: TextStyle(
                      color: AppColors.appWhite,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: 70,
                      height: 100,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FormFieldWidgets(
                            keyBooardType: TextInputType.text,
                            conttroller: itemNameController,
                            title: 'Item Name',
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: 70,
                      height: 100,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FormFieldWidgets(
                            isNumberOnly: true,
                            keyBooardType: TextInputType.number,
                            conttroller: itemQtyController,
                            title: 'QTY',
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: 70,
                      height: 100,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FormFieldWidgets(
                            keyBooardType: TextInputType.number,
                            conttroller: itemPriceController,
                            isNumberOnly: true,
                            title: 'Price',
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                actions: [
                  Buttons(
                      title: 'Cancel',
                      onPressed: () {
                        clearItemControllers();
                        Navigator.of(context).pop();
                      },
                      butttonColor:
                          AppColors.appBlackColorLite.withOpacity(0.3),
                      buttoniWdth: 80,
                      hoverColor: AppColors.appWhiteFade),
                  Buttons(
                    title: 'Add',
                    butttonColor: AppColors.addButtonColor,
                    buttoniWdth: 80,
                    hoverColor: AppColors.buttonHoverColor,
                    onPressed: () async {
                      if (itemQtyController.text.isEmpty ||
                          itemNameController.text.isEmpty ||
                          itemPriceController.text.isEmpty) {
                      } else {
                        final qty = int.parse(itemQtyController.text);
                        controller.addItem(itemNameController.text, qty,
                            double.parse(itemPriceController.text));
                        clearItemControllers();
                        Navigator.of(context).pop();
                      }
                    },
                  ),
                ],
              ));
        }).then((value) {
      setItems();
    });
  }
}
