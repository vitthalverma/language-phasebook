# 🌍 Travel Phrasebook

Welcome to the **Travel Phrasebook** app! This application is designed to help travelers communicate effortlessly in foreign countries by providing essential phrases in various languages.

## 🚀 Features

- **Multi-language Support**: Choose from a wide range of languages to find the phrase you need.
- **Audio Playback**: Hear the correct pronunciation of phrases to improve your communication.
- **Favorites**: Save your most-used phrases for quick access.
- **Translation**: Translate phrases between languages to better understand the context.

## 🛠️ Tech Stack

- **Flutter**: The app is built with Flutter, ensuring a smooth and responsive user experience across platforms.
- **Clean Architecture**: Organized code structure following clean architecture principles.
- **LibreTranslate API**: Used for translating text between languages.
- **VoiceRSS API**: For generating and playing back audio phrases.

## 📚 External Libraries

The following libraries are used in the project:

- **[audioplayers](https://pub.dev/packages/audioplayers)**: For playing audio files across platforms.
- **[path_provider](https://pub.dev/packages/path_provider)**: To access device paths and store temporary files.
- **[just_audio](https://pub.dev/packages/just_audio)**: Alternative audio playback library for advanced use cases.
- **[http](https://pub.dev/packages/http)**: Simplified HTTP client for API requests.

## 📝 Setup Instructions

Follow these steps to set up the project locally:

### 1. Clone the Repository

```bash
git clone https://github.com/your-username/travel-phrasebook.git
cd travel-phrasebook
```
### 2. Install dependencies

```bash
flutter pub get
```
### 3. Run the app 

```bash
flutter run
```

## 💡 Approach

The app is structured using clean architecture, separating concerns across different layers:

- **Presentation Layer: Handles UI components and state management.
- **Domain Layer: Business logic and use cases.
- **Data Layer: Manages API calls and data storage.

## Challenges Faced

- **Handling Byte Data on iOS: iOS does not support direct playback of byte data using the audioplayers package. This was mitigated by saving the byte data as a temporary file and then playing it.
- **API Integration: Ensuring seamless integration with translation and TTS APIs while managing errors effectively.


