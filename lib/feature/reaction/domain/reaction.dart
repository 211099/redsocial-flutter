class Reaction {
  final String uuid;
  final String idUser;
  final String idPublicaciones;
  final bool reaction;
  final String type;
  Reaction({
    required this.uuid,
    required this.idUser,
    required this.idPublicaciones,
    required this.reaction,
    required this.type
  });
}