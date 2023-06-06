import 'package:boya_invoices/Views/home_screen.dart';
import 'package:boya_invoices/Views/widgets/home_widgets.dart';
import 'package:boya_invoices/models/invoice_model.dart';
import 'package:boya_invoices/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../utils/boya_Assets.dart';
import 'Controllers/home_screen_controllers.dart';
import 'widgets/general_wiidgets.dart';

class InvoiceDetails extends StatelessWidget {
  InvoiceDetails({super.key, required this.invoiceInfo});
  final Invoice? invoiceInfo;
  final controller = Get.put(InvoiceController());

  @override
  Widget build(BuildContext context) {
    String poundsSymbol = '\u00A3';

    final dueDate = invoiceInfo?.paymentDue;
    final createdAt = invoiceInfo?.createdAt;

    String formatDueDate = DateFormat('dd MMM yyyy').format(dueDate!);

    String formatCreatedAt = DateFormat('dd MMM yyyy').format(createdAt!);

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Container(
      color: AppColors.backgroundColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: height * 1,
                width: width * 0.08,
                decoration: BoxDecoration(
                  color: AppColors.priimaryFillColor,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        width: width * 0.08,
                        height: 80,
                        padding: const EdgeInsets.all(20),
                        decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color(0xff7c5dfa), // Top color
                                Color(0xff9277ff), // Bottom color
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(15),
                                bottomRight: Radius.circular(15))),
                        child: SvgPicture.asset(BoyaAssets.logo,
                            //  width: 10,

                            semanticsLabel: '')),
                    Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 20),
                          child: SvgPicture.asset(BoyaAssets.sunIcon,
                              semanticsLabel: ''),
                        ),
                        const Divider(),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 30),
                          child: const CircleAvatar(
                            backgroundImage: AssetImage(BoyaAssets.imageAvatar),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      top: 70,
                      right: width * 0.52,
                    ),
                    width: 100,
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SvgPicture.asset(
                              BoyaAssets.arrowLeftIcon,
                              width: 12,
                            ),
                            const Text(
                              'Go Back',
                              style: TextStyle(
                                  color: AppColors.appWhite, fontSize: 12),
                            ),
                          ]),
                    ),
                  ),
                  Container(
                    height: 70,
                    width: width * 0.6,
                    decoration: BoxDecoration(
                      color: AppColors.priimaryFillColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    margin: const EdgeInsets.only(
                        right: 150, left: 150, top: 20, bottom: 20),
                    padding: EdgeInsets.only(left: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 180,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Status',
                                style: TextStyle(
                                    color: AppColors.appWhite, fontSize: 12),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: invoiceInfo?.status == 'pending'
                                        ? AppColors
                                            .statusButtonTexttColorPending
                                            .shade500
                                            .withOpacity(0.1)
                                        : invoiceInfo?.status == 'draft'
                                            ? Colors.white.withOpacity(0.1)
                                            : AppColors
                                                .statusButtonTexttColorPaiid
                                                .withOpacity(0.1)),
                                width: 100,
                                height: 40,
                                child: Center(
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Dot(
                                        color: invoiceInfo?.status == 'pending'
                                            ? AppColors
                                                .statusButtonTexttColorPending
                                                .shade500
                                            : invoiceInfo?.status == 'draft'
                                                ? Colors.white
                                                : AppColors
                                                    .statusButtonTexttColorPaiid,
                                      ),
                                      Text(
                                        invoiceInfo?.status ?? '',
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: invoiceInfo?.status ==
                                                    'pending'
                                                ? AppColors
                                                    .statusButtonTexttColorPending
                                                    .shade500
                                                : invoiceInfo?.status == 'draft'
                                                    ? Colors.white
                                                    : AppColors
                                                        .statusButtonTexttColorPaiid),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 20),
                          width: 350,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Buttons(
                                buttoniWdth: 70,
                                butttonColor: AppColors.appBlackColorLite,
                                hoverColor: AppColors.appWhiteFade,
                                onPressed: () {},
                                title: 'Edit',
                              ),
                              Buttons(
                                buttoniWdth: 110,
                                butttonColor: AppColors.deleteButtonColor,
                                hoverColor: AppColors.deleteButtonhoverColor,
                                onPressed: () {
                                  _showDeleteConfirmationDialog(
                                      context, invoiceInfo!, controller);
                                },
                                title: 'Delete',
                              ),
                              Buttons(
                                buttoniWdth: 110,
                                butttonColor: AppColors.addButtonColor,
                                hoverColor: AppColors.buttonHoverColor,
                                onPressed: () {},
                                title: 'Mark as Paid',
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Center(
                    child: Container(
                      padding: EdgeInsets.all(30),
                      height: height * 0.65,
                      width: width * 0.6,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.priimaryFillColor,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 40),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      invoiceInfo?.id ?? '',
                                      style: const TextStyle(
                                          color: AppColors.appWhite,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      invoiceInfo?.description ?? '',
                                      style: const TextStyle(
                                          color: AppColors.appWhiteFade,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      invoiceInfo?.senderAddress?.street ?? '',
                                      style: const TextStyle(
                                          color: AppColors.appWhiteFade,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    Text(
                                      invoiceInfo?.senderAddress?.city ?? '',
                                      style: const TextStyle(
                                          color: AppColors.appWhiteFade,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    Text(
                                      invoiceInfo?.senderAddress?.postCode ??
                                          '',
                                      style: const TextStyle(
                                          color: AppColors.appWhiteFade,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    Text(
                                      invoiceInfo?.senderAddress?.country
                                              .toString() ??
                                          '',
                                      style: const TextStyle(
                                          color: AppColors.appWhiteFade,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Invoice Date',
                                    style: TextStyle(
                                        color: AppColors.appWhiteFade,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    formatCreatedAt,
                                    style: const TextStyle(
                                        color: AppColors.appWhite,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(height: 20),
                                  const Text(
                                    'Payment Due',
                                    style: TextStyle(
                                        color: AppColors.appWhiteFade,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    formatDueDate,
                                    style: const TextStyle(
                                        color: AppColors.appWhite,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                              SizedBox(width: width * 0.06),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Bill To',
                                    style: TextStyle(
                                        color: AppColors.appWhiteFade,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    invoiceInfo?.clientName ?? '',
                                    style: const TextStyle(
                                        color: AppColors.appWhite,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    invoiceInfo?.clientAddress?.street ?? '',
                                    style: const TextStyle(
                                        color: AppColors.appWhiteFade,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Text(
                                    invoiceInfo?.clientAddress?.city ?? '',
                                    style: const TextStyle(
                                        color: AppColors.appWhiteFade,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Text(
                                    invoiceInfo?.clientAddress?.postCode ?? '',
                                    style: const TextStyle(
                                        color: AppColors.appWhiteFade,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Text(
                                    invoiceInfo?.clientAddress?.country
                                            .toString() ??
                                        '',
                                    style: const TextStyle(
                                        color: AppColors.appWhiteFade,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                              SizedBox(width: width * 0.06),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Sent To',
                                    style: TextStyle(
                                        color: AppColors.appWhiteFade,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  SizedBox(
                                    width: width * 0.11,
                                    child: Text(
                                      invoiceInfo?.clientEmail ?? '',
                                      style: const TextStyle(
                                          color: AppColors.appWhite,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 30),
                            padding: EdgeInsets.only(bottom: 20),
                            width: width * 0.55,
                            height: height * 0.25,
                            decoration: BoxDecoration(
                                color: AppColors.appBlackColorLite,
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(children: [
                              const SizedBox(
                                height: 30,
                              ),
                              Container(
                                margin: const EdgeInsets.only(bottom: 10),
                                child: const Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      'Item Name',
                                      style: TextStyle(
                                          color: AppColors.appWhiteFade,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    Text(
                                      'QTY',
                                      style: TextStyle(
                                          color: AppColors.appWhiteFade,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    Text(
                                      'Price',
                                      style: TextStyle(
                                          color: AppColors.appWhiteFade,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    Text(
                                      'Total',
                                      style: TextStyle(
                                          color: AppColors.appWhiteFade,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: invoiceInfo?.items?.length ?? 0,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 20),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(
                                            '${invoiceInfo?.items?[index].name}',
                                            style: const TextStyle(
                                                color: AppColors.appWhite,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Text(
                                            '${invoiceInfo?.items?[index].quantity}',
                                            style: const TextStyle(
                                                color: AppColors.appWhite,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Text(
                                            '$poundsSymbol${invoiceInfo?.items?[index].price}',
                                            style: const TextStyle(
                                                color: AppColors.appWhite,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Text(
                                            '$poundsSymbol${invoiceInfo?.items?[index].total}',
                                            style: const TextStyle(
                                                color: AppColors.appWhite,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                width: width * 0.45,
                                height: height * 0.06,
                                decoration: BoxDecoration(
                                    color: AppColors.appBlackColor,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'Amount Due',
                                      style: TextStyle(
                                          color: AppColors.appWhiteFade,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      '$poundsSymbol${invoiceInfo?.total}',
                                      style: const TextStyle(
                                          color: AppColors.appWhite,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                              )
                            ]),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ));
  }
}

void _showDeleteConfirmationDialog(
    BuildContext context, Invoice invoice, InvoiceController controller) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return Theme(
            data: Theme.of(context).copyWith(
              dialogBackgroundColor: AppColors.priimaryFillColor,
            ),
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              title: const Text(
                'Confirm Deeletion',
                style: TextStyle(
                    color: AppColors.appWhite,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
              content: Text(
                'Are you sure you want to deleete invoice ${invoice.id}? This action cannot be undone',
                style: const TextStyle(
                    color: AppColors.appWhiteFade,
                    fontSize: 12,
                    fontWeight: FontWeight.w400),
              ),
              actions: [
                Buttons(
                    title: 'Cancel',
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    butttonColor: AppColors.appBlackColorLite.withOpacity(0.3),
                    buttoniWdth: 80,
                    hoverColor: AppColors.appWhiteFade),
                Buttons(
                  title: 'Delete',
                  butttonColor: AppColors.deleteButtonColor,
                  buttoniWdth: 90,
                  hoverColor: AppColors.deleteButtonhoverColor,
                  onPressed: () {
                    controller.deleteInvoice(invoice);

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MyHomePage(),
                      ),
                    );
                  },
                ),
              ],
            ));
      });
}
