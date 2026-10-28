<div align="center">

![Qt](https://img.shields.io/badge/Qt_6-7B1113?style=for-the-badge&logo=qt&logoColor=white)
![C++](https://img.shields.io/badge/C++-C0392B?style=for-the-badge&logo=cplusplus&logoColor=white)
![QML](https://img.shields.io/badge/QML-7B1113?style=for-the-badge&logo=qt&logoColor=white)
![JSON](https://img.shields.io/badge/JSON_storage-C0392B?style=for-the-badge&logo=json&logoColor=white)

# Isko-nnect

**Your comprehensive student services platform for the University of the Philippines Cebu.**

One desktop app for announcements, events, scholarships, tutoring, internships and room booking.

</div>

<img src="docs/readme/welcome.png" alt="Isko-nnect welcome screen" width="100%">

<img src="docs/readme/divider.png" alt="" width="100%">

## Why Isko-nnect

Student services at UP Cebu are spread across Facebook pages, bulletin boards, emails and separate offices. Isko-nnect puts them in one place. Students see everything they can apply for or book, and administrators manage it all from a single dashboard.

<img src="docs/readme/divider.png" alt="" width="100%">

## Two ways in

Students sign in with their name and 9-digit student number. Administrators sign in with a UP email address.

<table>
  <tr>
    <td width="50%"><img src="docs/readme/student-login.png" alt="Student login"></td>
    <td width="50%"><img src="docs/readme/admin-login.png" alt="Admin login"></td>
  </tr>
  <tr>
    <td align="center"><sub>Student login</sub></td>
    <td align="center"><sub>Admin login</sub></td>
  </tr>
</table>

<img src="docs/readme/divider.png" alt="" width="100%">

## For students

### Dashboard

Announcements, upcoming events and shortcuts to every service, the moment you sign in.

<img src="docs/readme/student-dashboard.png" alt="Student dashboard" width="100%">

### Scholarships

Browse open scholarships with deadlines, eligible courses, year level and financial need. Filter by program or year, or search by name.

<img src="docs/readme/scholarships.png" alt="Scholarships page" width="100%">

### Tutoring

Request a tutor from the list of approved student tutors, or apply to become one.

<img src="docs/readme/tutoring.png" alt="Tutoring page" width="100%">

### Internships

Find internships that match your program and year level.

<img src="docs/readme/internships.png" alt="Internships page" width="100%">

### Rooms

See every campus room with its type and capacity, then book one for a time slot.

<img src="docs/readme/rooms.png" alt="Rooms page" width="100%">

<img src="docs/readme/divider.png" alt="" width="100%">

## For administrators

### Dashboard

Every service has its own management page.

<img src="docs/readme/admin-dashboard.png" alt="Admin dashboard" width="100%">

### Manage everything

Post announcements and events, add scholarships and internships, approve tutor applications and handle requests, and add rooms or mark them as booked.

<table>
  <tr>
    <td width="50%"><img src="docs/readme/admin-announcements.png" alt="Manage announcements"></td>
    <td width="50%"><img src="docs/readme/admin-events.png" alt="Manage events"></td>
  </tr>
  <tr>
    <td align="center"><sub>Announcements</sub></td>
    <td align="center"><sub>Events</sub></td>
  </tr>
  <tr>
    <td><img src="docs/readme/admin-scholarships.png" alt="Manage scholarships"></td>
    <td><img src="docs/readme/admin-internships.png" alt="Manage internships"></td>
  </tr>
  <tr>
    <td align="center"><sub>Scholarships</sub></td>
    <td align="center"><sub>Internships</sub></td>
  </tr>
  <tr>
    <td><img src="docs/readme/admin-tutoring.png" alt="Manage tutoring"></td>
    <td><img src="docs/readme/admin-rooms.png" alt="Manage rooms"></td>
  </tr>
  <tr>
    <td align="center"><sub>Tutoring</sub></td>
    <td align="center"><sub>Rooms</sub></td>
  </tr>
</table>

<img src="docs/readme/divider.png" alt="" width="100%">

## How it's built

The interface is written in **QML** and the logic in **C++** with **Qt 6**. A C++ `FileManager` class is exposed to QML and reads and writes all app data as **JSON files**: one file each for announcements, events, scholarships, internships, tutors, tutor applications, tutor requests and rooms. A change an admin makes shows up on the student side right away.

<details>
<summary><b>Project structure</b></summary>

```
Isko-nnect/
├── main.cpp              # starts the app and registers FileManager for QML
├── main.qml              # window and page switching
├── filemanager.h/.cpp    # reads and writes the JSON data files
├── qml.qrc               # bundles the QML, images and fonts
└── ui/
    ├── LeftWelcomePage/   # welcome panel
    ├── RightWelcomePage/  # choose student or admin
    ├── RightLogin/        # login forms
    ├── StudentDashboard/  # all student pages
    ├── AdminDashboard/    # all admin pages
    ├── BottomBar/         # footer
    └── assets/            # icons, photos, Inter and Rubik fonts
```

</details>

<details>
<summary><b>Run it locally</b></summary>

1. Install **Qt 6** with the **Qt 5 Compatibility Module** (used for drop shadows), and open `ISKONNECT.pro` in **Qt Creator**.
2. Build and run.
3. The app reads its JSON data files from the folder it runs in. Copy the sample `.json` files into your build folder to start with data.

</details>

<img src="docs/readme/divider.png" alt="" width="100%">

<div align="center">
<sub>A student project for the University of the Philippines Cebu.</sub>
</div>
