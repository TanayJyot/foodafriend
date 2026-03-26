# Food A Friend

**Food A Friend** is a peer-to-peer (P2P) food delivery application tailored specifically for college students. 

## The Vision 

The core idea behind **Food A Friend** is to **help students earn some extra bucks during their daily commute.**

A student is already on their way to campus for a lecture. With Food A Friend, they can pick up food from local restaurants along their route and deliver it to peers right outside their classrooms. It's a win-win—hungry students get their meals delivered conveniently and affordably, and the commuting student earns some extra dollars without going out of their way!

---

## Features

- **Peer-to-Peer Delivery:** A completely student-driven ecosystem.
- **On-the-Way Routing:** Utilizing Google Maps to map optimal pickup points on the way to campus.
- **Real-Time Tracking & Location:** Tracks the delivery progress live.
- **Secure Authentication:** Firebase-powered login and user management.
- **Push Notifications:** Instant updates about order status via Firebase Cloud Messaging.

## Technology Stack 

- **Frontend / Mobile Framework:** [Flutter](https://flutter.dev/) (Dart)
- **Backend as a Service:** Firebase (Authentication, Cloud Firestore, Cloud Storage, Cloud Messaging)
- **State Management:** Provider
- **Mapping & Location:** Google Maps Flutter, Location API
- **UI Components:** Persistent Bottom Nav Bar, Font Awesome, Cupertino Icons, SpinKit

## Getting Started 

### Prerequisites
- Flutter SDK (>=3.4.3 <4.0.0)
- Dart SDK
- Android Studio / Xcode for emulator/simulator setup
- Firebase project configured (if running your own instance)

### Installation

1. **Clone this repository to your local machine:**
   ```bash
   git clone https://github.com/your-username/foodafriend.git
   ```

2. **Navigate into the project directory:**
   ```bash
   cd foodafriend
   ```

3. **Fetch all dependencies:**
   ```bash
   flutter pub get
   ```

4. **Run the application:**
   ```bash
   flutter run
   ```

### Project Structure 

- `lib/pages/` & `lib/screens/` - Contains the UI for the application.
- `lib/services/` - Handles API and Firebase connections (Auth, Cloud Messaging, etc.).
- `lib/models/` - Data structures and classes (User, Restaurant).
- `lib/themes/` - Theming and styling configuration.
- `lib/components/` & `lib/shared/` - Reusable widgets and UI components.

---

*This project was initially started for buildspace_s5.*
