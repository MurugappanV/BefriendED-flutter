// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:befriended_flutter/local_storage/local_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_services_binding/flutter_services_binding.dart';
import 'package:befriended_flutter/bootstrap.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  FlutterServicesBinding.ensureInitialized();
  await Firebase.initializeApp();

  final localStorage = LocalStorage(
    plugin: await SharedPreferences.getInstance(),
  );

  bootstrap(localStorage);
}