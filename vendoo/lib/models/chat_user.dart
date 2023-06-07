class ChatUser {
  ChatUser({
    required this.email,
    required this.image,
    required this.isOnline,
    required this.pushToken,
    required this.lastActive,
    required this.createdAt,
    required this.about,
    required this.name,
    required this.id,
  });
  late String email;
  late String image;
  late bool isOnline;
  late String pushToken;
  late String lastActive;
  late String about;
  late String createdAt;
  late String id;
  late String name;
  
  ChatUser.fromJson(Map<String, dynamic> json){
    email = json['email'] ?? '';
    image = json['image'] ?? '';
    isOnline = json['is_online'] ?? '';
    pushToken = json['push_token'] ?? '';
    lastActive = json['last_active'] ?? '';
    createdAt = json['created_at'] ?? '';
    about = json['about'] ?? '';
    name = json['name'] ?? '';
    id = json['id'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['email'] = email;
    data['image'] = image;
    data['is_online'] = isOnline;
    data['push_token'] = pushToken;
    data['last_active'] = lastActive;
    data['created_at'] = createdAt;
    data['about'] = about;
    data['name'] = name;
    data['id'] = id;
    return data;
  }
}