# Food Ordering App

A comprehensive Flutter mobile application for ordering food online with user authentication, cart management, and order tracking.

## 📋 Overview

Food Ordering App is a full-featured Flutter application that enables users to browse food items, add them to a shopping cart, place orders, and track their order history. The app connects to a backend API for authentication and data management.

## ✨ Features

### Authentication
- **User Registration**: Create new accounts with username, email, password, phone number, and address
- **User Login**: Secure login with JWT token-based authentication
- **Secure Token Storage**: Tokens stored securely using `flutter_secure_storage`

### Food Browsing
- **Browse Food Items**: View all available food items from restaurants
- **Food Details**: View food name, description, price, and restaurant information
- **Real-time Loading**: Fetch food data from backend API

### Shopping Cart
- **Add to Cart**: Add food items to cart with quantity management
- **Cart Management**: View cart items and quantities
- **Remove Items**: Remove items from cart
- **Cart Count**: Real-time cart item counter

### Order Management
- **Place Orders**: Submit orders from cart to backend
- **Order History**: View all past orders with details
- **Order Details**: Track individual order information including total amount and status
- **Order Status Tracking**: Monitor order status and creation time

## 🏗️ Project Structure

```
lib/
├── main.dart                    # App entry point
├── models/
│   ├── cart_item.dart          # Cart item model
│   ├── food_item.dart          # Food item model
│   ├── order.dart              # Order model
│   └── order_details.dart      # Order details model
├── screens/
│   ├── auth_gate.dart          # Authentication gate/router
│   ├── login_page.dart         # Login screen
│   ├── register_page.dart      # Registration screen
│   ├── home_page.dart          # Main food browsing screen
│   ├── cart_page.dart          # Shopping cart screen
│   ├── orders_page.dart        # Order history screen
│   └── order_details_page.dart # Individual order details
└── services/
    ├── auth_service.dart       # Authentication API calls
    ├── cart_service.dart       # Cart management (singleton)
    ├── food_service.dart       # Food items API calls
    ├── order_service.dart      # Order API calls
    └── token_service.dart      # JWT token management
```

## 🛠️ Technical Stack

### Framework & Language
- **Flutter**: ^3.10.4
- **Dart**: Latest stable

### Key Dependencies
- **http** (^0.13.6): HTTP client for API communication
- **flutter_secure_storage** (^9.0.0): Secure token storage
- **cupertino_icons** (^1.0.8): iOS-style icons

### Design
- **Material Design 3**: Modern UI with Material 3
- **Theme**: Orange-based color scheme with Material 3 theming
- **Responsive UI**: Works on multiple platforms

## 📱 Supported Platforms

- Android
- iOS
- Web
- Windows
- Linux

## 🔌 API Integration

The app connects to a backend API running on `http://10.0.2.2:8000` with the following endpoints:

- `POST /register/` - User registration
- `POST /login/` - User login
- `GET /food-items/` - Fetch food items
- `POST /cart-items/` - Add item to cart
- `GET /cart-items/` - Get cart items
- `DELETE /cart-items/{id}/` - Remove from cart
- `POST /orders/` - Place an order
- `GET /orders/` - Get user orders

## 🚀 Getting Started

This project is a starting point for a Flutter application. Here are a few resources to help you get started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

### Prerequisites
- Flutter SDK (^3.10.4)
- Dart SDK
- Android/iOS development environment (for respective platforms)

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd food_ordering_app
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Ensure backend is running**
   Make sure your backend API is running on `http://10.0.2.2:8000`

4. **Run the app**
   ```bash
   flutter run
   ```

### Development Setup

- **Android Studio**: Recommended IDE with Flutter plugin
- **VS Code**: Install Flutter and Dart extensions
- **Emulator/Device**: Android emulator, iOS simulator, or physical device

## 🔐 Security Features

- JWT-based authentication
- Secure token storage using `flutter_secure_storage`
- HTTP headers with authentication tokens for protected endpoints

## 📦 Build & Release

### Debug Build
```bash
flutter run
```

### Release Build
```bash
# Android
flutter build apk --release

# iOS
flutter build ios --release

# Web
flutter build web --release
```

## 📝 Code Quality

- Follows Dart style guidelines
- Uses `flutter_lints` for code analysis
- Material 3 design patterns

## 📚 Additional Resources

- [Flutter Documentation](https://docs.flutter.dev/)
- [Dart Language Guide](https://dart.dev/guides)
- [Material Design 3](https://m3.material.io/)

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🤝 Contributing

Contributions are welcome! Please feel free to submit pull requests or open issues for bugs and feature requests.

---

**Version**: 1.0.0  
**Status**: Active Development
