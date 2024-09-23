# To-DO-APP

This *To-DO-APP* is a Flutter application designed to help users efficiently manage their tasks. The app allows users to add, edit, delete, and complete tasks with a clean and user-friendly interface.

## Features

- *Add Tasks*: Create new tasks with titles, descriptions, and due dates.
- *Edit Tasks*: Modify existing tasks for corrections or updates.
- *Task Completion*: Mark tasks as completed with a simple swipe action.
- *Delete Tasks*: Remove tasks from the list by swiping.
- *Responsive UI*: Ensures that the layout adapts to different screen sizes and orientations.
- *Dark Mode*: Support for both light and dark themes based on user preferences.
- *Firebase Integration*: Sync tasks in real-time across devices using Firebase.

## Technologies Used

- *Flutter*: A cross-platform framework to build the app for both Android and iOS.
- *Firebase*: For real-time data syncing and authentication.
- *Provider*: State management for handling app-wide changes efficiently.
- *Google Fonts*: To enhance the visual styling of text elements.
- *Dart*: The programming language used in Flutter for app development.

## Getting Started

### Prerequisites

Before you begin, ensure you have the following installed:

- [Flutter](https://flutter.dev/docs/get-started/install) (version 3.0 or later)
- [Dart](https://dart.dev/get-dart)
- Firebase project set up (for backend and data syncing)

### Installation

1. *Clone the Repository*

   bash
   git clone https://github.com/oso020/TO-DO-APP.git

   

3. *Navigate to the Project Directory*

   bash
   cd task-management-app
   

4. *Install Dependencies*

   Run the following command to fetch the required packages:

   bash
   flutter pub get
   

5. *Firebase Setup*

   - Set up Firebase for your project:
     - Create a new Firebase project at [Firebase Console](https://console.firebase.google.com/).
     - Follow the instructions to add both Android and iOS Firebase configurations,(or simply choose flutter configuration).
     - Replace google-services.json (for Android) and GoogleService-Info.plist (for iOS) in the respective directories, or just use flutter integration provided by Firebase.

6. *Run the Application*

   To run the application on your preferred device, use:

   bash
   flutter run
   


## Screenshots

### Light Mode

<p align="center">
  <img src="https://github.com/oso020/TO-DO-APP/blob/development/sceenshots/register.png" alt="Sign Up" width="220" style="margin: 10px;"/>
  <img src="https://github.com/oso020/TO-DO-APP/blob/development/sceenshots/login.png" alt="Sign In" width="220" style="margin: 10px;"/>
     <img src="https://github.com/oso020/TO-DO-APP/blob/development/sceenshots/valIdator.png" alt="Validator dark" width="220" style="margin: 10px;"/>

  <img src="https://github.com/oso020/TO-DO-APP/blob/development/sceenshots/home.png" alt="Task" width="220" style="margin: 10px;"/>
</p>

<p align="center">
  <img src="https://github.com/oso020/TO-DO-APP/blob/development/sceenshots/added_task.png" alt="Task Add" width="220" style="margin: 10px;"/>
  <img src="https://github.com/oso020/TO-DO-APP/blob/development/sceenshots/delete_feature.png" alt="Task Delete" width="220" style="margin: 10px;"/>
  <img src="https://github.com/oso020/TO-DO-APP/blob/development/sceenshots/done_feature.png" alt="Done Task" width="220" style="margin: 10px;"/>
    <img src="https://github.com/oso020/TO-DO-APP/blob/development/sceenshots/dialog.png" alt="Dialog Dark" width="220" style="margin: 10px;"/>

  

</p>
<p align="center">
   <img src="https://github.com/oso020/TO-DO-APP/blob/development/sceenshots/edit_task.png" alt="Edit Task" width="220" style="margin: 10px;"/>
     <img src="https://github.com/oso020/TO-DO-APP/blob/development/sceenshots/settings.png" alt="Settings" width="220" style="margin: 10px;"/>
</p>

### Dark Mode

<p align="center">
  <img src="https://github.com/oso020/TO-DO-APP/blob/development/sceenshots/login_dark.png" alt="Sign Up" width="220" style="margin: 10px;"/>
  <img src="https://github.com/oso020/TO-DO-APP/blob/development/sceenshots/register_dark.png" alt="Sign In" width="220" style="margin: 10px;"/>
  <img src="https://github.com/oso020/TO-DO-APP/blob/development/sceenshots/home_dark.png" alt="Task" width="220" style="margin: 10px;"/>
</p>
<p align="center">
  <img src="https://github.com/oso020/TO-DO-APP/blob/development/sceenshots/validator_dark.png" alt="Validator dark" width="220" style="margin: 10px;"/>
  <img src="https://github.com/oso020/TO-DO-APP/blob/development/sceenshots/dialog_dark.png" alt="Dialog Dark" width="220" style="margin: 10px;"/>
</p>
<p align="center">
  <img src="https://github.com/oso020/TO-DO-APP/blob/development/sceenshots/added_task%20dark.png" alt="Task Add" width="220" style="margin: 10px;"/>
  <img src="https://github.com/oso020/TO-DO-APP/blob/development/sceenshots/delete_feature_dark.png" alt="Task Delete" width="220" style="margin: 10px;"/>
  <img src="https://github.com/oso020/TO-DO-APP/blob/development/sceenshots/done_feature_dark.png" alt="Done Task" width="220" style="margin: 10px;"/>
  <img src="https://github.com/oso020/TO-DO-APP/blob/development/sceenshots/edit_task_dark.png" alt="Edit Task" width="220" style="margin: 10px;"/>
     <img src="https://github.com/oso020/TO-DO-APP/blob/development/sceenshots/settings_dark.png" alt="Settings" width="220" style="margin: 10px;"/>

</p>
<p align="center">
</p>

## Contributions

Feel free to fork this repository, open issues, and submit pull requests. Contributions are highly appreciated!
