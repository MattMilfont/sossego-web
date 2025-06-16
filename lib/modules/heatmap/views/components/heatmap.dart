import 'dart:ui' as ui;
// ignore: deprecated_member_use, avoid_web_libraries_in_flutter
import 'dart:html';
import 'package:flutter/material.dart';
import 'package:sossego_web/modules/home/models/report_model.dart';

class HeatMapWidget extends StatelessWidget {
  final List<ReportModel> reports;

  const HeatMapWidget({
    required this.reports,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final String viewID = 'heatmap-view-${DateTime.now().millisecondsSinceEpoch}';
    
    final heatmapPoints = reports
        .where((report) => report.latitude != null && report.longitude != null)
        .map((report) =>
            'new google.maps.LatLng(${report.latitude}, ${report.longitude})')
        .join(',');


    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(viewID, (int viewId) {
      final div = DivElement()
        ..id = viewID
        ..style.width = '100%'
        ..style.height = '100%';

      Future.delayed(const Duration(milliseconds: 100), () {
        final script = '''
          var map = new google.maps.Map(document.getElementById('$viewID'), {
            zoom: 9,
            center: { lat: -3.7432513416482642, lng: -38.52415284624899 },
            mapTypeId: 'roadmap',
          });

          const heatmapData = [$heatmapPoints];

          var heatmap = new google.maps.visualization.HeatmapLayer({
            data: heatmapData,
            map: map,
          });
        ''';

        final scriptElement = ScriptElement()
          ..type = 'text/javascript'
          ..innerHtml = script;

        document.body!.append(scriptElement);
      });

      return div;
    });

    return HtmlElementView(viewType: viewID);
  }
}
