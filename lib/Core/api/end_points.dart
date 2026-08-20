class EndPoints {
  static const String baseUrl = "https://enjaz.anisth.com/api";
  static const String imageUrl = "https://enjaz.anisth.com/api";

  //Auth
  static const String loginUrl = "$baseUrl/citizen/auth/login";
  static const String logOutUrl = "$baseUrl/citizen/auth/logout";

  //transactions
  static const String transactionsPageUrl = "$baseUrl/v1/transactions/inbox";
  static const String detailesTransactionsPageUrl =
      "$baseUrl/v1/transactions/show/";
  static const String changeStatusUrl = "$baseUrl/v1/transactions/process";
  static const String addRepliyUrl = "$baseUrl/v1/transactions/comment/";

  //notification
  static const String notificationUrl = "$baseUrl/v1/notifications/employee";
  static const String getNumberNotificationsUrl =
      "$baseUrl/v1/notifications/unread-count";
}
