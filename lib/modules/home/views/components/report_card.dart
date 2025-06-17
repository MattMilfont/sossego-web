import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:sossego_web/modules/home/models/report_model.dart';
import 'package:sossego_web/modules/home/states/actions/select_report_action.dart';
import 'package:sossego_web/utils/app_assets.dart';
import 'package:sossego_web/utils/app_colors.dart';

class ReportCard extends StatelessWidget {
  final String reportDate;
  final String reportTitle;
  final String reportDescription;
  final String reportAddress;
  final String? image;
  final ReportModel report;
  final VoidCallback? onFinish;

  const ReportCard({
    required this.reportDate,
    required this.reportTitle,
    required this.reportDescription,
    required this.reportAddress,
    required this.report,
    this.image,
    this.onFinish, 
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Widget imageWidget;

    if (image != null && image!.isNotEmpty) {
      try {
        final base64String =
            image!.contains(',') ? image!.split(',').last : image!;
        final imageBytes = base64Decode(base64String);
        imageWidget = Image.memory(imageBytes, fit: BoxFit.cover);
      } catch (e) {
        imageWidget = Image.asset(AppAssets.logo, fit: BoxFit.cover);
      }
    } else {
      imageWidget = Image.asset(AppAssets.logo, fit: BoxFit.cover);
    }

    return InkWell(
      onTap: () {
        selectReport(report);
      },
      child: Card(
        color: AppColors.primaryColor,
        margin: const EdgeInsets.only(bottom: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: CircleAvatar(),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Denúncia do dia $reportDate',
                      style: const TextStyle(
                        color: AppColors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      reportAddress,
                      style: const TextStyle(
                        color: AppColors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Container(
              height: 200,
              width: double.infinity,
              color: AppColors.white,
              child: imageWidget,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                reportTitle,
                style: const TextStyle(
                  color: AppColors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                reportDescription,
                style: const TextStyle(
                  color: AppColors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 10,
              ),
              child: Center(
                child: ElevatedButton(
                  onPressed: onFinish, // ✅ Executa a função recebida
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  child: const Text(
                    'Finalizar Denúncia',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
