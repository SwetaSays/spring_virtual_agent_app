class Message {
  final String sender;
  final String content;
  final DateTime timestamp;

  Message({required this.sender, required this.content, required this.timestamp});

  Map<String, dynamic> toJson() => {
    'sender': sender,
    'content': content,
    'timestamp': timestamp.toIso8601String(),
  };

  factory Message.fromJson(Map<String, dynamic> json) => Message(
    sender: json['sender'],
    content: json['content'],
    timestamp: DateTime.parse(json['timestamp']),
  );
}
