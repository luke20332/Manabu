# 🗾 Manabu

A small project iOS application built with Swift for learning Japanese language fundamentals through spaced repetition and active recall.

<p align="center">
  <img src="https://github.com/luke20332/Manabu/blob/main/images/home_screen.png" width="30%" />
  <img src="https://github.com/luke20332/Manabu/blob/main/images/guess_hiragana_streak.png" width="30%" />
  <img src="https://github.com/luke20332/Manabu/blob/main/images/play_options.png" width="30%" />
</p>

## Motivation
The motivation for building this application has brewed for a long time. When I was younger I neglected to learn the fundamentals of my mother's mother tongue. This is something which had long disappointed me, especially when being asked "Oh, do you speak Japanese?" I have to reply no.

This motivation culminated when I recently took a trip to Japan, and was intrigued at how the Japanese alphabets differed so greatly to the Latin alphabet. This presented itself as a challenge to me that I would like to finally conquer in my adult life - to finally learn the language.

I decided in January 2026 to create this application, as a double edged sword. The key motivator being that I would be able to learn the language, but also, it would improve upon my Swift programming skills, as I am free to implement the techniques and patterns myself.

### Offline-first approach

Like many other people, I unfortunately have the habit of doomscrolling in my free time, of which requires an internet connection.
This internet connection can be intermittent even in a big city, such as on public transport, or if I am in a plane.

My idea is to take an offline first approach, where the hiragana characters are very simply stored as a dictionary in the application. This way, it does not require internet connection in order to fetch what is needed in order to learn.


## Features

- **Interactive Lessons** - Learn Hiragana, Katakana, and basic Kanji
- **Practice Exercises** - Reinforce learning through quizzes and flashcards
- **Offline Support** - Access your lessons anytime, anywhere
- **Clean Architecture** - Built with MVVM and Coordinator patterns for maintainability

## Architecture

This project follows modern iOS development practices and design patterns:

### MVVM (Model-View-ViewModel)
- **Models** - Data structures representing game items, such as `GameMode`
- **Views** - UIKit views for displaying content, with the idea to extend to SwiftUI
- **ViewModels** - Handling the business logic, for the views to present.

### Coordinator Pattern
- Centralized navigation flow management
- Decoupled view controllers for better testability
- Clear separation of navigation concerns

### Key Swift Features
- **UserDefaults** - Persistent storage for user preferences and progress, such as the streak count
- **Completion Handlers** - Asynchronous operation handling
- **Error Handling** - Comprehensive error checking with custom error types
- **Protocols & Delegates** - Flexible communication between components

## Technical Stack

- **Language**: Swift 5.9+
- **Minimum iOS**: 15.0
- **Architecture**: MVVM + Coordinator Pattern
- **UI Framework**: UIKit
- **Data Persistence**: UserDefaults
- **Testing**: XCTest

## Future Features
As this is something that I have built from scratch, the possibilities of where this app can go are limitless. Some of the features listed draw inspiration from other language learning applications.
- The drawing game. Draw a hiragana character in order to guess the romanji translation
- The listening game.
- Silent notifications to fetch data?


## Getting Started

### Prerequisites
- Xcode 14.0 or later
- iOS 15.0 or later
- macOS 12.0 or later

### Installation

1. Clone the repository
```bash
git clone https://github.com/yourusername/japanese-learning-app.git
```

2. Open the project in Xcode
```bash
cd japanese-learning-app
open JapaneseLearningApp.xcodeproj
```

3. Build and run
- Select your target device or simulator
- Press `Cmd + R` to build and run

## Contributing

For anyone who may wish to contribute, I would be very grateful! Please create a pull request and I will endeavour to look into it.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Author

Luke Sakaguchi-Mawer 

Project Link: [[https://github.com/yourusername/japanese-learning-app](https://github.com/yourusername/japanese-learning-app)]

## Acknowledgments

- Icons from [SF Symbols](https://developer.apple.com/sf-symbols/)
- Inspired by my family.

