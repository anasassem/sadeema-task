class UserEntity {
  final int id;
  final String phoneOrEmail;
  final String token;
  final String notiId;
  final String mobileId;
  final String mobileType;
  final String type;

  UserEntity({
    required this.id,
    required this.phoneOrEmail,
    required this.token,
    required this.notiId,
    required this.mobileId,
    required this.mobileType,
    required this.type,
  });
}