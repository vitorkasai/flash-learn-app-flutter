class CardDTO {
  final int id;
  final String front;
  final String back;

  CardDTO({
    required this.id,
    required this.front,
    required this.back,
  });

  factory CardDTO.fromJson(Map<String, dynamic> json) {
    return CardDTO(
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