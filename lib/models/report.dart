class Report {
  int confirmed;
  int recovered;
  int deaths;
  String country;
  int population;
  int sqKmArea;
  String lifeExpectancy;
  String continent;
  String abbreviation;
  String location;
  int iso;
  String capitalCity;
  String lat;
  String long;
  String updated;

  Report({
    this.confirmed,
    this.recovered,
    this.deaths,
    this.country,
    this.population,
    this.sqKmArea,
    this.lifeExpectancy,
    this.continent,
    this.abbreviation,
    this.location,
    this.iso,
    this.capitalCity,
    this.lat,
    this.long,
    this.updated,
  });

  Report.fromJson(Map<String, dynamic> json) {
    confirmed = json["confirmed"] ?? 0;
    recovered = json["recovered"] ?? 0;
    deaths = json["deaths"] ?? 0;
    country = json["country"] ?? "";
    population = json["population"] ?? 0;
    sqKmArea = json["sq_km_area"] ?? 0;
    lifeExpectancy = json["life_expectancy"] ?? "";
    continent = json["continent"] ?? "";
    abbreviation = json["abbreviation"] ?? "";
    location = json["location"] ?? "";
    iso = json["iso"] ?? 0;
    capitalCity = json["capital_city"] ?? "";
    lat = json["lat"] ?? "";
    long = json["long"] ?? "";
    updated = json["updated"] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data["confirmed"] = this.confirmed;
    data["recovered"] = this.recovered;
    data["deaths"] = this.deaths;
    data["country"] = this.country;
    data["population"] = this.population;
    data["sq_km_area"] = this.sqKmArea;
    data["life_expectancy"] = this.lifeExpectancy;
    data["continent"] = this.continent;
    data["abbreviation"] = this.abbreviation;
    data["location"] = this.location;
    data["iso"] = this.iso;
    data["capital_city"] = this.capitalCity;
    data["lat"] = this.lat;
    data["long"] = this.long;
    data["updated"] = this.updated;

    return data;
  }
}

class History {
  String country;
  int population;
  int sqKmArea;
  String lifeExpectancy;
  String continent;
  String abbreviation;
  String location;
  int iso;
  String capitalCity;
  Map<String, int> dates;

  History(
      {this.country,
      this.population,
      this.sqKmArea,
      this.lifeExpectancy,
      this.continent,
      this.abbreviation,
      this.location,
      this.iso,
      this.capitalCity,
      this.dates});

  History.fromJson(Map<String, dynamic> json) {
    country = json["country"] ?? "";
    population = json["population"] ?? 0;
    sqKmArea = json["sq_km_area"] ?? 0;
    lifeExpectancy = json["life_expectancy"] ?? "";
    continent = json["continent"] ?? "";
    abbreviation = json["abbreviation"] ?? "";
    location = json["location"] ?? "";
    iso = json["iso"] ?? 0;
    capitalCity = json["capital_city"] ?? "";
    dates = Map<String, int>.from(json["dates"] ?? {});
  }
}
