class Movie {
  final int rank;
  final String title;
  final String description;
  final String image;
  final String bigImage;
  final List<String> genre;
  final String thumbnail;
  final String rating;
  final String id;
  final int year;
  final String imdbid;
  final String imdbLink;

  Movie({
    required this.rank,
    required this.title,
    required this.description,
    required this.image,
    required this.bigImage,
    required this.genre,
    required this.thumbnail,
    required this.rating,
    required this.id,
    required this.year,
    required this.imdbid,
    required this.imdbLink,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      rank: json['rank'] ?? 0,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      image: json['image'] ?? '',
      bigImage: json['big_image'] ?? '',
      genre: json['genre'] is List
          ? List<String>.from(json['genre'])
          : json['genre'] is String
              ? json['genre']
                  .toString()
                  .split(',')
                  .map((e) => e.trim())
                  .toList()
              : [],
      thumbnail: json['thumbnail'] ?? '',
      rating: json['rating'] ?? '',
      id: json['id'] ?? '',
      year: json['year'] ?? 0,
      imdbid: json['imdbid'] ?? '',
      imdbLink: json['imdb_link'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'rank': rank,
      'title': title,
      'description': description,
      'image': image,
      'big_image': bigImage,
      'genre': genre,
      'thumbnail': thumbnail,
      'rating': rating,
      'id': id,
      'year': year,
      'imdbid': imdbid,
      'imdb_link': imdbLink,
    };
  }

  Map<String, dynamic> toMap() {
    return {
      'rank': rank,
      'title': title,
      'description': description,
      'image': image,
      'bigImage': bigImage,
      'genre': genre.join(','),
      'thumbnail': thumbnail,
      'rating': rating,
      'id': id,
      'year': year,
      'imdbid': imdbid,
      'imdbLink': imdbLink,
    };
  }

  factory Movie.fromMap(Map<String, dynamic> map) {
    return Movie(
      rank: map['rank'] ?? 0,
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      image: map['image'] ?? '',
      bigImage: map['bigImage'] ?? '',
      genre: map['genre'] != null
          ? map['genre'].toString().split(',').map((e) => e.trim()).toList()
          : [],
      thumbnail: map['thumbnail'] ?? '',
      rating: map['rating'] ?? '',
      id: map['id'] ?? '',
      year: map['year'] ?? 0,
      imdbid: map['imdbid'] ?? '',
      imdbLink: map['imdbLink'] ?? '',
    );
  }
}
