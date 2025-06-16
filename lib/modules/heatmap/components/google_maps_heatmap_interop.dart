@JS('google.maps')
library google_maps_heatmap_interop;

import 'package:js/js.dart';

@JS()
class Map {
  external factory Map(dynamic element, MapOptions options);
}

@JS()
@anonymous
class MapOptions {
  external factory MapOptions({
    required LatLng center,
    required int zoom,
    String? mapTypeId,
  });

  external LatLng get center;
  external int get zoom;
  external String? get mapTypeId;
}

@JS()
class LatLng {
  external factory LatLng(num lat, num lng);
}

@JS('google.maps.visualization.HeatmapLayer')
class HeatmapLayer {
  external factory HeatmapLayer(HeatmapOptions options);
}

@JS()
@anonymous
class HeatmapOptions {
  external factory HeatmapOptions({required List<LatLng> data, required Map map});
}
