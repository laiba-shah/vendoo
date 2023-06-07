
class Message {
  Message({
    required this.read,
    required this.message,
    required this.toId,
    required this.type,
    required this.sent,
    required this.fromId,
  });
  late final String read;
  late final String message;
  late final String toId;
  late final Type type;
  late final String sent;
  late final String fromId;
  
  Message.fromJson(Map<String, dynamic> json){
    read = json['read'].toString();
    message = json['message'].toString();
    toId = json['toId'].toString();
    type = json['type'].toString() == Type.image.name ? Type.image : Type.Text;
    sent = json['sent'].toString();
    fromId = json['fromId'].toString();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['read'] = read;
    data['message'] = message;
    data['toId'] = toId;
    data['type'] = type.name;
    data['sent'] = sent;
    data['fromId'] = fromId;
    return data;
  }
}
enum Type{
  Text,image

}