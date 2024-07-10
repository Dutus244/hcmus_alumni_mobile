class Alumni {
  final int graduationYear;
  final String alumClass;

  Alumni(this.graduationYear, this.alumClass);

  Alumni.fromJson(Map<String, dynamic> json)
      : graduationYear = json["graduationYear"],
        alumClass = json["alumClass"];
}
