// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Word {
  final String text;
  final String url;
  bool displayText;
  Word({
    required this.text,
    required this.url,
    required this.displayText,
  });

  Word copyWith({
    String? text,
    String? url,
    bool? displayText,
  }) {
    return Word(
      text: text ?? this.text,
      url: url ?? this.url,
      displayText: displayText ?? this.displayText,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'text': text,
      'url': url,
      'displayText': displayText,
    };
  }

  factory Word.fromMap(Map<String, dynamic> map) {
    return Word(
      text: map['text'] as String,
      url: map['url'] as String,
      displayText: map['displayText'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory Word.fromJson(String source) =>
      Word.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'Word(text: $text, url: $url, displayText: $displayText)';

  @override
  bool operator ==(covariant Word other) {
    if (identical(this, other)) return true;

    return other.text == text &&
        other.url == url &&
        other.displayText == displayText;
  }

  @override
  int get hashCode => text.hashCode ^ url.hashCode ^ displayText.hashCode;
}
