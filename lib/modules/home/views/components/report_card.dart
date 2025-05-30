import 'dart:convert'; // para base64Decode
import 'package:flutter/material.dart';
import 'package:sossego_web/utils/app_assets.dart';
import 'package:sossego_web/utils/app_colors.dart';

class ReportCard extends StatelessWidget {
  final String reportDate;
  final String reportTitle;
  final String reportDescription;
  final String reportAddress;
  final String? image; // espera uma string Base64

  const ReportCard({
    required this.reportDate,
    required this.reportTitle,
    required this.reportDescription,
    required this.reportAddress,
    this.image,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Widget imageWidget;

    if (image != null && image!.isNotEmpty) {
      try {
        final base64String = image!.contains(',') ? image!.split(',').last : image!;
        final imageBytes = base64Decode(base64String);
        imageWidget = Image.memory(imageBytes, fit: BoxFit.cover);
      } catch (e) {
        // Caso ocorra erro na decodificação, usa imagem padrão
        imageWidget = Image.asset(AppAssets.logo, fit: BoxFit.cover);
      }
    } else {
      imageWidget = Image.asset(AppAssets.logo, fit: BoxFit.cover);
    }

    return Card(
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
        ],
      ),
    );
  }
}
