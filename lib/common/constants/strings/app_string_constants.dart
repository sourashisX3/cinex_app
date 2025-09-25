class AppStringConstants {
  AppStringConstants._();

  /// onboarding screen
  static const String onBoardingTitle1 = "Watch movies anytime,\nanywhere";
  static const String onBoardingTitle2 = "We have the\nbest movies";
  static const String onBoardingTitle3 = "Download and\nwatch offline";

  /// auth screens
  static const String login = "Login";
  static const String signUp = "Sign Up";
  static const String password= "Password";
  static const String confirmPassword = "Confirm Password";
  static const String welcomeMessage = "Welcome to the Cinex App!";
  static const String newUserMessage = "New user? Sign Up here";
  static const String existingUserMessage = "Already have an account?";
  static const String dontHaveAnAccount = "Don't have an account?";
  static const String enterFullName = "Enter your full name";
  static const String enterPhoneNumber = "Enter your phone number";
  static const String enterEmail = "Enter your email";
  static const String enterPassword = "Enter your password";
  static const String enterConfirmPassword = "Re-enter your password";


  /// home screen
  static String homeTitle(String userName) => "Hello, $userName";
  static const String homeSubTitle = "What do you want to watch today?";
  static const String trendingMovies = "Trending Movies";
  static const String upcomingMovies = "Upcoming Movies";
  static const String topRatedMovies = "Top Rated Movies";
  static const String viewAll = "View All";

  /// profile screen
  static const String profile = "Your Profile";
  static const String fullName = "Full Name";
  static const String emailAddress = "Email Address";
  static const String phoneNumber = "Phone Number";
  static const String editNow = "Edit Now";
  static const String doYouWantToEditYourProfile =
      "Do you want to edit your profile?\n";

  /// details screen
  static const String genres = "Genres";
  static const String overview = "Overview";
  static String releasedOn(String date) => "Released on $date";

  /// search screen
  static const String searchMovies = "Search Movies";
}
