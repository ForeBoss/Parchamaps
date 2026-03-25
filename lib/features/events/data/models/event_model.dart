import '../../../auth/data/models/user_model.dart';

class EventModel {
  final String id;
  final String title;
  final String description;
  final EventCategory category;
  final EventStatus status;
  final EventPrivacy privacy;
  final List<EventAmbience> ambience;
  final double latitude;
  final double longitude;
  final String address;
  final String? placeName;
  final DateTime startTime;
  final DateTime? endTime;
  final int? capacity;
  final int attendeeCount;
  final int interestedCount;
  final int checkedInCount;
  final String organizerId;
  final UserModel? organizer;
  final List<String> images;
  final List<String> tags;
  final bool chatEnabled;
  final bool requiresApproval;
  final bool isRecurring;
  final String? recurringRule;
  final double trustScore;
  final DateTime createdAt;
  final DateTime updatedAt;

  const EventModel({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    this.status = EventStatus.open,
    this.privacy = EventPrivacy.public,
    this.ambience = const [],
    required this.latitude,
    required this.longitude,
    required this.address,
    this.placeName,
    required this.startTime,
    this.endTime,
    this.capacity,
    this.attendeeCount = 0,
    this.interestedCount = 0,
    this.checkedInCount = 0,
    required this.organizerId,
    this.organizer,
    this.images = const [],
    this.tags = const [],
    this.chatEnabled = true,
    this.requiresApproval = false,
    this.isRecurring = false,
    this.recurringRule,
    this.trustScore = 0.0,
    required this.createdAt,
    required this.updatedAt,
  });

  bool get isFull => capacity != null && attendeeCount >= capacity!;
  bool get isAlmostFull =>
      capacity != null && attendeeCount >= (capacity! * 0.8);
  bool get isActive =>
      startTime.isBefore(DateTime.now()) &&
      (endTime == null || endTime!.isAfter(DateTime.now()));
  bool get isPast =>
      endTime != null ? endTime!.isBefore(DateTime.now()) : false;

  int? get spotsLeft =>
      capacity != null ? (capacity! - attendeeCount).clamp(0, capacity!) : null;

  EventModel copyWith({
    String? title,
    String? description,
    EventCategory? category,
    EventStatus? status,
    EventPrivacy? privacy,
    List<EventAmbience>? ambience,
    double? latitude,
    double? longitude,
    String? address,
    String? placeName,
    DateTime? startTime,
    DateTime? endTime,
    int? capacity,
    int? attendeeCount,
    int? interestedCount,
    int? checkedInCount,
    UserModel? organizer,
    List<String>? images,
    List<String>? tags,
    bool? chatEnabled,
    bool? requiresApproval,
    bool? isRecurring,
    String? recurringRule,
    double? trustScore,
  }) {
    return EventModel(
      id: id,
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      status: status ?? this.status,
      privacy: privacy ?? this.privacy,
      ambience: ambience ?? this.ambience,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      address: address ?? this.address,
      placeName: placeName ?? this.placeName,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      capacity: capacity ?? this.capacity,
      attendeeCount: attendeeCount ?? this.attendeeCount,
      interestedCount: interestedCount ?? this.interestedCount,
      checkedInCount: checkedInCount ?? this.checkedInCount,
      organizerId: organizerId,
      organizer: organizer ?? this.organizer,
      images: images ?? this.images,
      tags: tags ?? this.tags,
      chatEnabled: chatEnabled ?? this.chatEnabled,
      requiresApproval: requiresApproval ?? this.requiresApproval,
      isRecurring: isRecurring ?? this.isRecurring,
      recurringRule: recurringRule ?? this.recurringRule,
      trustScore: trustScore ?? this.trustScore,
      createdAt: createdAt,
      updatedAt: DateTime.now(),
    );
  }

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      category: EventCategory.values.firstWhere(
        (c) => c.name == json['category'],
        orElse: () => EventCategory.deportes,
      ),
      status: EventStatus.values.firstWhere(
        (s) => s.name == json['status'],
        orElse: () => EventStatus.open,
      ),
      privacy: EventPrivacy.values.firstWhere(
        (p) => p.name == json['privacy'],
        orElse: () => EventPrivacy.public,
      ),
      ambience: (json['ambience'] as List<dynamic>?)
              ?.map((e) => EventAmbience.values.firstWhere(
                    (a) => a.name == e,
                    orElse: () => EventAmbience.mixto,
                  ))
              .toList() ??
          const [],
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      address: json['address'] as String,
      placeName: json['place_name'] as String?,
      startTime: DateTime.parse(json['start_time'] as String),
      endTime: json['end_time'] != null
          ? DateTime.parse(json['end_time'] as String)
          : null,
      capacity: json['capacity'] as int?,
      attendeeCount: json['attendee_count'] as int? ?? 0,
      interestedCount: json['interested_count'] as int? ?? 0,
      checkedInCount: json['checked_in_count'] as int? ?? 0,
      organizerId: json['organizer_id'] as String,
      images: (json['images'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      tags: (json['tags'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      chatEnabled: json['chat_enabled'] as bool? ?? true,
      requiresApproval: json['requires_approval'] as bool? ?? false,
      isRecurring: json['is_recurring'] as bool? ?? false,
      recurringRule: json['recurring_rule'] as String?,
      trustScore: (json['trust_score'] as num?)?.toDouble() ?? 0.0,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'category': category.name,
        'status': status.name,
        'privacy': privacy.name,
        'ambience': ambience.map((e) => e.name).toList(),
        'latitude': latitude,
        'longitude': longitude,
        'address': address,
        'place_name': placeName,
        'start_time': startTime.toIso8601String(),
        'end_time': endTime?.toIso8601String(),
        'capacity': capacity,
        'attendee_count': attendeeCount,
        'interested_count': interestedCount,
        'checked_in_count': checkedInCount,
        'organizer_id': organizerId,
        'images': images,
        'tags': tags,
        'chat_enabled': chatEnabled,
        'requires_approval': requiresApproval,
        'is_recurring': isRecurring,
        'recurring_rule': recurringRule,
        'trust_score': trustScore,
        'created_at': createdAt.toIso8601String(),
        'updated_at': updatedAt.toIso8601String(),
      };
}

class ChatModel {
  final String id;
  final String eventId;
  final String? eventTitle;
  final List<String> participantIds;
  final String? lastMessage;
  final DateTime? lastMessageAt;
  final String? lastMessageSenderId;
  final int unreadCount;
  final bool isGroupChat;
  final DateTime createdAt;

  const ChatModel({
    required this.id,
    required this.eventId,
    this.eventTitle,
    required this.participantIds,
    this.lastMessage,
    this.lastMessageAt,
    this.lastMessageSenderId,
    this.unreadCount = 0,
    this.isGroupChat = false,
    required this.createdAt,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      id: json['id'] as String,
      eventId: json['event_id'] as String,
      eventTitle: json['event_title'] as String?,
      participantIds: (json['participant_ids'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      lastMessage: json['last_message'] as String?,
      lastMessageAt: json['last_message_at'] != null
          ? DateTime.parse(json['last_message_at'] as String)
          : null,
      lastMessageSenderId: json['last_message_sender_id'] as String?,
      unreadCount: json['unread_count'] as int? ?? 0,
      isGroupChat: json['is_group_chat'] as bool? ?? false,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }
}

class MessageModel {
  final String id;
  final String chatId;
  final String senderId;
  final String? senderName;
  final String? senderPhoto;
  final String content;
  final MessageType type;
  final DateTime createdAt;
  final bool isRead;

  const MessageModel({
    required this.id,
    required this.chatId,
    required this.senderId,
    this.senderName,
    this.senderPhoto,
    required this.content,
    this.type = MessageType.text,
    required this.createdAt,
    this.isRead = false,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['id'] as String,
      chatId: json['chat_id'] as String,
      senderId: json['sender_id'] as String,
      senderName: json['sender_name'] as String?,
      senderPhoto: json['sender_photo'] as String?,
      content: json['content'] as String,
      type: MessageType.values.firstWhere(
        (t) => t.name == json['type'],
        orElse: () => MessageType.text,
      ),
      createdAt: DateTime.parse(json['created_at'] as String),
      isRead: json['is_read'] as bool? ?? false,
    );
  }
}

enum MessageType {
  text,
  image,
  system,
  joinRequest,
}

class NotificationModel {
  final String id;
  final String title;
  final String body;
  final NotificationType type;
  final String? eventId;
  final String? senderId;
  final bool isRead;
  final DateTime createdAt;

  const NotificationModel({
    required this.id,
    required this.title,
    required this.body,
    required this.type,
    this.eventId,
    this.senderId,
    this.isRead = false,
    required this.createdAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'] as String,
      title: json['title'] as String,
      body: json['body'] as String,
      type: NotificationType.values.firstWhere(
        (t) => t.name == json['type'],
        orElse: () => NotificationType.general,
      ),
      eventId: json['event_id'] as String?,
      senderId: json['sender_id'] as String?,
      isRead: json['is_read'] as bool? ?? false,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }
}

enum NotificationType {
  general,
  eventNew,
  eventUpdate,
  eventCancelled,
  joinRequest,
  joinAccepted,
  joinRejected,
  chatMessage,
  checkin,
  reminder,
}
