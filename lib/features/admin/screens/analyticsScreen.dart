import 'package:eventify/common/widgets/customDialogBox.dart';
import 'package:eventify/features/admin/Widgets/totalEarningcard.dart';
import 'package:eventify/utils/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:eventify/features/admin/model/sales.dart';
import 'package:eventify/features/admin/services/admin_services.dart';
import '../../../common/widgets/Loader.dart';
import 'dart:math';

class AnalyticsScreen extends StatefulWidget {
  static const String id = '/analytics';

  const AnalyticsScreen({Key? key}) : super(key: key);

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  final AdminServices adminServices = AdminServices();
  double? totalSales;
  List<Sales>? earnings;
  double? totalCommsion;

  @override
  void initState() {
    super.initState();
    getEarnings();
  }

  getEarnings() async {
    var earningData = await adminServices.getEarnings(context);
    totalSales = earningData['totalEarnings'];
    earnings = earningData['sales'];
    totalCommsion = earningData['commission'];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: earnings == null
          ? const Loader()
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TotalEarningsCard(
                          text: 'User Sales',
                          totalSales: totalSales,
                        ),
                      ),
                      Expanded(
                        child: TotalEarningsCard(
                          text: 'Net Profit',
                          totalSales: totalCommsion,
                        ),
                      ),
                    ],
                  ),
                  // TotalEarningsCard(
                  //   totalSales: totalCommsion,
                  // ),
                  // Text(
                  //   'Total Sales: Rs:$totalSales',
                  //   style: TextStyle(
                  //     fontSize: 20,
                  //     fontWeight: FontWeight.bold,
                  //     color: _generateRandomColor(),
                  //   ),
                  // ),
                  const SizedBox(
                    height: 18,
                  ),
                  Expanded(
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: PieChart(
                        PieChartData(
                          pieTouchData: PieTouchData(
                            touchCallback:
                                (FlTouchEvent event, pieTouchResponse) {
                              setState(() {
                                if (!event.isInterestedForInteractions ||
                                    pieTouchResponse == null ||
                                    pieTouchResponse.touchedSection == null) {
                                  touchedIndex = -1;
                                  return;
                                }
                                touchedIndex = pieTouchResponse
                                    .touchedSection!.touchedSectionIndex;
                              });
                            },
                          ),
                          borderData: FlBorderData(
                            show: false,
                          ),
                          sectionsSpace: 0,
                          centerSpaceRadius: 100,
                          sections: _generatePieChartData(),
                          // infoTooltipData: FlInfoTooltipData(
                          //   show: true,
                          //   tooltipBgColor: Colors.blueGrey.withOpacity(0.7),
                          // ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 28,
                  ),
                ],
              ),
            ),
    );
  }

  int touchedIndex = -1;

  List<PieChartSectionData> _generatePieChartData() {
    // Check if earnings list is not null and not empty
    if (earnings != null && earnings!.isNotEmpty) {
      // Create a list of PieChartSectionData based on the earnings data
      return earnings!.asMap().entries.map((entry) {
        final index = entry.key;
        final sales = entry.value;
        final isTouched = index == touchedIndex;
        final fontSize = isTouched ? 20.0 : 14.0;
        final radius = isTouched ? 100.0 : 90.0;
        const shadows = [Shadow(color: Colors.black, blurRadius: 2)];

        return PieChartSectionData(
          color: _generateRandomColor(),
          value: sales.earning.toDouble(),
          title: 'Rs: ${sales.earning}\n${sales.label}',
          showTitle: true,
          radius: radius,
          titleStyle: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            shadows: shadows,
          ),
        );
      }).toList();
    } else {
      // Return an empty list if earnings data is null or empty
      return [];
    }
  }

  // Helper method to generate a random color
  Color _generateRandomColor() {
    return Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);
  }
}
