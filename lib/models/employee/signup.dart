class EmployeeRegisterRequest {
  EmployeeRegisterRequest({
    required this.username,
    required this.fullName,
    required this.password,
    required this.roleId,
  });

  String username;
  String fullName;
  String password;
  int roleId;

  factory EmployeeRegisterRequest.fromJson(Map<String, dynamic> json) =>
      EmployeeRegisterRequest(
        username: json['username'],
        fullName: json['fullName'],
        password: json['password'],
        roleId: json['RoleId'],
      );

  Map<String, dynamic> toJson() => {
        'username': username,
        'fullname': fullName,
        'password': password,
        'RoleId': roleId,
      };
}
