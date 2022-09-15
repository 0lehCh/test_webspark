import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'utils/shared_preference_facade.dart';

GetIt getIt() {
  GetIt getIt = GetIt.instance;

  if (getIt.isRegistered<SharedPreferencesFacade>()) {
    return getIt;
  }


  getIt.registerSingletonAsync<SharedPreferencesFacade>(() async {
    final storage = await SharedPreferences.getInstance();
    return SharedPreferencesFacade(storage);
  });

  return getIt;
}

