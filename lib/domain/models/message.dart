class Message {
  late final int id;
  late String body;
  late int senderId;
  late int receiverId;
  late DateTime createdAt;
  late bool read;

  Message(
      {required this.id,
      required this.body,
      required this.senderId,
      required this.receiverId,
      required this.createdAt,
      required this.read});

  Message.fromResponse(Map<String, dynamic> response) {
    id = response['id'];
    body = response['body'];
    senderId = response['sender_id'];
    receiverId = response['receiver_id'];
    createdAt = DateTime.parse(response['created_at']);
    read = response['read'];
  }
}
