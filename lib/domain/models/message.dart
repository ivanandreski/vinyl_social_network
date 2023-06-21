class Message {
  late final int id;
  late String body;
  late int senderId;
  late int receiverId;
  late DateTime createdAt;
  late bool read;
  String? fullName;

  Message(
      {required this.id,
      required this.body,
      required this.senderId,
      required this.receiverId,
      required this.createdAt,
      required this.read,
      this.fullName
      });

  Message.fromResponse(Map<String, dynamic> response) {
    id = response['id'];
    body = response['body'];
    senderId = response['sender_id'];
    receiverId = response['receiver_id'];
    createdAt = DateTime.parse(response['created_at']);
    read = response['read'];
    if(response['sender'] != null) {
      fullName = response['sender'];
    }
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'body': body,
    'senderId': senderId,
    'receiverId': receiverId,
    'createdAt': createdAt.toString(),
    'read': read,
  };
}
