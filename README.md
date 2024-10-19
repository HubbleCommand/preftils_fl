A Flutter plugin that adds type safety when working with SharedPreferences.

[![pub package](https://img.shields.io/pub/v/preftils.svg)](https://pub.dev/packages/preftils)


## Features

Adds type safety to avoid runtime crashes when working with the amazing [shared_preferences](https://pub.dev/packages/shared_preferences) package.


## Usage
Create your `Preference` objects:

```dart
const intPreference = Preference<int>("integer", 3);
```

Set it's value:

```dart
intPreference.set(7);
//If you already have an instance of SharedPreferences, you should pass it:
intPreference.set(7, prefs: await SharedPreferences.getInstance());
```

And read it:

```dart
int currentPreferenceValue = await intPreference.get();
```

If you already have an instance of `SharedPreference`, you can synchronously read values:

```dart
SharedPreferences prefs = await SharedPreferences.getInstance();
int currentPreferenceValue = intPreference.getSync(prefs);
```


## Additional information
This is the Flutter version of my [Android Preftils](https://github.com/HubbleCommand/preftils) package.
You can read more about the reason behind this package [here](https://hubblecommand.github.io/projects/preftils.html).
