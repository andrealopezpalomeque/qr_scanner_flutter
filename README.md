# QR Scanner Flutter

QR Scanner is a Flutter application that allows users to scan QR codes using their mobile devices.

## Features

- Scan QR codes using the device's camera
- Store scanned QR codes in SQLite database
- Open URLs from scanned QR codes
- Save scanned QR codes for future reference, displaying them in a list across the app
- Use Provider as a state management solution

## Installation

1. Clone the repository: `git clone https://github.com/your-username/your-project.git`
2. Navigate to the project directory: `cd your-project`
3. Install dependencies: `flutter pub get`
4. Run the application: `flutter run`

## State Management

This project utilizes the Provider package as the state management solution. The Provider package allows for efficient and easy management of application state. Learn more about Provider here: [Provider Package](https://pub.dev/packages/provider)

## Database

The project uses the SQLite database for storing and retrieving scanned QR codes. SQLite is a lightweight and reliable database solution for Flutter applications. Learn more about SQLite here: [SQLite Flutter Package](https://pub.dev/packages/sqflite)

## Usage

1. Launch the application on your mobile device or emulator.
2. Grant camera permissions to the application.
3. Point the camera towards a QR code to start scanning.
4. The application will display the content of the scanned QR code.
5. Scanned QR codes are stored in the SQLite database for future reference.

## Screenshots

<img src="assets/screenshot_qr_app_flutter.png" alt="Screenshot 1" width="400" height="800">

## Contributing

Contributions are welcome! If you find any bugs or want to enhance the application, feel free to open an issue or submit a pull request.
