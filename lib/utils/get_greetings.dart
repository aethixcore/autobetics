String getGreeting(bool isNewUser) {
  final now = DateTime.now();
  final hour = now.hour;

  if (isNewUser) {
    return 'Welcome!';
  } else {
    if (hour >= 5 && hour < 12) {
      return 'Good morning!';
    } else if (hour >= 12 && hour < 17) {
      return 'Good afternoon!';
    } else {
      return 'Good evening!';
    }
  }
}
