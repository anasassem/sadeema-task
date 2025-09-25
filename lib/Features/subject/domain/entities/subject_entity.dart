import 'dart:ui';

import 'package:sadeematask/core/utils/color_utils.dart';

class SubjectEntity {
  final int id;
  final String name;
  final String img;
  final int termId;
  final num oldPrice;
  final num price;
  final String colorHex; // Store as hex string
  final int systemId;
  final int classRoomId;
  final int? pathId;
  final String type;

  const SubjectEntity({
    required this.id,
    required this.name,
    required this.img,
    required this.termId,
    required this.oldPrice,
    required this.price,
    required this.colorHex,
    required this.systemId,
    required this.classRoomId,
    this.pathId,
    required this.type,
  });

  // Getters for convenience
  Color get color => colorHex.toColor();
  Color get lightColor => color.lighten(0.2);
  Color get darkColor => color.darken(0.1);
  Color get textColor => color.textColor;

  bool get hasDiscount => oldPrice > price;
  double get discountPercentage => hasDiscount ? ((oldPrice - price) / oldPrice * 100) : 0;

  // Create from JSON
  factory SubjectEntity.fromJson(Map<String, dynamic> json) {
    return SubjectEntity(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      img: json['img'] ?? json['image'] ?? '',
      termId: json['term_id'] ?? 0,
      oldPrice: json['old_price'] ?? json['original_price'] ?? 0,
      price: json['price'] ?? 0,
      colorHex: json['color']  ?? '#6C757D', // Default gray
      systemId: json['system_id'] ?? 0,
      classRoomId: json['class_room_id'] ?? 0,
      pathId: json['path_id'],
      type: json['type'] ?? '',
    );
  }
}