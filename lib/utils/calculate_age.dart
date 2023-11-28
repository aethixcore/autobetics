
int calculateAge(String birthdateString) {
  // Parse the birthdate string to DateTime
  DateTime birthdate = DateTime.parse(birthdateString);

  // Get the current date
  DateTime currentDate = DateTime.now();

  // Calculate the difference in years
  int age = currentDate.year - birthdate.year;

  // Adjust the age based on the current date and birthdate
  if (currentDate.month < birthdate.month ||
      (currentDate.month == birthdate.month && currentDate.day < birthdate.day)) {
    age--;
  }

  return age;
}