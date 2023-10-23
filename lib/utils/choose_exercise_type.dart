String chooseExerciseType(int age, double bloodSugar) {
  String exerciseType;

  if (age < 30) {
    if (bloodSugar < 140) {
      exerciseType = "Cardio";
    } else {
      exerciseType = "Plyometrics";
    }
  } else {
    if (bloodSugar < 140) {
      exerciseType = "Strength";
    } else {
      exerciseType = "Stretching";
    }
  }

  // You can add more conditions based on the "strongman" type or refine these rules as needed.

  return exerciseType;
}
