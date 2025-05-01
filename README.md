# 💹 crypto_rtq — Real-Time Crypto Quotes

**crypto_rtq** is a real-time cryptocurrency tracking app built with Flutter. It allows users to monitor live prices of popular cryptocurrencies and the US Dollar, using Binance's WebSocket API. The app features detailed charts and data filtering to give users a clear and dynamic view of market trends.

<!-- 📸 Add a hero image or banner of the app here -->

---

## 🚀 Features

- 🔄 **Real-time Quotes** using Binance WebSocket 
- 💵 **USD/BRL Price Toggle** to view crypto values in dollars or reais
- 📈 **Detailed Charts**: Hourly, Daily, Weekly, and Monthly views
- 🔍 **Crypto Overview** showing price variation and summary
- ⚙️ **Clean Architecture (MVVM)** for scalability and testability

---

## 🖼️ App Screenshots

### Home Screen
- View live prices of major cryptocurrencies
- Switch between USD and BRL display
<img src="https://github.com/user-attachments/assets/62195660-03f8-4552-a650-a67824c374de" alt="Image" width="200"/>

### Crypto Detail Screen
- Overview section: market change, volume, and latest values
- Interactive charts with hourly, daily, weekly, and monthly filters
<img src="https://github.com/user-attachments/assets/31e5b154-17c9-4f24-9f71-54352a561c15" alt="Image 2" width="200"/>

---

## 🧱 Project Structure

The project follows a well-structured MVVM architecture:
## 🧱 Project Structure

The project follows a well-structured MVVM architecture:

<img src="https://github.com/user-attachments/assets/998edd59-c5f1-4ca2-a14b-f11cc71599be" alt="Image" width="400"/>

---

## 🧰 Dependencies

Here are the main packages used in this project:

### 📦 Core

- [`flutter_bloc`](https://pub.dev/packages/flutter_bloc) — for state management (Cubit)
- [`dartz`](https://pub.dev/packages/dartz) — functional programming utilities
- [`dio`](https://pub.dev/packages/dio) — robust HTTP client
- [`web_socket_channel`](https://pub.dev/packages/web_socket_channel) — WebSocket support

### 🧭 Routing

- [`go_router`](https://pub.dev/packages/go_router) — declarative navigation

### 🧮 Utilities

- [`intl`](https://pub.dev/packages/intl) — internationalization and date formatting
- [`collection`](https://pub.dev/packages/collection) — advanced collection utilities

### 💡 UI Components

- [`shimmer`](https://pub.dev/packages/shimmer) — loading placeholders
- [`syncfusion_flutter_charts`](https://pub.dev/packages/syncfusion_flutter_charts) — interactive charting library

---

## 📲 Getting Started

1. **Clone the repository**
   ```bash
   git clone https://github.com/your-username/crypto_rtq.git
   cd crypto_rtq

2. **Install dependencies**
   ```bash
   flutter pub get

3. **Run the app**
   ```bash
   flutter run
