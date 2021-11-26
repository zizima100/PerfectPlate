import 'package:perfectplate/data/models/plates/plates.dart';

class PlatesList {
  final List<Plate> _plates = [];

  void insert(Plate plate) {
    _plates.add(plate);
  }

  List<Plate> get plates => [..._plates];

  Plate get last => _plates.last;

  @override
  String toString() {
    String ret = '[';
    for (var p in _plates) {
      ret += p.toString();
      ret += ',';
    }
    ret += ']';
    return ret;
  }
}