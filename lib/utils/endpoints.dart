class Endpoints {
  static const baseUrl = 'http://35.239.72.106:8080';
  static const signIn = '$baseUrl/auth';
  static const signUp = '$baseUrl/users';
  static const getReportsUser = '$baseUrl/reports/user';
  static const sendReport = '$baseUrl/reports';
  static const updateUserdata = '$baseUrl/users';
  static const getAllReports = '$baseUrl/reports';
  static const sendEmail = '$baseUrl/users/send-password';
  static const finishReport = '$baseUrl/reports';
  static const getAllActiveReports = '$baseUrl/reports/active';
  static const getAllSolvedReports = '$baseUrl/reports/solved';
}
