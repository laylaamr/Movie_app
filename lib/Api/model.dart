class Movie {
  final int rank; // Unique rank for the movie
  final String title;
  final String description;
  final String image;
  final String bigImage;
  final List<String> genre;
  final String thumbnail;
  final String rating;
  final String id; // Retained for other uses, but will not be the primary key in the DB
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
    required this.id, // Keep this for API or other uses
    required this.year,
    required this.imdbid,
    required this.imdbLink,
  });

  // Manual JSON parsing
  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      rank: json['rank'],
      title: json['title'],
      description: json['description'],
      image: json['image'],
      bigImage: json['big_image'],
      genre: List<String>.from(json['genre']),
      thumbnail: json['thumbnail'],
      rating: json['rating'],
      id: json['id'], // Retain id from JSON if it's needed
      year: json['year'],
      imdbid: json['imdbid'],
      imdbLink: json['imdb_link'],
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
      'id': id, // Include the id in the JSON for API use
      'year': year,
      'imdbid': imdbid,
      'imdb_link': imdbLink,
    };
  }

  // Manual Map parsing for database
  Map<String, dynamic> toMap() {
    return {
      'rank': rank, // Use rank instead of id for the database
      'title': title,
      'description': description,
      'image': image,
      'bigImage': bigImage,
      'genre': genre.join(','), // Store genre as a comma-separated string
      'thumbnail': thumbnail,
      'rating': rating,
      'id': id, // Keep id for API handling
      'year': year,
      'imdbid': imdbid,
      'imdbLink': imdbLink,
    };
  }

  factory Movie.fromMap(Map<String, dynamic> map) {
    return Movie(
      rank: map['rank'], // Use rank as the primary key
      title: map['title'],
      description: map['description'],
      image: map['image'],
      bigImage: map['bigImage'],
      genre: map['genre'].split(','), // Split genre string into a list
      thumbnail: map['thumbnail'],
      rating: map['rating'],
      id: map['id'], // Retain id if needed for other purposes
      year: map['year'],
      imdbid: map['imdbid'],
      imdbLink: map['imdbLink'],
    );
  }
}

