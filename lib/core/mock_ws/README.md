# Tech Test Designli, by Alex Regiani.

## Features
- Three main screens:
    1. Watch Screen: Cards with real-time trades.
    2. Alert Screen: Set alerts when a stock reaches a certain price.
    3. Graph Screen: A line chart representing stock performance over time.

## Architecture
This project follows Clean Architecture principles, promoting separation of concerns and maintainability:

- Presentation Layer: Flutter UI and BLoC for state management
- Domain Layer: Business logic and use cases
- Data Layer: Data sources and repositories

## State Management
BLoC pattern is used for state management, ensuring a reactive and efficient app structure.

## Navigation
Fully working with go_router

## Networking
it implements both WebSocket (for live trades) and traditional http (historical data).

## Environment variables
flutter_dotenv has been used, the .env.example has a token environment variable to be filled.

## Server configuration
To easily switch between mock and real server go to:
lib/core/get_it/features/get_it_configuration_service.dart
and set the desired boolean flag, the mock server is set to increment in a predictable manner,
perfect to test the set alert for price stock feature, a mock server was also necessary
because of constantly reaching the api requests limit.

## Platform
The app was tested on Pixel 8 API 34, it is highly recommended to use
the same device in the AVD, or another Android device, other platforms not tested.

## Getting Started
- follow these steps:
    1. Open the terminal and run mock_ws.dart located at lib/core/mock_ws/lib/mock_ws.dart
    2. Run the app on the AVD (tested on Pixel 8 API 34)
    3. Have fun :)