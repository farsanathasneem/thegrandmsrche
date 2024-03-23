class Restaurant {
  final String? name;
  final String? imageUrl;
  final String? neighborhood;
  final String? cuisineType;
  final String? address;
  final String? workingDays;
  final double rating;
  final int reviews;
  final double latitude;
  final double longitude;

  Restaurant({
    required this.name,
    required this.imageUrl,
    required this.neighborhood,
    required this.cuisineType,
    required this.address,
    required this.workingDays,
    required this.rating,
    required this.reviews,
    required this.latitude,
    required this.longitude,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      name: json['name'] ?? '', // Handle null name
      imageUrl: json['imageUrl'] ?? '', // Handle null imageUrl
      neighborhood: json['neighborhood'] ?? '', // Handle null neighborhood
      cuisineType: json['cuisineType'] ?? '', // Handle null cuisineType
      address: json['address'] ?? '', // Handle null address
      workingDays: json['workingDays'] ?? '', // Handle null workingDays
      rating: json['rating'] != null ? json['rating'].toDouble() : 0.0, // Handle null rating
      reviews: json['reviews'] ?? 0, // Handle null reviews
      latitude: json['latitude'] != null ? json['latitude'].toDouble() : 0.0, // Handle null latitude
      longitude: json['longitude'] != null ? json['longitude'].toDouble() : 0.0, // Handle null longitude
    );
  }
}
