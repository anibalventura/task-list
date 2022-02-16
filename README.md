# Task List

[![Flutter](https://img.shields.io/static/v1?label=Flutter&message=2.10.1&color=blue)](https://flutter.dev/)
[![Null Safety](https://img.shields.io/static/v1?label=Null+Safety&message=YES&color=success)](https://flutter.dev/docs/null-safety)
[![Flutter Support](https://img.shields.io/static/v1?label=Support&message=Android%20|%20iOS|%20Web&color=blue)]()
[![Style: very good analysis](https://img.shields.io/badge/Style-very_good_analysis-B22C89.svg)](https://pub.dev/packages/very_good_analysis)
[![License](https://img.shields.io/static/v1?label=License&message=MIT&color=blue)](LICENSE.md)

<img src="assets/images/repository_banner.png" align="center"/>

Task list app as an example to consume the [Task List API](https://github.com/anibalventura/task-list-rest-api).

## Features

- Splash screen and one time intro screen.
- Add, edit, delete tasks locally and from API.
- Swipe left to edit and right to delete.
- Pull to refresh from API.
- Dark mode support.
- Languages: English and Spanish.

## Build

1. Run the [Task List API](https://github.com/anibalventura/task-list-rest-api).
2. Change the PORT number on `/assets/.env` file.
```
API_URL=https://localhost:PORT_NUMBER/api/Task

// Used for Android Emulator
AVD_API_URL=https://10.0.2.2:PORT_NUMBER/api/Task
```

## Dependencies

- [flutter_dotenv](https://pub.dev/packages/flutter_dotenv)
- [flutter_screenutil](https://pub.dev/packages/flutter_screenutil)
- [flutter_svg](https://pub.dev/packages/flutter_svg)
- [font_awesome_flutter](https://pub.dev/packages/font_awesome_flutter)
- [google_fonts](https://pub.dev/packages/google_fonts)
- [http](https://pub.dev/packages/http)
- [introduction_screen](https://pub.dev/packages/introduction_screen)
- [liquid_progress_indicator](https://pub.dev/packages/liquid_progress_indicator)
- [provider](https://pub.dev/packages/provider)
- [pull_to_refresh](https://pub.dev/packages/pull_to_refresh)

### Dev Dependencies

- [change_app_package_name](https://pub.dev/packages/change_app_package_name)
- [flutter_ameno_ipsum](https://pub.dev/packages/flutter_ameno_ipsum)
- [flutter_launcher_icons](https://pub.dev/packages/flutter_launcher_icons)
- [flutter_native_splash](https://pub.dev/packages/flutter_native_splash)
- [very_good_analysis](https://pub.dev/packages/very_good_analysis)

## License

```xml
MIT License

Copyright (c) 2022 Anibal Ventura
```
