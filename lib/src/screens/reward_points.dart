class RewardPoints {
  // Ensures end-users cannot initialize the class.
  RewardPoints._();

  static Future<RewardPoints> initializeApp({String? sourceApp}) async {
    return RewardPoints._();
  }
}
