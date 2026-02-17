# 🎫 Ticket Management App

### A Professional Flutter Application for Enterprise Support Ticket Management

[![Flutter](https://img.shields.io/badge/Flutter-3.9+-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.9+-0175C2?style=for-the-badge&logo=dart&logoColor=white)](https://dart.dev)
[![BLoC](https://img.shields.io/badge/BLoC-8.1.6-blue?style=for-the-badge)](https://bloclibrary.dev)

*A feature-rich, production-ready ticket management application built with Flutter, demonstrating modern mobile development practices, clean architecture, and robust state management.*

---

## 📋 Table of Contents

- [Overview](#-overview)
- [Features](#-features)
- [Screenshots](#-screenshots)
- [Demo Video](#-demo-video)
- [Architecture](#-architecture)
- [Implementation Approach](#-implementation-approach)
- [Tech Stack](#-tech-stack)
- [Project Structure](#-project-structure)
- [State Management](#-state-management-bloc-pattern)
- [Data Models](#-data-models)
- [UI Components](#-ui-components)
- [Getting Started](#-getting-started)
- [Design Decisions](#-design-decisions)
- [Future Enhancements](#-future-enhancements)

---

## 🎯 Overview

The **Ticket Management App** is a comprehensive mobile solution designed for enterprise support ticket management. It enables teams to efficiently track, filter, and manage support tickets while providing seamless contact management and user profile features.

### Key Highlights

- **Modern Architecture**: Clean separation of concerns with BLoC pattern
- **Responsive Design**: Adaptive UI supporting both light and dark themes
- **Dynamic Filtering**: Flexible, API-like filter system with multiple display types
- **Performance Optimized**: Efficient data caching and state management
- **Cross-Platform**: Runs seamlessly on iOS, Android, and Web

---

## ✨ Features

### 🎟️ Ticket Management
| Feature | Description |
|---------|-------------|
| **Ticket List** | View all tickets with priority and status indicators |
| **Smart Filtering** | Multi-criteria filtering (brand, priority, tags) |
| **Pull-to-Refresh** | Real-time data refresh with visual feedback |
| **Ticket Details** | Detailed view with complete ticket information |
| **Visual Indicators** | Color-coded priority and status badges |

### 🔍 Advanced Filter System
| Filter Type | Description |
|-------------|-------------|
| **Chips** | Quick-select toggles for common filters |
| **Dropdown** | Single-select with visual indicators |
| **Checkbox List** | Multi-select with brand icons |
| **Search + Chips** | Searchable tags with chip display |

### 👥 Contact Management
| Feature | Description |
|---------|-------------|
| **Contact Directory** | Complete team member listing |
| **Real-time Search** | Instant filtering by name, email, department |
| **Contact Details** | Modal sheet with complete profile |
| **Online Status** | Visual indicator for availability |

### 👤 User Profile
| Feature | Description |
|---------|-------------|
| **Profile Overview** | User info with avatar and stats |
| **Role Assignments** | Visual display of assigned roles |
| **Statistics** | Tickets created/resolved metrics |
| **Edit Capability** | Profile modification support |

### 🎨 Theme Support
| Feature | Description |
|---------|-------------|
| **Light Mode** | Clean, professional light theme |
| **Dark Mode** | Eye-friendly dark theme |
| **Persistence** | Theme preference saved across sessions |
| **Toggle** | One-tap theme switching |

---

## 📱 Screenshots

<div align="center">

### Light Theme

| Tickets Screen | Filter Screen | Contact Screen | Profile Screen |
|:--------------:|:-------------:|:--------------:|:--------------:|
| ![Tickets Light](assets/screenshots/tickets_light.png) | ![Filter Light](assets/screenshots/filter_light.png) | ![Contacts Light](assets/screenshots/contacts_light.png) | ![Profile Light](assets/screenshots/profile_light.png) |

### Dark Theme

| Tickets Screen | Filter Screen | Contact Screen | Profile Screen |
|:--------------:|:-------------:|:--------------:|:--------------:|
| ![Tickets Dark](assets/screenshots/tickets_dark.png) | ![Filter Dark](assets/screenshots/filter_dark.png) | ![Contacts Dark](assets/screenshots/contacts_dark.png) | ![Profile Dark](assets/screenshots/profile_dark.png) |

### Additional Views

| Ticket Detail | Contact Detail | Empty State | Loading State |
|:-------------:|:--------------:|:-----------:|:-------------:|
| ![Ticket Detail](assets/screenshots/ticket_detail.png) | ![Contact Detail](assets/screenshots/contact_detail.png) | ![Empty State](assets/screenshots/empty_state.png) | ![Loading](assets/screenshots/loading.png) |

</div>

> **Note**: Add your screenshots to the `assets/screenshots/` folder with the corresponding names.

---

## 🎬 Demo Video

<div align="center">

https://github.com/user-attachments/assets/ba5d3efe-30b5-48ea-ad08-34274fc19987


*Click to watch the full demo video*

</div>

---

## 🏗️ Architecture

### Clean Architecture Overview

```
┌─────────────────────────────────────────────────────────────┐
│                    PRESENTATION LAYER                        │
│  ┌─────────────────────────────────────────────────────┐    │
│  │                     UI (Widgets)                      │    │
│  │   Screens │ Widgets │ Common Components               │    │
│  └─────────────────────────┬───────────────────────────┘    │
│                            │                                  │
│  ┌─────────────────────────▼───────────────────────────┐    │
│  │                   BLoC (State Management)             │    │
│  │   TicketBloc │ ContactBloc │ ProfileBloc │ ThemeBloc  │    │
│  └─────────────────────────┬───────────────────────────┘    │
└────────────────────────────┼────────────────────────────────┘
                             │
┌────────────────────────────▼────────────────────────────────┐
│                      DOMAIN LAYER                            │
│  ┌─────────────────────────────────────────────────────┐    │
│  │                    Data Models                        │    │
│  │   Ticket │ Contact │ UserProfile │ Filter             │    │
│  └─────────────────────────────────────────────────────┘    │
└────────────────────────────┬────────────────────────────────┘
                             │
┌────────────────────────────▼────────────────────────────────┐
│                       DATA LAYER                             │
│  ┌─────────────────────────────────────────────────────┐    │
│  │                   Repositories                        │    │
│  │   TicketRepository │ ContactRepository │ ProfileRepo  │    │
│  └─────────────────────────┬───────────────────────────┘    │
│                            │                                  │
│  ┌─────────────────────────▼───────────────────────────┐    │
│  │                   Data Source                         │    │
│  │   JSON Files │ Cached Data │ Simulated Delays         │    │
│  └─────────────────────────────────────────────────────┘    │
└─────────────────────────────────────────────────────────────┘
```

### Layer Responsibilities

| Layer | Responsibility |
|-------|---------------|
| **Presentation** | UI components, user interactions, visual rendering |
| **BLoC** | Business logic, state management, event handling |
| **Domain** | Data models, business entities, type definitions |
| **Data** | Data access, repositories, API/mock data management |

---

## 💡 Implementation Approach

### 1. State Management with BLoC

The application uses the **BLoC (Business Logic Component)** pattern for predictable state management following the Event → BLoC → State flow.

**Why BLoC?**
- Separation of UI and business logic
- Testable and predictable state changes
- Reactive programming with streams
- Excellent Flutter ecosystem support

### 2. Dynamic Filter System

One of the key features is the **configurable filter system** that supports multiple display types:

| Display Type | Use Case |
|--------------|----------|
| `chips` | Toggle chips for quick filters |
| `dropdown` | Single-select with visual feedback |
| `checkboxList` | Multi-select with icons |
| `searchWithChips` | Searchable with chip display |

### 3. Theme Implementation

Dual theme support with SharedPreferences persistence for user preference across sessions.

### 4. Repository Pattern

Clean data abstraction layer that can easily transition from mock data to real API endpoints.

### 5. Model Design with Equatable

Immutable models with value equality for efficient state comparison and widget rebuilds.

---

## 🛠️ Tech Stack

<div align="center">

| Category | Technology | Version | Purpose |
|:--------:|:----------:|:-------:|:--------|
| 📱 Framework | Flutter | 3.9+ | Cross-platform UI framework |
| 💻 Language | Dart | 3.9+ | Programming language |
| 🔄 State Management | flutter_bloc | 8.1.6 | BLoC pattern implementation |
| ⚖️ Equality | equatable | 2.0.5 | Value equality for models |
| 💾 Storage | shared_preferences | 2.2.2 | Theme persistence |
| 🎨 Icons | flutter_svg | 1.1.6 | Custom SVG icons |
| 📊 Design | Material 3 | - | Modern design system |

</div>

---

## 📁 Project Structure

```
ticket_management/
├── 📁 lib/
│   ├── 📄 main.dart                      # App entry point
│   │
│   ├── 📁 bloc/                          # State Management
│   │   ├── 📁 contact/
│   │   │   ├── contact_bloc.dart         # Contact business logic
│   │   │   ├── contact_event.dart        # Contact events
│   │   │   └── contact_state.dart        # Contact states
│   │   │
│   │   ├── 📁 profile/
│   │   │   ├── profile_bloc.dart         # Profile business logic
│   │   │   ├── profile_event.dart        # Profile events
│   │   │   └── profile_state.dart        # Profile states
│   │   │
│   │   ├── 📁 theme/
│   │   │   ├── theme_bloc.dart           # Theme switching logic
│   │   │   ├── theme_event.dart          # Theme events
│   │   │   └── theme_state.dart          # Theme states
│   │   │
│   │   └── 📁 ticket/
│   │       ├── ticket_bloc.dart          # Ticket & filter logic
│   │       ├── ticket_event.dart         # Ticket events
│   │       └── ticket_state.dart         # Ticket states
│   │
│   ├── 📁 core/                          # Core Utilities
│   │   ├── 📁 constants/
│   │   │   ├── app_colors.dart           # Color palette
│   │   │   ├── app_dimensions.dart       # Spacing, sizes
│   │   │   └── app_strings.dart          # Text constants
│   │   │
│   │   └── 📁 theme/
│   │       └── app_theme.dart            # Theme configuration
│   │
│   ├── 📁 data/                          # Data Layer
│   │   ├── 📁 models/
│   │   │   ├── contact.dart              # Contact model
│   │   │   ├── filter.dart               # Filter models
│   │   │   ├── ticket.dart               # Ticket model
│   │   │   └── user_profile.dart         # Profile model
│   │   │
│   │   └── 📁 repositories/
│   │       ├── contact_repository.dart   # Contact data ops
│   │       ├── mock_data.dart            # JSON data loader
│   │       ├── profile_repository.dart   # Profile data ops
│   │       └── ticket_repository.dart    # Ticket & filter ops
│   │
│   └── 📁 ui/                            # Presentation Layer
│       ├── 📁 screens/
│       │   ├── contact_screen.dart       # Contacts view
│       │   ├── filter_screen.dart        # Filter selection
│       │   ├── main_screen.dart          # Navigation scaffold
│       │   ├── profile_screen.dart       # User profile
│       │   └── ticket_screen.dart        # Ticket list
│       │
│       └── 📁 widgets/
│           ├── common_search_bar.dart    # Reusable search
│           ├── common_widgets.dart       # Loading, error, empty
│           ├── contact_card.dart         # Contact list item
│           ├── contact_detail_sheet.dart # Contact modal
│           ├── ticket_card.dart          # Ticket list item
│           └── ticket_detail_sheet.dart  # Ticket modal
│
├── 📁 assets/
│   ├── filter_icon.svg                   # Custom filter icon
│   ├── 📁 json/                          # Mock data files
│   └── 📁 screenshots/                   # App screenshots
│
├── 📄 pubspec.yaml                       # Dependencies
├── 📄 analysis_options.yaml              # Lint rules
└── 📄 README.md                          # Documentation
```

---

## 🔄 State Management (BLoC Pattern)

### Event-State Flow

```
┌─────────────┐     ┌─────────────┐     ┌─────────────┐
│    USER     │────▶│    EVENT    │────▶│    BLOC     │
│  INTERACTION│     │  LoadTickets│     │ TicketBloc  │
└─────────────┘     └─────────────┘     └──────┬──────┘
                                               │
                                               ▼
                    ┌─────────────┐     ┌─────────────┐
                    │     UI      │◀────│   STATE     │
                    │   REBUILD   │     │ TicketState │
                    └─────────────┘     └─────────────┘
```

### BLoC Components

| BLoC | Purpose | Events |
|------|---------|--------|
| **TicketBloc** | Ticket list & filtering | LoadTickets, ApplyFilters, ToggleFilterOption, ClearFilters |
| **ContactBloc** | Contact management | LoadContacts, SearchContacts, ClearSearch |
| **ProfileBloc** | User profile | LoadProfile, RefreshProfile |
| **ThemeBloc** | Theme management | ToggleTheme, SetThemeMode, LoadSavedTheme |

### State Flow Diagram

```
┌──────────────────────────────────────────────────────────┐
│                    TICKET BLOC                            │
├──────────────────────────────────────────────────────────┤
│                                                          │
│  LoadTickets ──────────▶ initial → loading → loaded     │
│                                                          │
│  ToggleFilterOption ───▶ Update filterGroups & filters  │
│                                                          │
│  ApplyFilters ─────────▶ Filter tickets → isFiltered    │
│                                                          │
│  ClearFilters ─────────▶ Reset to original tickets      │
│                                                          │
└──────────────────────────────────────────────────────────┘
```

---

## 📊 Data Models

### Ticket Model

| Property | Type | Description |
|----------|------|-------------|
| `id` | String | Unique identifier (TKT-001) |
| `title` | String | Ticket title |
| `description` | String | Detailed description |
| `status` | TicketStatus | open, inProgress, resolved, closed, pending |
| `priority` | TicketPriority | low, medium, high, critical |
| `assignee` | String | Assigned team member |
| `category` | String | Bug, Feature Request, Support, Documentation |
| `brand` | String | Associated brand |
| `createdAt` | DateTime | Creation timestamp |
| `updatedAt` | DateTime | Last update timestamp |

### Filter Model

| Component | Properties |
|-----------|------------|
| **FilterGroup** | id, title, options, allowMultiple, displayType |
| **FilterOption** | id, label, value, isSelected, colorHex |

---

## 🎨 UI Components

### Reusable Widgets

| Widget | Purpose | Features |
|--------|---------|----------|
| `TicketCard` | Display ticket in list | Priority/status chips, category pill, date formatting |
| `ContactCard` | Display contact entry | Avatar, role, department, popup menu |
| `CommonSearchBar` | Search input field | Clear button, real-time callback |
| `LoadingIndicator` | Loading state | Centered spinner with optional message |
| `EmptyState` | Empty data state | Icon, title, message, optional action |
| `ErrorState` | Error display | Error icon, message, retry button |
| `TicketDetailSheet` | Ticket modal | Complete ticket info, scrollable |
| `ContactDetailSheet` | Contact modal | Profile details, actions |

All components automatically adapt to light/dark theme for consistent user experience.

---

## 🚀 Getting Started

### Prerequisites

| Requirement | Version |
|-------------|---------|
| Flutter SDK | ^3.9.2 |
| Dart SDK | ^3.9.2 |
| VS Code / Android Studio | Latest |
| Xcode (for iOS) | 14+ |

### Installation

```bash
# 1. Clone the repository
git clone https://github.com/abubakkarsiddik/ticket_management.git

# 2. Navigate to project directory
cd ticket_management

# 3. Install dependencies
flutter pub get

# 4. Run the app
flutter run
```
---

## 🎯 Design Decisions

### Why BLoC?

| Consideration | Decision |
|---------------|----------|
| **Scalability** | BLoC easily scales with app complexity |
| **Testability** | Pure functions make unit testing straightforward |
| **Separation** | Clear boundary between UI and logic |
| **Ecosystem** | Rich tooling and community support |

### Why Repository Pattern?

```
Real API Structure ←────────────────── Mock Data
       │                                    │
       ▼                                    ▼
┌─────────────┐                    ┌─────────────┐
│  Repository │                    │  MockData   │
│   Pattern   │──── Identical ────▶│   Loader    │
└─────────────┘      Interface     └─────────────┘
```

**Benefits:**
- Easy transition to real API
- Consistent data structure validation
- Offline development capability
- Faster iteration cycles

### Filter System Design

The filter system was designed to be **configuration-driven**, meaning filter types can be changed without code modifications.

---

