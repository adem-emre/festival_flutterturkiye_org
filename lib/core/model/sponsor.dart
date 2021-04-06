import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

import 'package:festival_flutterturkiye_org/core/model/database_model.dart';

enum SponsorType { gold, silver, bronze, media }

class Sponsor extends DatabaseModel {
  const Sponsor({
    @required this.name,
    @required this.logo,
    @required this.url,
    @required this.color,
    @required this.type,
    @required this.reference,
  })  : assert(name != null),
        assert(logo != null),
        assert(url != null),
        assert(color != null),
        assert(type != null),
        assert(reference != null);

  factory Sponsor.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data();
    return Sponsor(
      reference: snapshot.reference,
      name: data['name'],
      logo: data['logo'],
      url: data['url'],
      type: _fromIntToType(data['type']),
      color: _fromHexToColor(data['color']),
    );
  }

  final String name;
  final String logo;
  final String url;
  final Color color;
  final SponsorType type;
  final DocumentReference reference;

  @override
  List<Object> get props => [
        name,
        logo,
        url,
        color,
        reference,
      ];

  /// String is in the format "aabbcc" or
  /// "ffaabbcc" with an optional leading "#".
  static Color _fromHexToColor(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) {
      buffer.write('ff');
    }
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  static SponsorType _fromIntToType(int typeId) {
    switch (typeId) {
      case 1:
        return SponsorType.gold;
        break;
      case 2:
        return SponsorType.silver;
        break;
      case 3:
        return SponsorType.bronze;
        break;
      default:
        return SponsorType.media;
        break;
    }
  }
}
