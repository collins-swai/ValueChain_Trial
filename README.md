# ValueChain Trial

## Introduction:
In this case study, we will explore the development of a Flutter app that leverages the Quickey DB
package for database operations and the Activity package as a state management tool. The project
focuses on implementing robust logic, efficient database CRUD operations, and a responsive user
interface (UI) for an optimal user experience.

## Project Overview:
The goal of the project is to create a Flutter app that manages a collection of to-do tasks, allowing users
to perform CRUD operations on the tasks while maintaining a smooth and responsive UI. The application
uses Quickey DB as the database library for efficient data storage and retrieval. Additionally, the Activity
package is employed as the state management tool to handle the app's state and ensure seamless
updates across different components.

# ValueChain Trial.

## Android Developer Pre-screening trial.

Timeline: 5 days

## Project Requirements
### Key Points:
- ## Logic Implementation:
- ## Task Management Logic:
        - Creation, update, and deletion of to-do tasks.
        - Prioritization and categorization of to-do tasks.
        - To-do Task completion status tracking.

    - ## Business Rules:
            - Implementing business rules for task management.
            - Handling edge cases and exceptions gracefully.

    - ## Logic Optimization:
           - Ensuring efficient algorithms for sorting and filtering tasks.
           - Minimizing redundant code and optimizing performance.

- ## Database CRUD Operations with Quickey DB:
    - ## Integration:
          - Integrating Quickey DB into the Flutter project.
          - Setting up the database schema for the to-do task storage.

    - ## CRUD Operations:
          - Creating to-do tasks and storing them in the database.
          - Updating to-do task information.
          - Deleting to-do tasks from the database.
          - Retrieving to-do tasks for display in the UI.

    - ## Error Handling:
          - Implementing error handling mechanisms for database operations.
          - Ensuring data integrity and consistency.

- ## UI Development:
    - ## Responsive UI:
          - Designing a user-friendly interface using Flutter's widget system.
          - Implementing a responsive layout for various screen sizes.

    - ## Stateful UI:
          - Utilizing the Activity package for state management.
          - Synchronizing UI updates with changes in the app's state.

    - ## User Feedback:
           - Providing visual feedback for successful and unsuccessful operations.
           - Implementing loading indicators for asynchronous tasks.

## Quick Start
This is a normal flutter app. You should follow the instructions in the [official documentation](https://flutter.io/docs/get-started/install).
This project uses **Activity** (business logic component) [Activity](https://pub.dev/packages/activity) to separate the business logic with UI itself. While the database we will be using **QuickeyDB**
(database component)[QuickeyDB](https://pub.dev/packages/quickeydb) as the databse itself.

## Modularization Structure 🔥
# Root Project
    .
    │   
    |
    └── lib                        # Name of module (default from Flutter).
        |── controller             # Name of controllers.
        |── database               # Database.  
        ├── models                 # Main models for task.
        ├── presentations          # Activity/View layer
        ├── theme                  # App styling themes.
        ├── widget                 # Styles for app.

## Built With 🛠
* [Activity](https://pub.dev/packages/activity) - A simple multiplatform State Manager that allows the full power of MVC with ZERO Packages.
* [QuickeyDB](https://pub.dev/packages/quickeydb) - QuickeyDB is a simple ORM inspired from ActiveRecord, built on-top of Sqflite.


## How to run the App
1. Clone this project.
2. Open with your favorite tools editor.

## Thank you ValueChain
I'd like to thank **ValueChain**, and *every single individual* that helped in bringing this learning experience. Thank you!







