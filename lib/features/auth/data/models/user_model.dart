import 'package:flutter/material.dart';

enum EventCategory {
  deportes('Deportes', Icons.sports_soccer, Color(0xFF00B894)),
  musica('Música', Icons.music_note, Color(0xFF6C5CE7)),
  arte('Arte', Icons.palette, Color(0xFFFD79A8)),
  gastronomia('Gastronomía', Icons.restaurant, Color(0xFFFDCB6E)),
  networking('Networking', Icons.handshake, Color(0xFF0984E3)),
  gaming('Gaming', Icons.sports_esports, Color(0xFFE17055)),
  outdoor('Outdoor', Icons.terrain, Color(0xFF00CEC9)),
  cultura('Cultura', Icons.theater_comedy, Color(0xFFA29BFE)),
  fiesta('Fiesta', Icons.celebration, Color(0xFFFF6B81)),
  fitness('Fitness', Icons.fitness_center, Color(0xFF20BF6B)),
  educacion('Educación', Icons.school, Color(0xFF4B7BEC)),
  voluntariado('Voluntariado', Icons.volunteer_activism, Color(0xFFFC5C65));

  const EventCategory(this.label, this.icon, this.color);
  final String label;
  final IconData icon;
  final Color color;
}

enum EventStatus {
  draft('Borrador'),
  open('Abierto'),
  almostFull('Casi lleno'),
  full('Lleno'),
  active('Activo ahora'),
  finished('Terminado'),
  cancelled('Cancelado');

  const EventStatus(this.label);
  final String label;
}

enum EventPrivacy {
  public('Público'),
  approval('Aprobación'),
  private_('Privado');

  const EventPrivacy(this.label);
  final String label;
}

enum EventAmbience {
  tranquilo('Tranqui'),
  competitivo('Competitivo'),
  familiar('Familiar'),
  afterOffice('After Office'),
  principiante('Principiante'),
  pro('Pro'),
  petFriendly('Pet Friendly'),
  mixto('Mixto');

  const EventAmbience(this.label);
  final String label;
}

enum RsvpStatus {
  interested('Interesado'),
  reserved('Reservado'),
  confirmed('Confirmado'),
  checkedIn('Llegó'),
  cancelled('Canceló');

  const RsvpStatus(this.label);
  final String label;
}

enum JoinRequestStatus {
  pending('Pendiente'),
  accepted('Aceptado'),
  rejected('Rechazado');

  const JoinRequestStatus(this.label);
  final String label;
}

class UserModel {
  final String id;
  final String name;
  final String? lastName;
  final DateTime? birthDate;
  final String? photoUrl;
  final List<String> photos;
  final String? bio;
  final List<EventCategory> interests;
  final double? latitude;
  final double? longitude;
  final String? city;
  final bool isVerified;
  final int eventsCreated;
  final int eventsAttended;
  final double trustScore;
  final DateTime createdAt;

  const UserModel({
    required this.id,
    required this.name,
    this.lastName,
    this.birthDate,
    this.photoUrl,
    this.photos = const [],
    this.bio,
    this.interests = const [],
    this.latitude,
    this.longitude,
    this.city,
    this.isVerified = false,
    this.eventsCreated = 0,
    this.eventsAttended = 0,
    this.trustScore = 0.0,
    required this.createdAt,
  });

  String get displayName => lastName != null ? '$name $lastName' : name;

  int? get age {
    if (birthDate == null) return null;
    final now = DateTime.now();
    var age = now.year - birthDate!.year;
    if (now.month < birthDate!.month ||
        (now.month == birthDate!.month && now.day < birthDate!.day)) {
      age--;
    }
    return age;
  }

  UserModel copyWith({
    String? name,
    String? lastName,
    DateTime? birthDate,
    String? photoUrl,
    List<String>? photos,
    String? bio,
    List<EventCategory>? interests,
    double? latitude,
    double? longitude,
    String? city,
    bool? isVerified,
    int? eventsCreated,
    int? eventsAttended,
    double? trustScore,
  }) {
    return UserModel(
      id: id,
      name: name ?? this.name,
      lastName: lastName ?? this.lastName,
      birthDate: birthDate ?? this.birthDate,
      photoUrl: photoUrl ?? this.photoUrl,
      photos: photos ?? this.photos,
      bio: bio ?? this.bio,
      interests: interests ?? this.interests,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      city: city ?? this.city,
      isVerified: isVerified ?? this.isVerified,
      eventsCreated: eventsCreated ?? this.eventsCreated,
      eventsAttended: eventsAttended ?? this.eventsAttended,
      trustScore: trustScore ?? this.trustScore,
      createdAt: createdAt,
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      name: json['name'] as String,
      lastName: json['last_name'] as String?,
      birthDate: json['birth_date'] != null
          ? DateTime.parse(json['birth_date'] as String)
          : null,
      photoUrl: json['photo_url'] as String?,
      photos: (json['photos'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      bio: json['bio'] as String?,
      interests: (json['interests'] as List<dynamic>?)
              ?.map((e) => EventCategory.values.firstWhere(
                    (c) => c.name == e,
                    orElse: () => EventCategory.deportes,
                  ))
              .toList() ??
          const [],
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      city: json['city'] as String?,
      isVerified: json['is_verified'] as bool? ?? false,
      eventsCreated: json['events_created'] as int? ?? 0,
      eventsAttended: json['events_attended'] as int? ?? 0,
      trustScore: (json['trust_score'] as num?)?.toDouble() ?? 0.0,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'last_name': lastName,
        'birth_date': birthDate?.toIso8601String(),
        'photo_url': photoUrl,
        'photos': photos,
        'bio': bio,
        'interests': interests.map((e) => e.name).toList(),
        'latitude': latitude,
        'longitude': longitude,
        'city': city,
        'is_verified': isVerified,
        'events_created': eventsCreated,
        'events_attended': eventsAttended,
        'trust_score': trustScore,
        'created_at': createdAt.toIso8601String(),
      };
}
