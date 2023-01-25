class Years{
  String year;
  Years({required this.year});


  factory Years.fromJson(Map<String, dynamic> json) => Years(
    year: json["years"],
  );


}