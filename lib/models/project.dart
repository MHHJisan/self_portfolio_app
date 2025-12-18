class Project {
final String title;
final String description;
final String image;
final List<String> tags;
final String? liveUrl;
final String githubUrl;
final String type;

  Project ({
   required this.title,
   required this.description,
   required this.image,
   required this.tags,
   required this.liveUrl,
   required this.githubUrl,
   required this.type,
  });
}