class Hair {
  final String color;
  final String type;

  const Hair({
    required this.color,
    required this.type,
  });

  factory Hair.fromJson(Map<String, dynamic> json) {
    return Hair(
      color: json['color'] as String,
      type: json['type'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'color': color,
      'type': type,
    };
  }
}