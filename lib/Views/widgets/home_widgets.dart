import 'package:boya_invoices/Views/home_screen.dart';
import 'package:boya_invoices/Views/widgets/general_wiidgets.dart';
import 'package:boya_invoices/utils/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../models/invoice_model.dart';
import '../../utils/boya_Assets.dart';
import '../../utils/colors.dart';
import '../Controllers/home_screen_controllers.dart';
import '../invoice_details_screen.dart';

class InvoiceCard extends StatefulWidget {
  InvoiceCard({
    super.key,
    required this.width,
    this.invoices,
  });
  final double width;
  final Invoice? invoices;

  @override
  State<InvoiceCard> createState() => _InvoiceCardState();
}

DateTime dateTime = DateTime.now();
String poundsSymbol = '\u00A3';
String? formatDueDatenow;

class _InvoiceCardState extends State<InvoiceCard> {
  @override
  Widget build(BuildContext context) {
    final dueDate = widget.invoices?.paymentDue;

    if (dueDate != null) {
      setState(() {
        formatDueDatenow = DateFormat('dd MMM yyyy').format(dueDate!);
      });
    }
    double itemPrice = 0;

    return InkWell(
      hoverColor: AppColors.buttonHoverColor,
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => InvoiceDetails(
                      invoiceInfo: widget.invoices,
                    )));
      },
      child: Container(
          margin: EdgeInsets.symmetric(horizontal: 100),
          width: widget.width * 0.9,
          height: 70,
          decoration: BoxDecoration(
              color: Color(0xff252945),
              borderRadius: BorderRadius.circular(10)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    widget.invoices?.id ?? '',
                    textAlign: TextAlign.start,
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Due $formatDueDatenow',
                    textAlign: TextAlign.start,
                    style: const TextStyle(color: Colors.white),
                  ),
                ],
              ),
              Text(
                widget.invoices?.clientName ?? '',
                textAlign: TextAlign.start,
                style: const TextStyle(color: Colors.white),
              ),
              Text(
                '\ $poundsSymbol${widget.invoices?.total.toString()}',
                textAlign: TextAlign.start,
                style: const TextStyle(color: Colors.white),
              ),
              StatusButton(widget: widget),
              SvgPicture.asset(BoyaAssets.arrowRightIcon,
                  width: 10, semanticsLabel: '')
            ],
          )),
    );
  }
}

class StatusButton extends StatelessWidget {
  const StatusButton({
    super.key,
    required this.widget,
  });

  final InvoiceCard? widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: widget?.invoices?.status == 'pending'
              ? AppColors.statusButtonTexttColorPending.shade500
                  .withOpacity(0.1)
              : widget?.invoices?.status == 'draft'
                  ? Colors.white.withOpacity(0.1)
                  : AppColors.statusButtonTexttColorPaiid.withOpacity(
                      0.1) //  AppColors.statusButtonTexttColorPending.shade800.withOpacity(0.1),
          ),
      width: 100,
      height: 40,
      child: Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Dot(
              color: widget?.invoices?.status == 'pending'
                  ? AppColors.statusButtonTexttColorPending.shade500
                  : widget?.invoices?.status == 'draft'
                      ? Colors.white
                      : AppColors.statusButtonTexttColorPaiid,
            ),
            Text(
              widget?.invoices?.status ?? '',
              style: TextStyle(
                  fontSize: 15,
                  color: widget?.invoices?.status == 'pending'
                      ? AppColors.statusButtonTexttColorPending.shade500
                      : widget?.invoices?.status == 'draft'
                          ? Colors.white
                          : AppColors.statusButtonTexttColorPaiid),
            ),
          ],
        ),
      ),
    );
  }
}

class Dot extends StatelessWidget {
  final Color color;
  final double size;

  const Dot({
    Key? key,
    this.color = Colors.black,
    this.size = 9.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
    );
  }
}
