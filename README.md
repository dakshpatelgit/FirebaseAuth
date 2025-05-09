# Firebase Authentication iOS App

## Overview
This is a SwiftUI-based iOS application that implements Firebase Authentication with a clean, modern UI. The app provides user authentication features including login, signup, password reset, and profile management.

## Features

### Authentication
- Email/Password Login
- User Registration
- Password Reset
- Sign Out
- Account Deletion
- Social Authentication (Apple & Google Sign-in) [UI Ready]

### User Interface
- Modern SwiftUI Design
- Responsive Layout
- Custom Button Styles
- Form Validation
- Error Handling
- Loading States

## Technical Implementation

### Architecture
- MVVM (Model-View-ViewModel) Architecture
- SwiftUI for UI
- Firebase Authentication
- Firebase Firestore for User Data

### Key Components

#### Models
- `User`: Custom user model with properties:
  - `uid`: Unique identifier
  - `email`: User's email
  - `fullName`: User's full name
  - `initials`: Computed property for user initials

#### ViewModels
- `AuthViewModel`: Manages authentication state and operations:
  - User session management
  - Login/Signup logic
  - Password reset
  - User data persistence
  - Error handling

#### Views
1. **LoginView**
   - Email/Password login
   - Password reset navigation
   - Social login options
   - Sign up navigation

2. **ForgetPasswordView**
   - Email input for password reset
   - Success/Error handling
   - Navigation management

3. **ProfileView**
   - User information display
   - Sign out functionality
   - Account deletion option

### Custom Components
- `InputView`: Reusable text input component
- `CapsuleButtonStyle`: Custom button style
- Navigation handling with `NavigationStack`

## Setup Requirements

### Dependencies
- Firebase Authentication
- Firebase Firestore
- SwiftUI
- iOS 16.0+

### Configuration
1. Firebase project setup
2. GoogleService-Info.plist integration
3. Firebase initialization in AppDelegate

## Code Structure
```
├── Screens
│   ├── Auth
│   │   ├── Models
│   │   │   └── User.swift
│   │   ├── ViewModels
│   │   │   └── AuthViewModel.swift
│   │   └── Views
│   │       ├── LoginView.swift
│   │       ├── ForgetPasswordView.swift
│   │       └── ProfileView.swift
│   └── Main
│       └── Views
│           └── ContentView.swift
└── App
    └── SwiftUILogin.swift
```

## Best Practices Implemented
- Async/await for asynchronous operations
- Environment objects for dependency injection
- Proper error handling
- Clean code organization
- Reusable components
- Type-safe navigation

## Future Enhancements
- Complete social authentication implementation
- Enhanced error messages
- User profile editing
- Additional security features
- Unit tests
- UI/UX improvements

