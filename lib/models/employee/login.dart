class UserLoginRequest {
  UserLoginRequest({
    required this.username,
    required this.password,
  });
  late final String username;
  late final String password;

  UserLoginRequest.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    password = json['password'];
  }

  Map<String, String> toJson() {
    final data = <String, String>{};
    data['username'] = username;
    data['password'] = password;
    return data;
  }
}

class LoginResponse {
  LoginResponse(
      {required this.status, required this.data, required this.token});

  String status;
  Employee data;
  String token;

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
      status: json['status'],
      data: Employee.fromJson(json['data']),
      token: json['token']);

  Map<String, dynamic> toJson() => {
        'status': status,
        'data': data.toJson(),
        'token': token,
      };
}

class Employee {
  Employee(
      {required this.fullname, required this.username, required this.roleId});

  String fullname;
  String username;
  int roleId;

  factory Employee.fromJson(Map<String, dynamic> json) => Employee(
      fullname: json['fullname'],
      username: json['username'],
      roleId: json['RoleId']);

  Map<String, dynamic> toJson() =>
      {'fullname': fullname, 'username': username, 'RoleId': roleId};
}
