class StreamingPlatform {
  final String name;
  final String type;
  final String logoUrl;
  final String deepLink;

  StreamingPlatform({
    required this.name,
    required this.type,
    required this.logoUrl,
    required this.deepLink,
  });

  factory StreamingPlatform.fromJson(Map<String, dynamic> json) {
    return StreamingPlatform(
      name: json['name'] ?? 'Plataforma',
      type: json['type'] ?? 'Streaming',
      logoUrl: json['logoUrl'] ?? 'https://images.unsplash.com/photo-1611162617474-5b21e879e113?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3',
      deepLink: json['deepLink'] ?? '',
    );
  }
}