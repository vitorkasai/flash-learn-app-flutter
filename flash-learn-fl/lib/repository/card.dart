class Card {
  final int id;
  final String front;
  final String back;

  Card({
    required this.id,
    required this.front,
    required this.back,
  });

  factory Card.fromJson(Map<String, dynamic> json) {
    return Card(
      id: json['id'],
      front: json['front'],
      back: json['back'],
    );
  }

  @override
  String toString() {
    return 'Card(id: $id, front: $front, back: $back)';
  }
}