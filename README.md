# Tech Test Designli, by Alex Regiani.

## Features
- Three main screens:
    1. Watch Screen: Cards with real-time trades.
    2. Graph Screen: A line chart representing stock performance over time.
    3. Alert Screen: Set alerts when a stock reaches a certain price.

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
it implements both WebSocket and traditional http.

## Getting Started
I have created a mock Web Socket Server for testing purposes
- follow these steps:
    1. Open the terminal and run mock_ws.dart located at lib/core/mock_ws/lib/mock_ws.dart 
    2. Run the app on the AVD (tested on Pixel 8 API 34)
    3. Have fun :)

