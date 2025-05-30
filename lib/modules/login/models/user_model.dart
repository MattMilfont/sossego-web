class UserModel {
  String? message;
  String? token;
  User? user;

  UserModel({this.message, this.token, this.user});

  UserModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    token = json['token'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['token'] = this.token;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
  String? cpf;
  String? email;
  int? id;
  String? name;
  String? phoneNumber;
  String? rg;

  User({this.cpf, this.email, this.id, this.name, this.phoneNumber, this.rg});

  User.fromJson(Map<String, dynamic> json) {
    cpf = json['cpf'];
    email = json['email'];
    id = json['id'];
    name = json['name'];
    phoneNumber = json['phoneNumber'];
    rg = json['rg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cpf'] = this.cpf;
    data['email'] = this.email;
    data['id'] = this.id;
    data['name'] = this.name;
    data['phoneNumber'] = this.phoneNumber;
    data['rg'] = this.rg;
    return data;
  }
}
