/// Searched results based on the agify.io results
class SearchedName {
  /// Name used in the search
  final String name;

  /// Guessed age from the name
  final int age;

  /// Amount of times this name has been searched
  final int count;

  /// Country used in the search
  final String countryID;

  /// Constructor
  SearchedName({
    String? name,
    int? age,
    int? count,
    String? countryID,
  })  : this.name = name ?? "",
        this.age = age ?? 0,
        this.count = count ?? 0,
        this.countryID = countryID ?? "";

  /// Allows updating the entity by returning the updated version
  SearchedName copyWith({
    String? name,
    int? age,
    int? count,
    String? countryID,
  }) {
    return SearchedName(
        name: name ?? this.name,
        age: age ?? this.age,
        count: count ?? this.count,
        countryID: countryID ?? this.countryID);
  }

  /// Parses the class to json format
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'name': name,
      'age': age,
      'count': count,
      'countryID': countryID
    };
  }

  /// To parse the incoming API response
  factory SearchedName.fromJson(Map<String, dynamic> json) {
    return SearchedName(
        name: json['name'] as String?,
        age: json['age'] as int?,
        count: json['count'] as int?,
        countryID: json['countryID'] as String?);
  }

  @override
  String toString() {
    return 'SearchedName { name: $name, age: $age, count: $count, countryID: $countryID';
  }
}
