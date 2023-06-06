import 'package:boya_invoices/Views/widgets/drawer.dart';
import 'package:boya_invoices/Views/widgets/home_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../utils/boya_Assets.dart';
import '../utils/colors.dart';
import 'Controllers/home_screen_controllers.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final controller = Get.put(InvoiceController());

  @override
  void initState() {
//fetch invoice list
    controller.fetchData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String invoiceLenght = controller.invoices.length.toString();
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      drawer: DrawerWidget(
        width: width,
        context: context,
      ),
      body: Container(
        decoration: const BoxDecoration(color: AppColors.backgroundColor),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
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
                              backgroundImage:
                                  AssetImage(BoyaAssets.imageAvatar),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: SingleChildScrollView(
                    child: Column(
                      // shrinkWrap: true,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(left: 100),
                              height: height * 0.1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Invoices',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    'There are $invoiceLenght total invoices',
                                    style: const TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white54,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 100),
                              height: 45,
                              width: 130,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25)),
                              child: Builder(builder: (BuildContext context) {
                                return MaterialButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                  ),
                                  color: AppColors.addButtonColor,
                                  hoverColor: AppColors.buttonHoverColor,

                                  // highlightColor: AppColors.buttonHoverColor,
                                  onPressed: () {
                                    Scaffold.of(context).openDrawer();
                                  },

                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      CircleAvatar(
                                        radius: 12,
                                        backgroundColor: Colors.white,
                                        child: SvgPicture.asset(
                                            BoyaAssets.plusIcon,
                                            width: 7,
                                            semanticsLabel: ''),
                                      ),
                                      const Text(
                                        'New Invoice',
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                            ),
                          ],
                        ),
                        if (controller.invoices.isEmpty)
                          SizedBox(
                            width: width * 0.7,
                            height: height * 0.8,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(BoyaAssets.illustrationEmpty),
                                const SizedBox(
                                  height: 50,
                                ),
                                const Center(
                                  child: Text(
                                    'There is Nothing Here',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                const Center(
                                  child: Text(
                                    'Create an Invoice by clicking the NewInvoice button and get started',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        SizedBox(
                          height: height * 0.8,
                          child: Expanded(
                            child: ListView.separated(
                              shrinkWrap: true,
                              itemCount: controller.invoices.length,
                              separatorBuilder:
                                  (BuildContext context, int index) =>
                                      const SizedBox(height: 20),
                              itemBuilder: (BuildContext context, int index) {
                                return InvoiceCard(
                                  width: width,
                                  invoices: controller.invoices[index],
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
