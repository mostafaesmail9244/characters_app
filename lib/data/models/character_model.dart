class CharacterModel {
  final int? id;
  final String? name;
  final String? status;
  final String? species;
  final String? type;
  final String? gender;
  final Origin? origin;
  final Location? location;
  final String? image;
  final List? episode;
  final String? url;
  final String? created;

  CharacterModel(
      {this.id,
      this.name,
      this.status,
      this.species,
      this.type,
      this.gender,
      this.origin,
      this.location,
      this.image,
      this.episode,
      this.url,
      this.created});
  factory CharacterModel.fromJson(json) {
    return CharacterModel(
        id: json['id'],
        name: json['name'],
        status: json['status'],
        species: json['species'],
        type: json['type'],
        gender: json['gender'],
        origin: Origin.fromJson(json['origin']),
        location: Location.fromJson(json['location']),
        image: json['image'],
        episode: json['episode'],
        url: json['url'],
        created: json['created']);
  }
}

class Origin {
  final String name;
  final String url;

  Origin({required this.name, required this.url});
  factory Origin.fromJson(json) {
    return Origin(name: json['name'], url: json['url']);
  }
}

class Location {
  final String name;
  final String url;

  Location({required this.name, required this.url});
  factory Location.fromJson(json) {
    return Location(name: json['name'], url: json['url']);
  }
}
