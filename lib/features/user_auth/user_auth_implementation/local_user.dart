class LocalUser {
  final String id;
  final String email;
  final String? displayName;
  final String? phoneNumber;

  LocalUser({
    required this.id,
    required this.email,
    this.displayName,
    this.phoneNumber,
  });
}
