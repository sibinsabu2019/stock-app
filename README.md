Stock Trading App
Overview
The Stock Trading App is designed to help users monitor up to two stocks by adding them to a personalized watchlist. The app features live stock charts that display price movements and trends over various time frames.

Note: This project uses live data fetched via API calls, with a limit of 25 requests per day. Users can utilize a VPN to access an additional 25 requests if needed.

Features
Watchlist Management

Add or remove up to two stocks from a watchlist.
Display stock symbols, current prices, and percentage changes for a quick overview.
Live Stock Charts

View detailed charts for each stock in the watchlist.
Charts cover multiple time frames (e.g., 1 day, 1 week, 1 month).
API Integration

Real-time data is fetched via API calls.
Supports fallback to VPN for additional requests.
Getting Started
Clone the Repository

bash
Copy code
git clone https://github.com/yourusername/stock-trading-app.git
cd stock-trading-app
Install Dependencies

bash
Copy code
flutter pub get
Run the App

bash
Copy code
flutter run
API Usage
The app uses [API Name] to fetch real-time stock data.
API call limit: 25 requests per day.
For extended use, connect to a VPN to access an additional 25 requests.
Important Notes
This project does not use static data. All stock information and charts are generated using live data from the API.
The app is inspired by the UpStocks. Refer to it for a better understanding of the user interface and functionality.
