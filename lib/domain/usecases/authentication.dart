import 'package:flutter/cupertino.dart';

import '../entities/entities.dart';

abstract class Authentication {
  Future<Account> auth({
      @required String email, 
      @required String password
    });
}