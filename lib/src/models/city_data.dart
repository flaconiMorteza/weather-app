import 'dart:convert';

// ignore: slash_for_doc_comments
/************************Morteza*********************************
This data class was generated by dart data class generator. This
class used to get data from server. By passing the city object to
the weatherService class, new information fetch fromm server.
****************************************************************/

class City {
  String? title;
  int? woeid;
  City({
    this.title,
    this.woeid,
  });

  City copyWith({
    String? title,
    int? woeid,
  }) {
    return City(
      title: title ?? this.title,
      woeid: woeid ?? this.woeid,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'woeid': woeid,
    };
  }

  factory City.fromMap(Map<String, dynamic> map) {
    return City(
      title: map['title'],
      woeid: map['woeid'],
    );
  }

  String toJson() => json.encode(toMap());

  factory City.fromJson(String source) => City.fromMap(json.decode(source));

  @override
  String toString() => 'City(title: $title, woeid: $woeid)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is City && other.title == title && other.woeid == woeid;
  }

  @override
  int get hashCode => title.hashCode ^ woeid.hashCode;
}
