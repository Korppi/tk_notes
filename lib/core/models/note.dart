import 'dart:convert';

class Note {
  String text;

  Note({
    this.text,
  });

  Map<String, dynamic> toMap() {
    return {
      'text': text,
    };
  }

  static Note fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Note(
      text: map['text'],
    );
  }

  String toJson() => json.encode(toMap());

  static Note fromJson(String source) => fromMap(json.decode(source));
}
