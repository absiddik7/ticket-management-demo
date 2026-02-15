# Ticket Management App

A Flutter application for managing support tickets with contact management and user profile features. Built with BLoC state management and following best practices for maintainable code.

## Features

- **Ticket Screen**: Display and manage support tickets with filtering capabilities
- **Filter Screen**: Dynamic filter options simulating API response
- **Contact Screen**: Search and view team member contacts
- **Profile Screen**: User profile display with statistics

## Tech Stack

- **State Management**: flutter_bloc
- **Architecture**: Clean separation of concerns (core, data, bloc, ui)
- **API Simulation**: Static mock data mimicking API responses

## Project Structure

```
lib/
├── bloc/                    # Business Logic Components
│   ├── contact/            # Contact BLoC
│   ├── profile/            # Profile BLoC
│   └── ticket/             # Ticket BLoC with filtering
├── core/                   # Core utilities and constants
│   ├── constants/          # App colors, strings, dimensions
│   │   ├── app_colors.dart
│   │   ├── app_dimensions.dart
│   │   └── app_strings.dart
│   └── theme/              # App theme configuration
├── data/                   # Data layer
│   ├── models/             # Data models
│   │   ├── contact.dart
│   │   ├── filter.dart
│   │   ├── ticket.dart
│   │   └── user_profile.dart
│   └── repositories/       # Data repositories with mock data
└── ui/                     # Presentation layer
    ├── screens/            # App screens
    │   ├── main_screen.dart
    │   ├── ticket_screen.dart
    │   ├── filter_screen.dart
    │   ├── contact_screen.dart
    │   └── profile_screen.dart
    └── widgets/            # Reusable widgets
```

## Getting Started

### Prerequisites

- Flutter SDK (^3.9.2)
- Dart SDK

### Installation

1. Clone the repository
2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Run the app:
   ```bash
   flutter run
   ```

## Key Features Implementation

### Dynamic Filtering
The filter screen receives filter options from a simulated API call, allowing the number and type of filters to vary dynamically.

### State Management with BLoC
Each feature has its own BLoC:
- `TicketBloc`: Manages ticket list, filtering, and state
- `ContactBloc`: Handles contact search and list
- `ProfileBloc`: Manages user profile data

### Constants Management
All constants are centralized in separate files for easy maintenance:
- `app_colors.dart`: Color palette
- `app_strings.dart`: All text strings
- `app_dimensions.dart`: Size and spacing values

## Running Tests

```bash
flutter test
```

## Code Quality

```bash
flutter analyze
```
