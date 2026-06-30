class ApiConstants {
  // Auth
  static const String login = '/auth/login';
  static const String logout = '/auth/logout';
  static const String changePassword = '/auth/change-password';

  // SS
  static const String ssStats = '/ss/stats';
  static const String ssMonthlyStats = '/ss/stats'; // + /{nrp}/monthly
  static const String ssByNrp = '/ss/by-nrp';
  static const String ssList = '/ss';

  // ESIC
  static const String esicByNrp = '/esic/by-nrp';
  static const String esicCompare = '/esic/compare';

  // Dept
  static const String deptStats = '/ss/dept/stats';
  static const String deptDaily = '/ss/dept/daily';
  static const String deptEiictm = '/ss/dept/eiictm';

  // PIN
  static const String pinGenerate = '/upload/pin';
  static const String pinVerify = '/upload/verify-pin';
}
