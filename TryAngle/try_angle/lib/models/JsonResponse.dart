class JsonResponse {


  final String title;
  final String gif;

  JsonResponse({this.title, this.gif});

  factory JsonResponse.fromJson(Map<String, dynamic> json) {
    return JsonResponse(
      title: json["data"]["title"],
      gif: json["data"]["image_url"]
    );
  }

}