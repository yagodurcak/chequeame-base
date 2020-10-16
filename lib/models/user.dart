class User {
  final String id;
  final String fullName;
  final String email;

  int queries;

  User({this.id, this.fullName, this.email, this.queries});

  User.fromData(Map<String, dynamic> data)
      : id = data['id'],
        fullName = data['fullName'],
        email = data['email'],
        queries = data["queries"];

  incQuery() {
    queries += 1;
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'fullName': fullName, 'email': email, "queries": queries};
  }
}
