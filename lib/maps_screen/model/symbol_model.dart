import 'package:mapbox_gl/mapbox_gl.dart';

class CustomSymbol extends Symbol {
  final String customId;

  CustomSymbol(SymbolOptions options, this.customId) : super(customId, options);
}
