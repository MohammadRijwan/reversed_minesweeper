# Reversed Minesweeper
A Flutter application implementing a "Reversed Minesweeper" game using Clean Architecture principles and Riverpod for state management. The game features bomb placement, piece dragging, a timer, and game over logic.

## Features
Grid-based Gameplay: A 10x10 grid where players can place pieces and discover bombs.
Timer: A timer that counts up and triggers bomb explosions every 10 seconds.
Game Over Logic: Displays a message when all bombs are discovered or exploded.
Drag-and-Drop Mechanics: Players can drag pieces onto the grid.

## Project Structure

    lib/
     │   src/
     │    └── feature/
     │          ├── auth/
     │          │     ├── data/
     │          │     │     └── auth_repo.dart                    # Contains auth repository implementation
     │          │     └── domain/                    
     │          │          └── interfaces/ 
     │          │          │    ├── i_auth_repo.dart              # Contains auth repository interface
     │          │          │    └── i_db.dart                     # Contains database interface
     │          │          └── providers/ 
     │          │          │    └── auth_provider.dart            # Contains auth provider
     │          │          └── remote_datasource/ 
     │          │               └── firebase_db.dart              # Contains firebase implementation
     │          │          └── ui/ 
     │          │               └── login/                        # Contains firebase implementation
     │          │                    ├── login_screen.dart        # Contains firebase implementation
     │          │                    └── login_vm.dart            # Contains login view model
     │          └── reversed_minesweeper/
     │                ├── data/
     │                │     ├── repositories/                     # Contains data access interfaces
     │                │     │      └── game_repository.dart       # Contains game repository implementation    
     │                │     └── data_sources/
     │                │            └── game_data_sources.dart     # Contains data sources for game
     │                ├── domain/
     │                │     ├── entities/       
     │                │     │       ├── game_entity.dart          # Contains domain entities (Game)
     │                │     ├── use_cases/            
     │                │     │       └── manage_game_use_case.dart # Contains use cases for game logic
     │                │     └── providers/            
     │                │          └── game_provider.dart           # Contains Riverpod providers
     │                │
     │                └── presentation/
     │                      ├── screens/  
     │                      │      └── game_screen.dart           # Contains UI screens (GameScreen)
     │                      │      └── final screen.dart          # Contains UI screens (FinalScreen)
     │                      ├── widgets/ 
     │                      │      └── game_board.dart            # Contains reusable UI components (GameBoard)
     │                      │      └── explosion_widget.dart      # Contains widget for explosion animation
     │                      │      └── piece_draggable.dart       # Contains draggable piece widget
     │                      └── app.dart                          # Main application widget
     ├── splash_screen.dart                                       # Contains splash screen
     └── main.dart                                                # Entry point of the application

# Prerequisites
Flutter SDK installed on your machine.
An IDE such as Visual Studio Code or Android Studio.
Dart SDK (comes with Flutter).

## Getting Started
1. Clone the Repository
      git clone https://github.com/MohammadRijwan/reversed_minesweeper.git
      cd reversed_minesweeper

2. Install Dependencies
      Make sure you have Flutter installed and set up. Run the following command to get the required packages:
      flutter pub get

3. Run the Application
      You can run the application on an emulator or a physical device connected to your machine.
      flutter run

# Usage
Launch the app, and you'll see a grid representing the game board.
Pieces can be dragged onto the grid squares.
Tap on squares to discover bombs.
The timer will count up, triggering random bomb explosions every 10 seconds.
The game ends when all bombs are either discovered or exploded.

## Screenshots

![App Screenshot](https://github.com/MohammadRijwan/reversed_minesweeper/blob/master/assets/screenshot/1.png)
![App Screenshot](https://github.com/MohammadRijwan/reversed_minesweeper/blob/master/assets/screenshot/2.jpg)
![App Screenshot](https://github.com/MohammadRijwan/reversed_minesweeper/blob/master/assets/screenshot/3.jpg)
![App Screenshot](https://github.com/MohammadRijwan/reversed_minesweeper/blob/master/assets/screenshot/4.jpg)
