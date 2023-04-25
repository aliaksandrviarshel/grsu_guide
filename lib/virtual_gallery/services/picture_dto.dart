import 'dart:convert';

class PictureDto {
  final String author;
  final String title;
  final String details;
  final String asset;

  PictureDto({
    required this.author,
    required this.title,
    required this.details,
    required this.asset,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'author': author,
      'title': title,
      'details': details,
      'asset': asset,
    };
  }

  factory PictureDto.fromMap(Map<String, dynamic> map) {
    return PictureDto(
      author: map['author'] as String,
      title: map['title'] as String,
      details: map['details'] as String,
      asset: map['asset'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory PictureDto.fromJson(String source) => PictureDto.fromMap(json.decode(source) as Map<String, dynamic>);
}
