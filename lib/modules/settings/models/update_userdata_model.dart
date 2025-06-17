class UpdateUserdataModel {
  int? id;
  String? name;
  String? email;
  String? password;
  String? birthDate;
  String? phone;
  String? cpf;
  String? rg;

  UpdateUserdataModel({
    this.id,
    this.name,
    this.email,
    this.password,
    this.birthDate,
    this.phone,
    this.cpf,
    this.rg,
  });

  UpdateUserdataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
    birthDate = json['birth_date'];
    phone = json['phone'];
    cpf = json['cpf'];
    rg = json['rg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['password'] = this.password;
    data['birth_date'] = this.birthDate;
    data['phone'] = this.phone;
    data['cpf'] = this.cpf;
    data['rg'] = this.rg;
    return data;
  }
}
