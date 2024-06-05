enum Gender {
  male,
  female;

  @override
  String toString() => switch (this) {
        Gender.male => "Erkek",
        Gender.female => "Kadın",
      };
}
