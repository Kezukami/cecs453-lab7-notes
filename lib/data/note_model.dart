class Note {
  final int? id;
  final String title;
  final String description;

  const Note({this.id, required this.title, required this.description});

  Map<String, dynamic> toMap() => {
        if (id != null) 'id': id,
        'title': title,
        'description': description,
      };

  factory Note.fromMap(Map<String, dynamic> map) => Note(
        id: map['id'] as int?,
        title: map['title'] as String,
        description: map['description'] as String,
      );
}
