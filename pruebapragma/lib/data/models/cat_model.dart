class CatModel {
  final String url;
  final String name;
  final String origin;
  final String temperament;
  final String description;
  final int intelligence;
  final int adaptability;
  final String life_span;

  CatModel({
    required this.url,
    required this.name,
    required this.origin,
    required this.temperament,
    required this.description,
    required this.intelligence,
    required this.adaptability,
    required this.life_span,
  });

  factory CatModel.fromJson(Map<String, dynamic> json) {
    return CatModel(
      url: json['image'] != null ? json['image']['url'] ?? '' : '',
      name: json['name'] ?? 'Sin nombre',
      origin: json['origin'] ?? 'Desconocido',
      temperament: json['temperament'] ?? 'No especificado',
      description: json['description'] ?? 'No tiene descripcion',
      intelligence: json['intelligence'] ?? 'No tiene inteligencia',
      adaptability: json['adaptability'] ?? 'No tiene adaptabilidad',
      life_span: json['life_span'] ?? 'No tiene tiempo de vida',
    );
  }
}
