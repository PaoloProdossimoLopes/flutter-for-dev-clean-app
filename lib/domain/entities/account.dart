class Account {
  final String token;

  Account(this.token);

  factory Account.from_json(Map json) => Account(json['accessToken']);
}