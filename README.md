# 💰 Expance Tracker

A simple yet functional **Expense Tracker Application** built with Flutter and Dart as part of Flutter Boot Camp – Assignment 02, assigned by Innov Edu.

The application allows users to manage their expenses and savings through a clean dashboard, with complete CRUD (Create, Read, Update, Delete) functionality backed by a local database using **Drift**.

## ✨ Features

- **Dashboard:** Displays the user's total available money at the top of the home screen.
- **Transaction Management:** Add transactions with a title, amount, and transaction type (Expense or Saving).
- **Transaction History:** View all transactions in a scrollable list.
- **Update Transactions:** Long-press a transaction card to access the update option.
- **Delete Transactions:** Remove existing transactions through the popover menu.
- **Dynamic Balance Calculation:** Automatically recalculates the total balance whenever a transaction is added, updated, or deleted.
- **Local Database:** Uses Drift to store transaction data locally.
- **Snackbar Feedback:** Displays appropriate Snackbar messages after CRUD operations, such as:
  - Expense Added
  - Expense Updated
  - Expense Deleted

## 🛠️ Tech Stack

| Technology | Purpose |
|---|---|
| Flutter | Cross-platform UI development |
| Dart | Application programming language |
| Drift | Local database and data persistence |
| SQLite | Underlying local database |
| Material UI | UI components and styling |
| Popover | Transaction action menu |
| Intl | Number and currency formatting |

## 📱 Application Overview

The application follows a dashboard-based layout where the total available balance remains visible at the top, while the transaction history is displayed in a separate scrollable section below it.

Users can add new transactions, view their transaction history, update existing records, and delete unwanted transactions.

All transaction data is stored locally using Drift, ensuring that records remain available after closing and reopening the application.

## 🏗️ Project Architecture

The project is organized into separate directories to maintain code readability, reusability, and separation of responsibilities.

```text
lib/
│
├── database/
│   └── app_database.dart
│
├── models/
│   └── transaction_entry.dart
│
├── pages/
│   ├── home_page.dart
│   ├── add_transaction_page.dart
│   └── update_transaction_page.dart
│
├── widget/
│   ├── app_textfield.dart
│   └── ...
│
└── main.dart
```

*Note: The structure above represents the main architectural organization; individual filenames may differ as the project evolves.*

## ⚙️ Getting Started

Follow these steps to run the project on your local machine.

### Prerequisites

Make sure you have the following installed:

- Flutter SDK
- Dart SDK
- Android Studio or Visual Studio Code
- Android Emulator or a physical device

### Installation

**1. Clone the repository**

```bash
git clone https://github.com/Mohammad-Nahid-Islam-Joy/simple_expance_tracker_flutter_assignment_02.git
```

**2. Navigate to the project directory**

```bash
cd simple_expance_tracker_flutter_assignment_02
```

**3. Install dependencies**

```bash
flutter pub get
```

**4. Generate Drift database code**

```bash
dart run build_runner build --delete-conflicting-outputs
```

**5. Run the application**

```bash
flutter run
```

## 🎯 Assignment Objectives

This project was developed to fulfill the requirements of Flutter Assignment 02:

- Implement a complete Expense Tracker application.
- Perform all CRUD operations using a Drift local database.
- Follow proper project architecture and code organization.
- Display the total available money on the dashboard.
- Display transactions using a scrollable list.
- Provide update and delete options through a popover menu on long press.
- Display Snackbar messages to provide feedback after CRUD operations.

## 📚 Learning Outcomes

Through this assignment, I gained practical experience in:

- Implementing local database operations using Drift.
- Understanding database integration in Flutter.
- Performing Create, Read, Update, and Delete operations.
- Managing and displaying dynamic data in Flutter.
- Building reusable widgets and maintaining organized project architecture.
- Working with scrollable layouts and interactive UI components.
- Keeping dashboard information synchronized with database records.

## 👨‍💻 Author

**Nahid Islam Joy**

- GitHub: [@Mohammad-Nahid-Islam-Joy](https://github.com/Mohammad-Nahid-Islam-Joy)
- Repository: [Simple Expance Tracker – Flutter Assignment 02](https://github.com/Mohammad-Nahid-Islam-Joy/simple_expance_tracker_flutter_assignment_02)

---

⭐ If you find this project interesting, feel free to explore the repository!