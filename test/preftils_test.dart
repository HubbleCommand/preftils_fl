import 'package:flutter_test/flutter_test.dart';

import 'package:preftils/preftils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_async_platform_interface.dart';
import 'package:shared_preferences_platform_interface/in_memory_shared_preferences_async.dart';

void main() {
  test('deprecated', () async {
    SharedPreferences.setMockInitialValues({});
    PreferenceSync<int> intpref = PreferenceSync("integer", 3);

    expect(await intpref.get(), 3);

    intpref.set(7);
    expect(await intpref.get(), 7);
  });

  test('validate int', () async {
    SharedPreferencesAsyncPlatform.instance = InMemorySharedPreferencesAsync.empty();
    SharedPreferencesAsync prefs = SharedPreferencesAsync();
    Preference<int> intpref = Preference("integer", 3);

    expect(await intpref.get(prefs: prefs), 3);

    //These will fail, as expected
    //intpref.set("a");
    //SharedPreferences prefs = await SharedPreferences.getInstance();
    //intpref.set("a", prefs:prefs);

    intpref.set(7, prefs: prefs);
    expect(await intpref.get(), 7);
  });
}
