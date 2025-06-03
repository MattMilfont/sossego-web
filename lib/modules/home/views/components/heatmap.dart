import 'dart:ui' as ui;
import 'dart:html';
import 'package:flutter/material.dart';

class HeatMapWidget extends StatelessWidget {
  const HeatMapWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final String viewID = 'heatmap-view';

    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(viewID, (int viewId) {
      final div =
          DivElement()
            ..id = viewID
            ..style.width = '100%'
            ..style.height = '100%';

      Future.delayed(const Duration(milliseconds: 100), () {
        final script = '''
          if (!window.myHeatmapMap) {
            window.myHeatmapMap = new google.maps.Map(document.getElementById('$viewID'), {
              zoom: 10,
              center: { lat: -23.5505, lng: -46.6333 },
              mapTypeId: 'roadmap',
            });

            const heatmapData = [
              new google.maps.LatLng(-23.5505, -46.6333),
              new google.maps.LatLng(-23.5515, -46.6343),
              new google.maps.LatLng(-23.5525, -46.6350),
            ];

            window.myHeatmap = new google.maps.visualization.HeatmapLayer({
              data: heatmapData,
              map: window.myHeatmapMap,
            });
          }
        ''';

        final scriptElement =
            ScriptElement()
              ..type = 'text/javascript'
              ..innerHtml = script;

        document.body!.append(scriptElement);
      });

      return div;
    });

    return HtmlElementView(viewType: viewID);
  }
}
