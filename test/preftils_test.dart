import 'package:flutter_test/flutter_test.dart';

import 'package:preftils/preftils.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  test('validate int', () async {
    SharedPreferences.setMockInitialValues({});
    Preference<int> intpref = Preference("integer");

    expect(await intpref.get(), 3);

    //These will fail, as expected
    //intpref.set("a");
    //SharedPreferences prefs = await SharedPreferences.getInstance();
    //intpref.set("a", prefs:prefs);

    intpref.set(7);
    expect(await intpref.get(), 7);
  });
}
