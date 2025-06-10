import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import Qt5Compat.GraphicalEffects
import Qt.labs.platform 1.1
import FileManager 1.0


Rectangle {
    property ListModel adminAnnouncementsModel: ListModel {}
    property ListModel adminEventsModel: ListModel {}

    function reloadAnnouncements() {
        adminAnnouncementsModel.clear();
        var arr = fileManager.loadAnnouncements();
        for (var i = 0; i < arr.length; i++) {
            adminAnnouncementsModel.append(arr[i]);
        }
    }

    function reloadEvents() {
        adminEventsModel.clear();
        var arr = fileManager.loadEvents();
        for (var i = 0; i < arr.length; i++) {
            adminEventsModel.append(arr[i]);
        }
    }

    property ListModel adminScholarshipsModel: ListModel {}

    function reloadScholarships() {
        adminScholarshipsModel.clear();
        var arr = fileManager.loadScholarships();
        for (var i = 0; i < arr.length; i++) {
            adminScholarshipsModel.append(arr[i]);
        }
    }

    property ListModel adminInternshipsModel: ListModel {}

    function reloadInternships() {
        adminInternshipsModel.clear();
        var arr = fileManager.loadInternships();
        for (var i = 0; i < arr.length; i++) {
            adminInternshipsModel.append(arr[i]);
        }
    }

    function reloadTutors() {
            tutorsModel.clear();
            var tutors = fileManager.loadTutors();
            for (var i = 0; i < tutors.length; i++) {
                tutorsModel.append(tutors[i]);
            }
        }

    property ListModel requestsModel: ListModel {}

    function reloadTutorRequests() {
        requestsModel.clear();
        var requests = fileManager.loadTutorRequests();
        for (var i = 0; i < requests.length; i++) {
            requestsModel.append(requests[i]);
        }
    }


    Component.onCompleted: {
        reloadAnnouncements();
        reloadEvents();
        reloadScholarships();
        reloadInternships();
        reloadTutors();
        fileManager.tutorsChanged.connect(reloadTutors);
        reloadTutorRequests();
        fileManager.tutorRequestsChanged.connect(reloadTutorRequests);
    }

    FileManager {
        id: fileManager
    }

    id: adminDashboard
    width: 1280
    height: 720
    color: "white"

    property bool sidebarVisible: false
    property string dashboardPage: "admin dashboard"

    RowLayout {
        id: scholarshipFinancialNeed
        RadioButton {
            id: financialNeedYes
            text: "Yes"
            checked: true
        }
        RadioButton {
            id: financialNeedNo
            text: "No"
        }
    }

    ListModel {
        id: sampleRoomsModel
            Component.onCompleted: {
                var rooms = fileManager.loadRooms();
                for (var i = 0; i < rooms.length; i++) {
                    append({
                        number: rooms[i].number,
                        capacity: rooms[i].capacity,
                        type: rooms[i].type,
                        availability: rooms[i].availability
                    });
                }
            }
        }

    Connections {
            target: fileManager
            function onRoomsChanged() {
                clear();
                var rooms = fileManager.loadRooms();
                for (var i = 0; i < rooms.length; i++) {
                    append({
                        number: rooms[i].number,
                        capacity: rooms[i].capacity,
                        availability: rooms[i].availability
                    });
                }
            }
        }

    // --- Top Bar ---
    Rectangle {
        id: topBar
        height: adminDashboard.width / 19
        width: adminDashboard.width
        color: "#c0392b"
        z: 2

        Row {
            width: parent.width
            height: parent.height
            anchors.fill: parent
            anchors.leftMargin: 30
            anchors.rightMargin: 30
            anchors.verticalCenter: parent.verticalCenter
            spacing: 20

            Button {
                id: menuButton
                width: 30
                height: 30
                anchors.verticalCenter: parent.verticalCenter
                background: Rectangle { color: "transparent" }
                contentItem: Image {
                    source: "qrc:/ui/assets/Menu.png"
                    fillMode: Image.PreserveAspectFit
                }
                onClicked: sidebarVisible = !sidebarVisible
            }

            Item { width: 30 }

            Row {
                spacing: 15
                leftPadding: 70
                anchors.verticalCenter: parent.verticalCenter

                Image {
                    source: "qrc:/ui/assets/upcebLogo.png"
                    width: 30
                    height: 30
                    fillMode: Image.PreserveAspectFit
                }
            }

            Text {
                topPadding: 20
                leftPadding: 110
                id: dashboardTitle
                text: "Admin Dashboard"
                font.pixelSize: 25
                font.family: "Inter"
                font.bold: true
                color: "white"
                verticalAlignment: Text.AlignVCenter
                anchors.verticalCenterOffset: 2
            }

            Row {
                id: adminInfoSection
                spacing: 30
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                anchors.rightMargin: 10

                Text {
                    id: adminNameText
                    text: "Admin: " + userName
                    color: "white"
                    font.pixelSize: 16
                    font.family: "Inter"
                    font.bold: false
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.verticalCenterOffset: 2
                }

                MouseArea {
                    id: logoutArea
                    anchors.verticalCenter: parent.verticalCenter
                    width: logoutText.width
                    height: logoutText.height
                    cursorShape: Qt.PointingHandCursor
                    onClicked: currentPage = "login"

                    Text {
                        id: logoutText
                        text: "Logout"
                        color: "white"
                        font.pixelSize: 16
                        font.underline: true
                        anchors.verticalCenterOffset: 2
                    }
                }
            }
        }
    }

    // --- Sidebar ---
    Rectangle {
        id: sidebar
        width: sidebarVisible ? 90 : 0
        height: parent.height - topBar.height
        color: "#c0392b"
        y: topBar.height
        z: 1

        Behavior on width {
            NumberAnimation {
                duration: 200
                easing.type: Easing.InOutQuad
            }
        }

        Column {
            anchors.fill: parent
            spacing: 30
            padding: 20
            visible: sidebarVisible

            // Dashboard icon
            Button {
                width: 50; height: 50
                anchors.horizontalCenter: parent.horizontalCenter
                background: Rectangle { color: "transparent" }
                contentItem: Image {
                    source: "qrc:/ui/assets/dashboard.png"
                    fillMode: Image.PreserveAspectFit
                }
                ToolTip.visible: hovered
                ToolTip.text: "Dashboard"
                onClicked: {
                    sidebarVisible = !sidebarVisible
                    dashboardTitle.text = "Admin Dashboard"
                    dashboardPage = "admin dashboard"
                }
            }

            // Announcements icon
            Button {
                width: 50; height: 50
                anchors.horizontalCenter: parent.horizontalCenter
                background: Rectangle { color: "transparent" }
                contentItem: Image {
                    source: "qrc:/ui/assets/announcements.png"
                    fillMode: Image.PreserveAspectFit
                }
                ToolTip.visible: hovered
                ToolTip.text: "Announcements"
                onClicked: {
                    sidebarVisible = !sidebarVisible
                    dashboardTitle.text = "Manage Announcements"
                    dashboardPage = "manage announcements"
                }
            }

            // Events icon
            Button {
                width: 50; height: 50
                anchors.horizontalCenter: parent.horizontalCenter
                background: Rectangle { color: "transparent" }
                contentItem: Image {
                    source: "qrc:/ui/assets/event.png"
                    fillMode: Image.PreserveAspectFit
                }
                ToolTip.visible: hovered
                ToolTip.text: "Events"
                onClicked: {
                    sidebarVisible = !sidebarVisible
                    dashboardTitle.text = "Manage Events"
                    dashboardPage = "manage events"
                }
            }

            // Scholarships icon
            Button {
                width: 50; height: 50
                anchors.horizontalCenter: parent.horizontalCenter
                background: Rectangle { color: "transparent" }
                contentItem: Image {
                    source: "qrc:/ui/assets/Scholarship.png"
                    fillMode: Image.PreserveAspectFit
                }
                ToolTip.visible: hovered
                ToolTip.text: "Scholarships"
                onClicked: {
                    sidebarVisible = !sidebarVisible
                    dashboardTitle.text = "Manage Scholarships"
                    dashboardPage = "manage scholarships"
                }
            }

            // Tutoring icon
            Button {
                width: 50; height: 50
                anchors.horizontalCenter: parent.horizontalCenter
                background: Rectangle { color: "transparent" }
                contentItem: Image {
                    source: "qrc:/ui/assets/Tutoring.png"
                    fillMode: Image.PreserveAspectFit
                }
                ToolTip.visible: hovered
                ToolTip.text: "Tutoring"
                onClicked: {
                    sidebarVisible = !sidebarVisible
                    dashboardTitle.text = "Manage Tutoring"
                    dashboardPage = "manage tutoring"
                }
            }

            // Internships icon
            Button {
                width: 50; height: 50
                anchors.horizontalCenter: parent.horizontalCenter
                background: Rectangle { color: "transparent" }
                contentItem: Image {
                    source: "qrc:/ui/assets/Internships.png"
                    fillMode: Image.PreserveAspectFit
                }
                ToolTip.visible: hovered
                ToolTip.text: "Internships"
                onClicked: {
                    sidebarVisible = !sidebarVisible
                    dashboardTitle.text = "Manage Internships"
                    dashboardPage = "manage internships"
                }
            }

            // Rooms icon
            Button {
                width: 50; height: 50
                anchors.horizontalCenter: parent.horizontalCenter
                background: Rectangle { color: "transparent" }
                contentItem: Image {
                    source: "qrc:/ui/assets/Room.png"
                    fillMode: Image.PreserveAspectFit
                }
                ToolTip.visible: hovered
                ToolTip.text: "Rooms"
                onClicked: {
                    sidebarVisible = !sidebarVisible
                    dashboardTitle.text = "Manage Rooms"
                    dashboardPage = "manage rooms"
                }
            }
        }
    }


    // --- Main Content Area (ADMIN DASHBOARD) ---
    Rectangle {
        id: mainContent
        x: sidebar.width
        y: topBar.height
        width: parent.width - sidebar.width
        height: parent.height - topBar.height
        color: "#f5f7fa"
        z: 0

        ColumnLayout {
            id: dashboardView
            visible: dashboardPage === "admin dashboard"
            anchors.fill: parent
            anchors.margins: 30
            spacing: 25

            // Greeting Box
            Rectangle {
                Layout.fillWidth: true
                height: 120
                radius: 15
                color: "white"

                layer.enabled: true
                layer.effect: DropShadow {
                    color: "#20000000"
                    radius: 12
                    samples: 15
                    verticalOffset: 2
                }

                LinearGradient {
                    anchors.fill: parent
                    start: Qt.point(0, 0)
                    end: Qt.point(width, 0)
                    gradient: Gradient {
                        GradientStop { position: 0.0; color: "#eef2f6" }
                        GradientStop { position: 1.0; color: "#e0e7ff" }
                    }
                }

                RowLayout {
                    anchors.fill: parent
                    anchors.margins: 20
                    spacing: 20

                    Rectangle {
                        width: 60
                        height: 60
                        radius: 30
                        color: "#c0392b"

                        Text {
                            text: userName.charAt(0).toUpperCase()
                            anchors.centerIn: parent
                            font.pixelSize: 28
                            font.bold: true
                            color: "white"
                        }
                    }

                    Column {
                        Layout.fillWidth: true
                        spacing: 5

                        Text {
                            text: "Hello, " + userName
                            font.pixelSize: 24
                            font.bold: true
                            color: "#2c3e50"
                        }

                        Text {
                            text: "Welcome back to your dashboard."
                            font.pixelSize: 16
                            color: "black"
                        }
                    }

                    Text {
                        text: Qt.formatDateTime(new Date(), "dddd, MMMM d")
                        font.pixelSize: 16
                        color: "#7f8c8d"
                    }
                }
            }

            // Quick Access Cards
            GridLayout {
                Layout.fillWidth: true
                columns: 3
                columnSpacing: 20
                rowSpacing: 16

                Repeater {
                    model: [
                        { title: "Manage Announcements", icon: "qrc:/ui/assets/announcements.png", color: "#c0392b" },
                        { title: "Manage Events", icon: "qrc:/ui/assets/event.png", color: "#c0392b" },
                        { title: "Manage Scholarships", icon: "qrc:/ui/assets/Scholarship.png", color: "#c0392b" },
                        { title: "Manage Tutoring", icon: "qrc:/ui/assets/Tutoring.png", color: "#c0392b" },
                        { title: "Manage Internships", icon: "qrc:/ui/assets/Internships.png", color: "#c0392b" },
                        { title: "Manage Rooms", icon: "qrc:/ui/assets/Room.png", color: "#c0392b" },
                    ]

                    delegate: Rectangle {
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        height: 100
                        radius: 12
                        color: "white"

                        layer.enabled: true
                        layer.effect: DropShadow {
                            color: "#10000000"
                            radius: 8
                            samples: 15
                            verticalOffset: 2
                        }

                        Column {
                            anchors.centerIn: parent
                            spacing: 8
                            width: parent.width

                            Rectangle {
                                width:70
                                height: 70
                                radius: 25
                                color: modelData.color
                                anchors.horizontalCenter: parent.horizontalCenter

                                Image {
                                    source: modelData.icon
                                    width: 35
                                    height: 35
                                    anchors.centerIn: parent
                                    sourceSize: Qt.size(width, height)
                                }
                            }

                            Text {
                                topPadding: 10
                                text: modelData.title
                                font.pixelSize: 18
                                font.bold: true
                                color: "black"
                                wrapMode: Text.Wrap
                                horizontalAlignment: Text.AlignHCenter
                                anchors.horizontalCenter: parent.horizontalCenter
                                width: parent.width - 12
                            }
                        }

                        MouseArea {
                            anchors.fill: parent
                            cursorShape: Qt.PointingHandCursor
                            onClicked: {
                                dashboardTitle.text = modelData.title
                                dashboardPage = modelData.title.toLowerCase()
                            }
                        }
                    }
                }
            }
        }
    }

        // ------------------------------------------------------------------------ Announcements Management View ------------------------------------------------------------------------------------
        ColumnLayout {
            x: sidebar.width
            y: topBar.height
            id: announcementsView
            visible: dashboardPage === "manage announcements"
            anchors.fill: parent
            anchors.margins: 30
            spacing: 20

            Text {
                text: "Manage Announcements"
                font.pixelSize: 24
                font.bold: true
                color: "#c0392b"
            }

            // Add New Announcement Form
            Rectangle {
                Layout.fillWidth: true
                height: 250
                radius: 15
                color: "white"

                layer.enabled: true
                layer.effect: DropShadow {
                    color: "#20000000"
                    radius: 12
                    samples: 15
                    verticalOffset: 2
                }

                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 20
                    spacing: 10

                    Text {
                        text: "Add New Announcement"
                        font.pixelSize: 18
                        font.family: "Inter"
                        font.bold: true
                        color: "black"
                    }

                    TextField {
                        topPadding: 7
                        id: announcementTitle
                        Layout.fillWidth: true
                        placeholderText: "Title"
                        font.pixelSize: 14
                        background: Rectangle {
                            radius: 5
                            border.color: "#bdc3c7"
                            border.width: 1
                            implicitHeight: 35
                        }
                    }

                    TextField {
                        topPadding: 7
                        id: announcementDate
                        Layout.fillWidth: true
                        placeholderText: "Date (e.g., June 10, 2023)"
                        font.pixelSize: 14
                        background: Rectangle {
                            radius: 5
                            border.color: "#bdc3c7"
                            border.width: 1
                            implicitHeight: 35
                        }
                    }

                    TextArea {
                        topPadding: 4
                        id: announcementContent
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        placeholderText: "Content"
                        wrapMode: TextArea.Wrap
                        font.pixelSize: 14
                        background: Rectangle {
                            radius: 5
                            border.color: "#bdc3c7"
                            border.width: 1
                        }
                    }

                    Button {
                        text: "Add Announcement"
                        padding: 20
                        font.pixelSize: 14
                        highlighted: true
                        background: Rectangle {
                            radius: 8
                            color: "#c0392b"
                            height: 35
                        }
                        contentItem: Text {
                            text: parent.text
                            color: "white"
                            font.pixelSize: 14
                        }
                        onClicked: {
                            if (announcementTitle.text && announcementDate.text && announcementContent.text) {
                                        fileManager.saveAnnouncement(announcementTitle.text, announcementDate.text, announcementContent.text);
                                        reloadAnnouncements();

                                announcementTitle.text = "";
                                announcementDate.text = "";
                                announcementContent.text = "";
                            }
                        }
                    }
                }
            }

            // Current Announcements List
            Rectangle {
                Layout.fillWidth: true
                Layout.fillHeight: true
                radius: 15
                color: "white"

                layer.enabled: true
                layer.effect: DropShadow {
                    color: "#20000000"
                    radius: 12
                    samples: 15
                    verticalOffset: 2
                }

                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 20
                    spacing: 15

                    Text {
                        text: "Current Announcements"
                        font.pixelSize: 18
                        font.bold: true
                        font.family: "Inter"
                        color: "black"
                    }

                    ListView {
                        model:  adminAnnouncementsModel
                        id: announcementsList
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        clip: true
                        spacing: 10

                        delegate: Rectangle {
                            width: announcementsList.width
                            height: announcementColumn.height + 20
                            radius: 8
                            color: "#f8f9fa"
                            border.color: "#e9ecef"
                            border.width: 1

                            Column {
                                id: announcementColumn
                                width: parent.width - 20
                                anchors.centerIn: parent
                                spacing: 5

                                RowLayout {
                                    width: parent.width
                                    spacing: 10

                                    Text {
                                        text: title
                                        font.pixelSize: 16
                                        font.bold: true
                                        color: "black"
                                        Layout.fillWidth: true
                                    }

                                    Text {
                                        text: date
                                        font.pixelSize: 13
                                        color: "#95a5a6"
                                    }

                                    Button {
                                        text: "Delete"
                                        font.pixelSize: 12
                                        flat: true
                                        contentItem: Text {
                                            text: parent.text
                                            color: "#e74c3c"
                                        }
                                        background: Rectangle { color: "transparent" }
                                        onClicked: {
                                            fileManager.removeAnnouncement(index)
                                            reloadAnnouncements();
                                        }
                                    }
                                }

                                Text {
                                    text: content
                                    width: parent.width
                                    font.pixelSize: 14
                                    color: "#7f8c8d"
                                    wrapMode: Text.WordWrap
                                }
                            }
                        }
                    }
                }
            }
        }

        // --------------------------------------------------------------------------- Events Management View ----------------------------------------------------------------------------------------
        ColumnLayout {
            id: eventsView
            x: sidebar.width
            y: topBar.height
            visible: dashboardPage === "manage events"
            anchors.fill: parent
            anchors.margins: 30
            spacing: 20

            Text {
                text: "Manage Events"
                font.pixelSize: 24
                font.bold: true
                color: "#c0392b"
            }

            // Add New Event Form
            Rectangle {
                Layout.fillWidth: true
                height: 150
                radius: 15
                color: "white"

                layer.enabled: true
                layer.effect: DropShadow {
                    color: "#20000000"
                    radius: 12
                    samples: 15
                    verticalOffset: 2
                }

                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 20
                    spacing: 4

                    Text {
                        text: "Add New Event"
                        font.pixelSize: 18
                        font.bold: true
                        font.family: "Inter"
                        color: "black"
                    }

                    RowLayout {
                        Layout.fillWidth: true
                        spacing: 15

                        TextField {
                            topPadding: 7.5
                            id: eventTitle
                            Layout.fillWidth: true
                            placeholderText: "Event Title"
                            font.pixelSize: 14
                            background: Rectangle {
                                radius: 5
                                border.color: "#bdc3c7"
                                border.width: 1
                                implicitHeight: 35
                            }
                        }

                        TextField {
                            topPadding: 7.5
                            id: eventDate
                            Layout.fillWidth: true
                            placeholderText: "Date (e.g., June 20, 2023 or June 25-30, 2023)"
                            font.pixelSize: 14
                            background: Rectangle {
                                radius: 5
                                border.color: "#bdc3c7"
                                border.width: 1
                                implicitHeight: 35
                            }
                        }
                    }

                    Button {
                        text: "Add Event"
                        padding: 20
                        font.pixelSize: 14
                        highlighted: true
                        background: Rectangle {
                            radius: 8
                            color: "#c0392b"
                            height: 30
                        }
                        contentItem: Text {
                            text: parent.text
                            color: "white"
                        }
                        onClicked: {
                            if (eventTitle.text && eventDate.text) {
                                        fileManager.saveEvent(eventTitle.text, eventDate.text);
                                        reloadEvents();

                                // Clear the fields
                                eventTitle.text = "";
                                eventDate.text = "";
                            }
                        }
                    }
                }
            }

            // Current Events List
            Rectangle {
                Layout.fillWidth: true
                Layout.fillHeight: true
                radius: 15
                color: "white"

                layer.enabled: true
                layer.effect: DropShadow {
                    color: "#20000000"
                    radius: 12
                    samples: 15
                    verticalOffset: 2
                }

                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 20
                    spacing: 15

                    Text {
                        text: "Current Events"
                        font.pixelSize: 18
                        font.bold: true
                        font.family: "Inter"
                        color: "black"
                    }

                    ListView {
                        id: eventsList
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        clip: true
                        spacing: 10
                        model: adminEventsModel

                        delegate: Rectangle {
                            width: eventsList.width
                            height: 70
                            radius: 8
                            color: "#f8f9fa"
                            border.color: "#e9ecef"
                            border.width: 1

                            RowLayout {
                                anchors.fill: parent
                                anchors.margins: 10
                                spacing: 15

                                ColumnLayout {
                                    Layout.fillWidth: true
                                    spacing: 5

                                    Text {
                                        text: title
                                        font.pixelSize: 16
                                        font.bold: true
                                        color: "black"
                                    }

                                    RowLayout {
                                        spacing: 5

                                        Text {
                                            text: "📅 " + date
                                            font.pixelSize: 14
                                            color: "#7f8c8d"
                                        }
                                    }
                                }

                                Button {
                                    anchors.right: parent.right
                                    text: "Delete"
                                    font.pixelSize: 12
                                    flat: true
                                    contentItem: Text {
                                        text: parent.text
                                        color: "#e74c3c"
                                    }
                                    background: Rectangle { color: "transparent" }
                                    onClicked: {
                                            fileManager.removeEvent(index);
                                            reloadEvents();
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }

        // -------------------------------------------------------------------------- Scholarship Management View -------------------------------------------------------------------------------------
        ColumnLayout {
            x: sidebar.width
            y: topBar.height
            id: scholarshipsView
            visible: dashboardPage === "manage scholarships"
            anchors.fill: parent
            anchors.margins: 30
            spacing: 20

            Text {
                text: "Manage Scholarships"
                font.pixelSize: 24
                font.bold: true
                color: "#c0392b"
            }

            // Add New Scholarship Form
            Rectangle {
                Layout.fillWidth: true
                height: 400
                radius: 15
                color: "white"

                layer.enabled: true
                layer.effect: DropShadow {
                    color: "#20000000"
                    radius: 12
                    samples: 15
                    verticalOffset: 2
                }

                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 20
                    spacing: 15

                    Text {
                        text: "Add New Scholarship"
                        font.pixelSize: 18
                        font.bold: true
                        color: "black"
                    }

                    GridLayout {
                        columns: 2
                        columnSpacing: 20
                        rowSpacing: 10
                        Layout.fillWidth: true

                        // Name
                        Text {
                            text: "Name:"
                            font.pixelSize: 13
                        }
                        TextField {
                            topPadding: 8
                            id: scholarshipName
                            Layout.fillWidth: true
                            placeholderText: "Scholarship name"
                            font.pixelSize: 13
                            background: Rectangle {
                                radius: 5
                                border.color: "#bdc3c7"
                                border.width: 1
                                implicitHeight: 32
                            }
                        }

                        // Deadline
                        Text {
                            text: "Deadline:"
                            font.pixelSize: 13
                        }
                        TextField {
                            topPadding: 8
                            id: scholarshipDeadline
                            Layout.fillWidth: true
                            placeholderText: "Deadline date"
                            font.pixelSize: 13
                            background: Rectangle {
                                radius: 5
                                border.color: "#bdc3c7"
                                border.width: 1
                                implicitHeight: 32
                            }
                        }

                        // Eligibility Description
                        Text {
                            text: "Eligibility Description:"
                            font.pixelSize: 13
                            Layout.alignment: Qt.AlignTop
                        }
                        TextArea {
                            topPadding: 6
                            width: 20
                            id: scholarshipDescription
                            Layout.fillWidth: true
                            placeholderText: "Description (Press enter for new line)"
                            wrapMode: TextArea.Wrap
                            font.pixelSize: 13
                            background: Rectangle {
                                radius: 5
                                border.color: "#bdc3c7"
                                border.width: 1
                            }
                        }

                        // Link
                        Text {
                            text: "Link:"
                            font.pixelSize: 13
                        }
                        TextField {
                            topPadding: 8
                            id: scholarshipLink
                            Layout.fillWidth: true
                            placeholderText: "Application link"
                            font.pixelSize: 13
                            background: Rectangle {
                                radius: 5
                                border.color: "#bdc3c7"
                                border.width: 1
                                implicitHeight: 32
                            }
                        }

                        // Course
                        Text {
                            text: "Course:"
                            font.pixelSize: 13
                        }
                        ColumnLayout {
                            Layout.fillWidth: true

                            Button {
                                id: courseButton
                                text: "Select Courses"
                                Layout.fillWidth: true
                                background: Rectangle {
                                    radius: 5
                                    border.color: "#bdc3c7"
                                    border.width: 1
                                    implicitHeight: 32
                                    color: "#f8f9fa"
                                }
                                onClicked: {
                                    coursePopup.selectedCourses = [];
                                    coursePopup.open();
                                }
                            }
                        }

                        // Year Level
                        Text {
                            text: "Year Level:"
                            font.pixelSize: 13
                        }
                        ComboBox {
                            id: scholarshipYearLevel
                            Layout.fillWidth: true
                            model: ["Senior High School", "1st Year College", "2nd Year College", "3rd Year College", "4th Year College"]
                            background: Rectangle {
                                radius: 5
                                border.color: "#bdc3c7"
                                border.width: 1
                                implicitHeight: 32
                                color: "#f8f9fa"
                            }
                        }

                        // Financial Need
                        Text {
                            text: "Financial Need:"
                            font.pixelSize: 14
                        }
                        RowLayout {
                            RadioButton {
                                text: "Yes"
                                checked: true
                            }
                            RadioButton {
                                text: "No"
                            }
                        }
                    }

                    Button {
                        text: "Add Scholarship"
                        padding: 15
                        font.pixelSize: 14
                        Layout.alignment: Qt.AlignRight
                        highlighted: true
                        background: Rectangle {
                            radius: 8
                            color: "#c0392b"
                            height: 35
                        }
                        contentItem: Text {
                            text: parent.text
                            color: "white"
                            font.pixelSize: 14
                        }

                        onClicked: {
                            if (scholarshipName.text && scholarshipDeadline.text) {
                                var financialNeed = "No";
                                if (scholarshipFinancialNeed.children[0].checked) {
                                    financialNeed = "Yes";
                                }

                                // Convert selected courses to QJsonArray
                                var coursesArray = [];
                                for (var i = 0; i < coursePopup.selectedCourses.length; i++) {
                                    coursesArray.push(coursePopup.selectedCourses[i]);
                                }

                                fileManager.saveScholarship(
                                    scholarshipName.text,
                                    scholarshipDeadline.text,
                                    scholarshipDescription.text,
                                    scholarshipLink.text,
                                    coursesArray,
                                    scholarshipYearLevel.currentText,
                                    financialNeed
                                );

                                reloadScholarships();

                                scholarshipName.text = "";
                                scholarshipDeadline.text = "";
                                scholarshipDescription.text = "";
                                scholarshipLink.text = "";
                                scholarshipYearLevel.currentIndex = 0;
                                scholarshipFinancialNeed.children[0].checked = true;
                                coursePopup.selectedCourses = [];
                                courseDisplay.text = "No courses selected";
                            }
                        }
                    }
                }
            }

            // Current Scholarships List
            Rectangle {
                Layout.fillWidth: true
                Layout.fillHeight: true
                radius: 15
                color: "white"

                layer.enabled: true
                layer.effect: DropShadow {
                    color: "#20000000"
                    radius: 12
                    samples: 15
                    verticalOffset: 2
                }

                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 20
                    spacing: 15

                    Text {
                        text: "Current Scholarships"
                        font.pixelSize: 18
                        font.bold: true
                        color: "black"
                    }

                    ListView {
                        id: scholarshipsList
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        clip: true
                        spacing: 10
                        model: adminScholarshipsModel

                        delegate: Rectangle {
                            width: scholarshipsList.width
                            height: 50
                            radius: 8
                            color: "#f8f9fa"
                            border.color: "#e9ecef"
                            border.width: 1

                            RowLayout {
                                anchors.fill: parent
                                anchors.margins: 10
                                spacing: 15

                                ColumnLayout {
                                    Layout.fillWidth: true
                                    spacing: 3

                                    Text {
                                        text: name
                                        font.pixelSize: 12
                                        font.bold: true
                                        color: "black"
                                    }

                                    RowLayout {
                                        Text {
                                            text: "📅 " + deadline
                                            font.pixelSize: 10
                                            color: "#7f8c8d"
                                        }
                                    }
                                }

                                Button {
                                    text: "Delete"
                                    font.pixelSize: 12
                                    flat: true
                                    anchors.right: parent.right
                                    anchors.rightMargin: 30
                                    contentItem: Text {
                                        text: parent.text
                                        color: "#e74c3c"
                                    }
                                    background: Rectangle { color: "transparent" }
                                    onClicked: {
                                        fileManager.removeScholarship(index);
                                        reloadScholarships();
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }

        Popup {
            id: coursePopup
            width: 400
            height: 300
            modal: true
            focus: true
            closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside
            padding: 20 // Keep padding for content spacing
            x: (parent.width - width) / 2
            y: (parent.height - height) / 2

            property var selectedCourses: []

            ColumnLayout {
                anchors.fill: parent
                spacing: 10

                Text {
                    text: "Select Courses"
                    font.bold: true
                    font.pixelSize: 18
                    Layout.alignment: Qt.AlignHCenter
                }

                Item {
                    height: 10
                }

                ScrollView {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    clip: true

                    GridLayout {
                        width: parent.width
                        columns: 2
                        columnSpacing: 15
                        rowSpacing: 10

                        Repeater {
                            model: [
                                "B Fine Arts (Product Design)",
                                "B Fine Arts (Studio Arts)",
                                "BA Communication",
                                "BA Psychology",
                                "BA Political Science",
                                "BS Biology",
                                "BS Computer Science",
                                "BA Management",
                                "BS Mathematics",
                                "BS Statistics"
                            ]

                            CheckBox {
                                text: modelData
                                checked: coursePopup.selectedCourses.includes(modelData)
                                onCheckedChanged: {
                                    if (checked && !coursePopup.selectedCourses.includes(modelData)) {
                                        coursePopup.selectedCourses.push(modelData);
                                    } else if (!checked) {
                                        coursePopup.selectedCourses = coursePopup.selectedCourses.filter(c => c !== modelData);
                                    }
                                }
                            }
                        }
                    }
                }

                RowLayout {
                    Layout.alignment: Qt.AlignRight
                    spacing: 10

                    Button {
                        text: "Cancel"
                        onClicked: coursePopup.close()
                    }

                    Button {
                        text: "OK"
                        highlighted: true
                        onClicked: {
                            coursePopup.close()
                            if (coursePopup.selectedCourses.length > 0) {
                                courseDisplay.text = coursePopup.selectedCourses.length + " courses selected";
                            } else {
                                courseDisplay.text = "No courses selected";
                            }
                        }
                    }
                }
            }
        }

    // ------------------------------------------------------------------------------- Internship Management View -------------------------------------------------------------------------------------
        ColumnLayout {
            x: sidebar.width
            y: topBar.height
            id: internshipsView
            visible: dashboardPage === "manage internships"
            anchors.fill: parent
            anchors.margins: 30
            spacing: 20

            Text {
                text: "Manage Internships"
                font.pixelSize: 24
                font.bold: true
                color: "#c0392b"
            }

            // Add New Internship Form
            Rectangle {
                Layout.fillWidth: true
                height: 400
                radius: 15
                color: "white"

                layer.enabled: true
                layer.effect: DropShadow {
                    color: "#20000000"
                    radius: 12
                    samples: 15
                    verticalOffset: 2
                }

                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 20
                    spacing: 15

                    Text {
                        text: "Add New Internship"
                        font.pixelSize: 18
                        font.bold: true
                        color: "black"
                    }

                    GridLayout {
                        columns: 2
                        columnSpacing: 20
                        rowSpacing: 10
                        Layout.fillWidth: true

                        // Name
                        Text {
                            text: "Company Name:"
                            font.pixelSize: 13
                        }
                        TextField {
                            topPadding: 8
                            id: internshipName
                            Layout.fillWidth: true
                            placeholderText: "Name"
                            font.pixelSize: 13
                            background: Rectangle {
                                radius: 5
                                border.color: "#bdc3c7"
                                border.width: 1
                                implicitHeight: 32
                            }
                        }

                        // Deadline
                        Text {
                            text: "Deadline:"
                            font.pixelSize: 13
                        }
                        TextField {
                            topPadding: 8
                            id: internshipDeadline
                            Layout.fillWidth: true
                            placeholderText: "Deadline date"
                            font.pixelSize: 13
                            background: Rectangle {
                                radius: 5
                                border.color: "#bdc3c7"
                                border.width: 1
                                implicitHeight: 32
                            }
                        }

                        // Eligibility Description
                        Text {
                            text: "Eligibility Description:"
                            font.pixelSize: 13
                            Layout.alignment: Qt.AlignTop
                        }
                        TextArea {
                            topPadding: 6
                            width: 20
                            id: internshipDescription
                            Layout.fillWidth: true
                            placeholderText: "Description (Press enter for new line)"
                            wrapMode: TextArea.Wrap
                            font.pixelSize: 13
                            background: Rectangle {
                                radius: 5
                                border.color: "#bdc3c7"
                                border.width: 1
                            }
                        }

                        // Link
                        Text {
                            text: "Link:"
                            font.pixelSize: 13
                        }
                        TextField {
                            topPadding: 8
                            id: internshipLink
                            Layout.fillWidth: true
                            placeholderText: "Application link"
                            font.pixelSize: 13
                            background: Rectangle {
                                radius: 5
                                border.color: "#bdc3c7"
                                border.width: 1
                                implicitHeight: 32
                            }
                        }

                        // Course
                        Text {
                            text: "Course:"
                            font.pixelSize: 13
                        }
                        ColumnLayout {
                            Layout.fillWidth: true

                            Button {
                                id: courseButtonInternship
                                text: "Select Courses"
                                Layout.fillWidth: true
                                background: Rectangle {
                                    radius: 5
                                    border.color: "#bdc3c7"
                                    border.width: 1
                                    implicitHeight: 32
                                    color: "#f8f9fa"
                                }
                                onClicked: {
                                    coursePopupInterns.selectedCourses = [];
                                    coursePopupInterns.open();
                                }
                            }
                        }

                        // Year Level
                        Text {
                            text: "Year Level:"
                            font.pixelSize: 13
                        }
                        ComboBox {
                            id: internshipYearLevel
                            Layout.fillWidth: true
                            model: ["Senior High School", "1st Year College", "2nd Year College", "3rd Year College", "4th Year College"]
                            background: Rectangle {
                                radius: 5
                                border.color: "#bdc3c7"
                                border.width: 1
                                implicitHeight: 32
                                color: "#f8f9fa"
                            }
                        }
                    }

                    Button {
                        text: "Add Internship"
                        padding: 15
                        font.pixelSize: 14
                        Layout.alignment: Qt.AlignRight
                        highlighted: true
                        background: Rectangle {
                            radius: 8
                            color: "#c0392b"
                            height: 35
                        }
                        contentItem: Text {
                            text: parent.text
                            color: "white"
                            font.pixelSize: 14
                        }
                        onClicked: {
                            if (internshipName.text && internshipDeadline.text) {

                                var coursesArrayIntern = [];
                                for (var i = 0; i < coursePopupInterns.selectedCourses.length; i++) {
                                    coursesArrayIntern.push(coursePopupInterns.selectedCourses[i]);
                                }

                                fileManager.saveInternship(
                                    internshipName.text,
                                    internshipDeadline.text,
                                    internshipDescription.text,
                                    internshipLink.text,
                                    coursesArrayIntern,
                                    internshipYearLevel.currentText,
                                );

                                reloadInternships();

                                // Clear fields
                                internshipName.text = "";
                                internshipDeadline.text = "";
                                internshipDescription.text = "";
                                internshipLink.text = "";
                                internshipYearLevel.currentIndex = 0;
                                coursePopupInterns.selectedCourses = [];
                            }
                        }
                    }
                }
            }

            // Current Internships List
            Rectangle {
                Layout.fillWidth: true
                Layout.fillHeight: true
                radius: 15
                color: "white"

                layer.enabled: true
                layer.effect: DropShadow {
                    color: "#20000000"
                    radius: 12
                    samples: 15
                    verticalOffset: 2
                }

                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 20
                    spacing: 15

                    Text {
                        text: "Current Internships"
                        font.pixelSize: 18
                        font.bold: true
                        color: "black"
                    }

                    ListView {
                        id: internshipsList
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        clip: true
                        spacing: 10
                        model: adminInternshipsModel

                        delegate: Rectangle {
                            width: internshipsList.width
                            height: 50
                            radius: 8
                            color: "#f8f9fa"
                            border.color: "#e9ecef"
                            border.width: 1

                            RowLayout {
                                anchors.fill: parent
                                anchors.margins: 10
                                spacing: 15

                                ColumnLayout {
                                    Layout.fillWidth: true
                                    spacing: 3

                                    Text {
                                        text: name
                                        font.pixelSize: 12
                                        font.bold: true
                                        color: "black"
                                    }

                                    RowLayout {
                                        Text {
                                            text: "📅 " + deadline
                                            font.pixelSize: 10
                                            color: "#7f8c8d"
                                        }
                                    }
                                }

                                Button {
                                    text: "Delete"
                                    font.pixelSize: 12
                                    flat: true
                                    anchors.right: parent.right
                                    anchors.rightMargin: 30
                                    contentItem: Text {
                                        text: parent.text
                                        color: "#e74c3c"
                                    }
                                    background: Rectangle { color: "transparent" }
                                    onClicked: {
                                        fileManager.removeInternship(index);
                                        reloadInternships();
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }

        Popup {
            id: coursePopupInterns
            width: 400
            height: 300
            modal: true
            focus: true
            closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside
            padding: 20 // Keep padding for content spacing
            x: (parent.width - width) / 2
            y: (parent.height - height) / 2

            property var selectedCourses: []

            ColumnLayout {
                anchors.fill: parent
                spacing: 10

                Text {
                    text: "Select Courses"
                    font.bold: true
                    font.pixelSize: 18
                    Layout.alignment: Qt.AlignHCenter
                }

                Item {
                    height: 10
                }

                ScrollView {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    clip: true

                    GridLayout {
                        width: parent.width
                        columns: 2
                        columnSpacing: 15
                        rowSpacing: 10

                        Repeater {
                            model: [
                                "B Fine Arts (Product Design)",
                                "B Fine Arts (Studio Arts)",
                                "BA Communication",
                                "BA Psychology",
                                "BA Political Science",
                                "BS Biology",
                                "BS Computer Science",
                                "BA Management",
                                "BS Mathematics",
                                "BS Statistics"
                            ]

                            CheckBox {
                                text: modelData
                                checked: coursePopupInterns.selectedCourses.includes(modelData)
                                onCheckedChanged: {
                                    if (checked && !coursePopupInterns.selectedCourses.includes(modelData)) {
                                        coursePopupInterns.selectedCourses.push(modelData);
                                    } else if (!checked) {
                                        coursePopupInterns.selectedCourses = coursePopupInterns.selectedCourses.filter(c => c !== modelData);
                                    }
                                }
                            }
                        }
                    }
                }

                RowLayout {
                    Layout.alignment: Qt.AlignRight
                    spacing: 10

                    Button {
                        text: "Cancel"
                        onClicked: coursePopupInterns.close()
                    }

                    Button {
                        text: "OK"
                        highlighted: true
                        onClicked: {
                            coursePopupInterns.close()
                        }
                    }
                }
            }
        }

        // ----------------------------------------------------------------------------- Tutoring Management View --------------------------------------------------------------------------------------
        ColumnLayout {
            id: tutoringView
            x: sidebar.width
            y: topBar.height
            visible: dashboardPage === "manage tutoring"
            anchors.fill: parent
            anchors.margins: 30
            spacing: 5

            Text {
                text: "Manage Tutoring"
                font.pixelSize: 24
                font.bold: true
                color: "#c0392b"
            }

            Item{
                Layout.preferredHeight: 10
            }

            RowLayout {
                Layout.fillWidth: true
                spacing: 15

                Button {
                    text: "Add Tutor"
                    padding: 11
                    highlighted: true
                    background: Rectangle {
                        radius: 8
                        color: "#c0392b"
                        height: 30
                    }
                    contentItem: Text {
                        topPadding: 2
                        text: parent.text
                        color: "white"
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        font.pixelSize: 10
                        font.family: "Inter"
                    }
                    onClicked: {
                        tutorName.text = "";
                        tutorEmail.text = "";
                        tutorSubjects.text = "";
                        tutorCourse.currentIndex = -1;
                        tutorYearLevel.currentIndex = -1;
                        addTutorPopup.open();
                    }
                }

                Button {
                    text: "Manage Applications"
                    padding: 10
                    highlighted: true
                    background: Rectangle {
                        radius: 8
                        color: "#c0392b"
                        height: 30
                    }
                    contentItem: Text {
                        topPadding: 2
                        text: parent.text
                        color: "white"
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        font.pixelSize: 11
                        font.family: "Inter"
                    }
                    onClicked: {
                        manageApplicationsPopup.open();
                    }
                }

                Button {
                    text: "Manage Requests"
                    padding: 10
                    highlighted: true
                    background: Rectangle {
                        radius: 8
                        color: "#c0392b"
                        height: 30
                    }
                    contentItem: Text {
                        topPadding: 2
                        text: parent.text
                        color: "white"
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        font.pixelSize: 11
                        font.family: "Inter"
                    }
                    onClicked: {
                        manageRequestsPopup.open();
                    }
                }

                Item { Layout.fillWidth: true }
            }

            Item {
                Layout.preferredHeight: 8
            }

            // Tutors List
            Rectangle {
                Layout.fillWidth: true
                Layout.fillHeight: true
                radius: 15
                color: "white"

                layer.enabled: true
                layer.effect: DropShadow {
                    color: "#20000000"
                    radius: 12
                    samples: 15
                    verticalOffset: 2
                }

                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 20
                    spacing: 15

                    Text {
                        text: "Active Tutors"
                        font.pixelSize: 18
                        font.bold: true
                        color: "black"
                    }

                    // Tutors Table Header
                    RowLayout {
                        spacing: 15
                        height: 40

                        Text {
                            text: "Name"
                            font.bold: true
                            Layout.preferredWidth: 260
                            Layout.alignment: Qt.AlignLeft
                        }

                        Text {
                            text: "Course"
                            font.bold: true
                            Layout.preferredWidth: 310
                            Layout.alignment: Qt.AlignLeft
                        }

                        Text {
                            text: "Year Level"
                            font.bold: true
                            Layout.preferredWidth: 190
                            Layout.alignment: Qt.AlignLeft
                        }

                        Text {
                            text: "Status"
                            font.bold: true
                            Layout.preferredWidth: 60
                            Layout.alignment: Qt.AlignLeft
                        }
                    }

                    Rectangle {
                        Layout.fillWidth: true
                        height: 1
                        color: "#e0e0e0"
                    }

                    // Tutors List
                    ListView {
                        id: tutorsList
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        visible: true
                        clip: true
                        spacing: 10
                        model: ListModel { id: tutorsModel }

                        delegate: Rectangle {
                            width: tutorsList.width
                            height: 50
                            radius: 8
                            color: "#f8f9fa"
                            border.color: "#e9ecef"
                            border.width: 1

                            RowLayout {
                                anchors.fill: parent
                                anchors.margins: 10
                                spacing: 15

                                Text {
                                    text: name
                                    font.pixelSize: 14
                                    Layout.preferredWidth: 200
                                    elide: Text.ElideRight
                                    Layout.alignment: Qt.AlignVCenter | Qt.AlignLeft
                                }

                                Text {
                                    text: course
                                    font.pixelSize: 14
                                    Layout.preferredWidth: 250
                                    elide: Text.ElideRight
                                    Layout.alignment: Qt.AlignVCenter | Qt.AlignLeft
                                }

                                Text {
                                    text: yearLevel
                                    font.pixelSize: 14
                                    Layout.preferredWidth: 150
                                    Layout.alignment: Qt.AlignVCenter | Qt.AlignLeft
                                }

                                Text {
                                    text: status
                                    font.pixelSize: 14
                                    font.bold: true
                                    color: status === "Approved" ? "#27ae60" : "#f39c12"
                                    Layout.preferredWidth: 200
                                    Layout.alignment: Qt.AlignVCenter | Qt.AlignLeft
                                }

                                RowLayout {
                                    spacing: 10
                                    Layout.fillWidth: true // Allows this RowLayout to take remaining space
                                    Layout.alignment: Qt.AlignVCenter | Qt.AlignRight // Align the whole button group to the right

                                    Button {
                                        text: "Edit"
                                        padding: 8
                                        font.pixelSize: 12
                                        background: Rectangle {
                                            radius: 5
                                            color: "#c0392b"
                                        }
                                        contentItem: Text {
                                            text: parent.text
                                            color: "white"
                                            horizontalAlignment: Text.AlignHCenter
                                            verticalAlignment: Text.AlignVCenter
                                        }
                                        onClicked: {
                                                editTutorPopup.name = name;
                                                editTutorPopup.course = course;
                                                editTutorPopup.yearLevel = yearLevel;
                                                editTutorPopup.index = index;
                                                editTutorPopup.open();
                                        }
                                    }

                                    Button {
                                        text: "Delete"
                                        padding: 8
                                        font.pixelSize: 12
                                        background: Rectangle {
                                            radius: 5
                                            color: "#e74c3c"
                                        }
                                        contentItem: Text {
                                            text: parent.text
                                            color: "white"
                                            verticalAlignment: Text.AlignVCenter
                                        }
                                        onClicked: {
                                            fileManager.removeTutor(index);
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }

        // --- Popups ---
        Popup {
            id: addTutorPopup
            width: 500
            height: 400
            modal: true
            focus: true
            closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside
            padding: 20

            anchors.centerIn: parent

            background: Rectangle {
                radius: 15
                color: "white"
                layer.enabled: true
                layer.effect: DropShadow {
                    color: "#20000000"
                    radius: 12
                    samples: 15
                    verticalOffset: 2
                }
            }

            ColumnLayout {
                anchors.fill: parent
                spacing: 15

                Text {
                    text: "Add New Tutor"
                    font.pixelSize: 20
                    font.bold: true
                    Layout.alignment: Qt.AlignHCenter
                }

                GridLayout {
                    columns: 2
                    columnSpacing: 20
                    rowSpacing: 15
                    Layout.fillWidth: true

                    Text { text: "Name:"; font.pixelSize: 14 }
                    TextField {
                        id: tutorName
                        Layout.fillWidth: true
                        placeholderText: "Full Name"
                        font.pixelSize: 14
                        background: Rectangle {
                            radius: 5
                            border.color: "#bdc3c7"
                            border.width: 1
                            implicitHeight: 35
                        }
                    }

                    Text { text: "Course:"; font.pixelSize: 14 }
                    ComboBox {
                        id: tutorCourse
                        Layout.fillWidth: true
                        displayText: currentIndex === -1 ? "Select a course" : currentText
                        model: [
                            "B Fine Arts (Product Design)",
                            "B Fine Arts (Studio Arts)",
                            "BA Communication",
                            "BA Psychology",
                            "BA Political Science",
                            "BS Biology",
                            "BS Computer Science",
                            "BA Management",
                            "BS Mathematics",
                            "BS Statistics"
                        ]
                        background: Rectangle {
                            radius: 5
                            border.color: "#bdc3c7"
                            border.width: 1
                            implicitHeight: 35
                            color: "#fff0f5"
                        }
                    }

                    Text { text: "Year Level:"; font.pixelSize: 14 }
                    ComboBox {
                        id: tutorYearLevel
                        Layout.fillWidth: true
                        displayText: currentIndex === -1 ? "Select year level" : currentText
                        model: ["Senior High School", "1st Year College", "2nd Year College", "3rd Year College", "4th Year College"]
                        background: Rectangle {
                            radius: 5
                            border.color: "#bdc3c7"
                            border.width: 1
                            implicitHeight: 35
                            color: "#fff0f5"
                        }
                    }

                    Text { text: "Contact Email:"; font.pixelSize: 14 }
                    TextField {
                        id: tutorEmail
                        Layout.fillWidth: true
                        placeholderText: "Email address"
                        font.pixelSize: 14
                        background: Rectangle {
                            radius: 5
                            border.color: "#bdc3c7"
                            border.width: 1
                            implicitHeight: 35
                        }
                    }

                    Text { text: "Subjects:"; font.pixelSize: 14 }
                    TextField {
                        id: tutorSubjects
                        Layout.fillWidth: true
                        placeholderText: "Subjects (comma separated)"
                        font.pixelSize: 14
                        background: Rectangle {
                            radius: 5
                            border.color: "#bdc3c7"
                            border.width: 1
                            implicitHeight: 35
                        }
                    }
                }

                RowLayout {
                    Layout.alignment: Qt.AlignRight
                    spacing: 10

                    Button {
                        text: "Cancel"
                        background: Rectangle {
                            radius: 8
                            color: "white"
                            height: 35
                            border.width: 1
                            border.color: "#808080"
                        }
                        contentItem: Text {
                            text: parent.text
                            color: "black"
                            font.pixelSize: 14
                        }
                        onClicked: addTutorPopup.close()
                    }

                    Button {
                        text: "Add Tutor"
                        highlighted: true
                        background: Rectangle {
                            radius: 8
                            color: "#c0392b"
                            height: 35
                        }
                        contentItem: Text {
                            text: parent.text
                            color: "white"
                            font.pixelSize: 14
                        }
                        onClicked: {
                            var tutor = {
                                name: tutorName.text,
                                course: tutorCourse.currentText,
                                yearLevel: tutorYearLevel.currentText,
                                status: "Approved"
                            };

                            fileManager.saveTutor(tutor);
                            addTutorPopup.close();
                            }
                        }
                    }
                }
        }

        Popup {
            id: editTutorPopup
            width: 500
            height: 400
            modal: true
            focus: true
            closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside
            padding: 20

            anchors.centerIn: parent

            property string name: ""
            property string course: ""
            property string yearLevel: ""
            property int index: -1

            background: Rectangle {
                radius: 15
                color: "white"
                layer.enabled: true
                layer.effect: DropShadow {
                    color: "#20000000"
                    radius: 12
                    samples: 15
                    verticalOffset: 2
                }
            }

            ColumnLayout {
                anchors.fill: parent
                spacing: 15

                Text {
                    text: "Edit Tutor"
                    font.pixelSize: 20
                    font.bold: true
                    Layout.alignment: Qt.AlignHCenter
                }

                GridLayout {
                    columns: 2
                    columnSpacing: 20
                    rowSpacing: 15
                    Layout.fillWidth: true

                    Text { text: "Name:"; font.pixelSize: 14 }
                    TextField {
                        id: editTutorName
                        text: editTutorPopup.name
                        Layout.fillWidth: true
                        placeholderText: "Full Name"
                        font.pixelSize: 14
                        background: Rectangle {
                            radius: 5
                            border.color: "#bdc3c7"
                            border.width: 1
                            implicitHeight: 35
                        }
                    }

                    Text { text: "Course:"; font.pixelSize: 14 }
                    ComboBox {
                        id: editTutorCourse
                        currentIndex: model.indexOf(editTutorPopup.course)
                        Layout.fillWidth: true
                        model: [
                            "B Fine Arts (Product Design)",
                            "B Fine Arts (Studio Arts)",
                            "BA Communication",
                            "BA Psychology",
                            "BA Political Science",
                            "BS Biology",
                            "BS Computer Science",
                            "BA Management",
                            "BS Mathematics",
                            "BS Statistics"
                        ]
                        background: Rectangle {
                            radius: 5
                            border.color: "#bdc3c7"
                            border.width: 1
                            implicitHeight: 35
                            color: "#fff0f5"
                        }
                    }

                    Text { text: "Year Level:"; font.pixelSize: 14 }
                    ComboBox {
                        id: editTutorYearLevel
                        currentIndex: model.indexOf(editTutorPopup.yearLevel)
                        Layout.fillWidth: true
                        model: ["Senior High School", "1st Year College", "2nd Year College", "3rd Year College", "4th Year College"]
                        background: Rectangle {
                            radius: 5
                            border.color: "#bdc3c7"
                            border.width: 1
                            implicitHeight: 35
                            color: "#fff0f5"
                        }
                    }

                    Text { text: "Contact Email:"; font.pixelSize: 14 }
                    TextField {
                        id: editTutorEmail
                        Layout.fillWidth: true
                        placeholderText: "Email address"
                        font.pixelSize: 14
                        background: Rectangle {
                            radius: 5
                            border.color: "#bdc3c7"
                            border.width: 1
                            implicitHeight: 35
                        }
                    }

                    Text { text: "Subjects:"; font.pixelSize: 14 }
                    TextField {
                        id: editTutorSubjects
                        Layout.fillWidth: true
                        placeholderText: "Subjects (comma separated)"
                        font.pixelSize: 14
                        background: Rectangle {
                            radius: 5
                            border.color: "#bdc3c7"
                            border.width: 1
                            implicitHeight: 35
                        }
                    }
                }

                RowLayout {
                    Layout.alignment: Qt.AlignRight
                    spacing: 10

                    Button {
                        text: "Cancel"
                        onClicked: editTutorPopup.close()
                    }

                    Button {
                        text: "Save Changes"
                        highlighted: true
                        onClicked: {
                            var tutor = {
                                name: editTutorName.text,
                                course: editTutorCourse.currentText,
                                yearLevel: editTutorYearLevel,
                                status: "Approved"
                            }
                            fileManager.updateTutor(editTutorPop.index, tutor);
                            editTutorPopup.close();
                        }
                    }
                }
            }
        }

        Popup {
            id: manageApplicationsPopup
            width: 800
            height: 500
            modal: true
            focus: true
            closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside
            padding: 20
            anchors.centerIn: parent

            function reloadApplications() {
                applicationsModel.clear();
                var apps = fileManager.loadApplications();
                for (var i = 0; i < apps.length; i++) {
                    applicationsModel.append(apps[i]);
                }
            }

            onOpened: {
                reloadApplications();
                fileManager.applicationsChanged.connect(reloadApplications);
            }

            onClosed: {
                fileManager.applicationsChanged.disconnect(reloadApplications);
            }


            background: Rectangle {
                radius: 15
                color: "white"
                layer.enabled: true
                layer.effect: DropShadow {
                    color: "#20000000"
                    radius: 12
                    samples: 15
                    verticalOffset: 2
                }
            }

            ColumnLayout {
                anchors.fill: parent
                spacing: 15

                Text {
                    text: "Manage Tutor Applications"
                    font.pixelSize: 20
                    font.bold: true
                    Layout.alignment: Qt.AlignHCenter
                }

                Item {
                    Layout.preferredHeight: 5
                }

                // Applications Table Header
                RowLayout {
                    width: applicationsList.width
                    Layout.fillWidth: true
                    height: 40

                    Text {
                        text: "Name"
                        font.bold: true
                        Layout.preferredWidth: 110
                        Layout.alignment: Qt.AlignLeft
                    }

                    Text {
                        text: "Course"
                        font.bold: true
                        Layout.preferredWidth: 100
                        Layout.alignment: Qt.AlignLeft
                    }

                    Text {
                        text: "Year Level"
                        font.bold: true
                        Layout.preferredWidth: 90
                        Layout.alignment: Qt.AlignLeft
                    }

                    Text {
                        text: "Application Date"
                        font.bold: true
                        Layout.preferredWidth: 120
                        Layout.alignment: Qt.AlignLeft
                    }

                    Text {
                        text: "Status"
                        font.bold: true
                        Layout.preferredWidth: 30
                        Layout.alignment: Qt.AlignLeft
                    }
                }

                Rectangle {
                    Layout.fillWidth: true
                    height: 1
                    color: "#e0e0e0"
                }

                // Applications List
                ListView {
                    id: applicationsList
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    clip: true
                    spacing: 10
                    model: ListModel { id: applicationsModel }

                    delegate: Rectangle {
                        width: applicationsList.width
                        height: 50
                        radius: 8
                        color: "#f8f9fa"
                        border.color: "#e9ecef"
                        border.width: 1

                        RowLayout {
                            anchors.fill: parent
                            anchors.margins: 10

                            Text {
                                text: name
                                Layout.preferredWidth: 100
                                elide: Text.ElideRight
                                Layout.alignment: Qt.AlignVCenter | Qt.AlignLeft
                            }

                            Text {
                                text: course
                                Layout.preferredWidth: 100
                                elide: Text.ElideRight
                                Layout.alignment: Qt.AlignVCenter | Qt.AlignLeft
                            }

                            Text {
                                text: yearLevel
                                Layout.preferredWidth: 100
                                Layout.alignment: Qt.AlignVCenter | Qt.AlignLeft
                            }

                            Text {
                                text: date
                                Layout.preferredWidth: 100
                                Layout.alignment: Qt.AlignVCenter | Qt.AlignLeft
                            }

                            Text {
                                text: status
                                font.bold: true
                                color: "#f39c12"
                                Layout.preferredWidth: 100
                                Layout.alignment: Qt.AlignVCenter | Qt.AlignLeft
                            }

                            RowLayout {
                                spacing: 10
                                Layout.fillWidth: true
                                Layout.alignment: Qt.AlignVCenter | Qt.AlignLeft

                                Button {
                                    text: "View Details"
                                    padding: 8
                                    font.pixelSize: 12
                                    background: Rectangle {
                                        radius: 5
                                        color: "#3498db"
                                    }
                                    contentItem: Text {
                                        text: parent.text
                                        color: "white"
                                        horizontalAlignment: Text.AlignHCenter
                                        verticalAlignment: Text.AlignVCenter
                                    }
                                    onClicked: {
                                        applicationDetailsPopup.name = name;
                                        applicationDetailsPopup.course = course;
                                        applicationDetailsPopup.yearLevel = yearLevel;
                                        applicationDetailsPopup.date = date;
                                        applicationDetailsPopup.subjects = subjects;           // Add this
                                        applicationDetailsPopup.qualifications = qualifications; // Add this
                                        applicationDetailsPopup.motivation = motivation;
                                        applicationDetailsPopup.index = index;
                                        applicationDetailsPopup.open();
                                    }
                                }

                                Button {
                                    text: "Approve"
                                    padding: 8
                                    font.pixelSize: 12
                                    background: Rectangle {
                                        radius: 5
                                        color: "#27ae60"
                                    }
                                    contentItem: Text {
                                        text: parent.text
                                        color: "white"
                                        horizontalAlignment: Text.AlignHCenter
                                        verticalAlignment: Text.AlignVCenter
                                    }
                                    onClicked: {
                                        fileManager.approveApplication(index);
                                    }
                                }

                                Button {
                                    text: "Reject"
                                    padding: 8
                                    font.pixelSize: 12
                                    background: Rectangle {
                                        radius: 5
                                        color: "#e74c3c"
                                    }
                                    contentItem: Text {
                                        text: parent.text
                                        color: "white"
                                        horizontalAlignment: Text.AlignHCenter
                                        verticalAlignment: Text.AlignVCenter
                                    }
                                    onClicked: {
                                        fileManager.removeApplication(index);
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }

        Popup {
            id: applicationDetailsPopup
            width: 500
            height: 400
            modal: true
            focus: true
            closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside
            padding: 20
            anchors.centerIn: parent

            property string name: ""
            property string course: ""
            property string yearLevel: ""
            property string date: ""
            property int index: -1
            property string subjects: ""
            property string qualifications: ""
            property string motivation: ""

            background: Rectangle {
                radius: 15
                color: "white"
                layer.enabled: true
                layer.effect: DropShadow {
                    color: "#20000000"
                    radius: 12
                    samples: 15
                    verticalOffset: 2
                }
            }

            ColumnLayout {
                anchors.fill: parent
                spacing: 15

                Text {
                    text: "Application Details"
                    font.pixelSize: 20
                    font.bold: true
                    Layout.alignment: Qt.AlignHCenter
                }

                GridLayout {
                    columns: 2
                    columnSpacing: 20
                    rowSpacing: 15
                    Layout.fillWidth: true

                    // Personal Information
                    Text { text: "Name:"; font.pixelSize: 14; font.bold: true }
                    Text {
                        text: applicationDetailsPopup.name
                        font.pixelSize: 14
                        Layout.fillWidth: true
                    }

                    Text { text: "Course:"; font.pixelSize: 14; font.bold: true }
                    Text {
                        text: applicationDetailsPopup.course
                        font.pixelSize: 14
                        Layout.fillWidth: true
                    }

                    Text { text: "Year Level:"; font.pixelSize: 14; font.bold: true }
                    Text {
                        text: applicationDetailsPopup.yearLevel
                        font.pixelSize: 14
                        Layout.fillWidth: true
                    }

                    Text { text: "Application Date:"; font.pixelSize: 14; font.bold: true }
                    Text {
                        text: applicationDetailsPopup.date
                        font.pixelSize: 14
                        Layout.fillWidth: true
                    }

                    // Academic Information
                    Text {
                        text: "Subjects:"
                        font.pixelSize: 14
                        font.bold: true
                        Layout.alignment: Qt.AlignTop
                    }
                    Text {
                        text: applicationDetailsPopup.subjects || "Not specified"
                        font.pixelSize: 14
                        Layout.fillWidth: true
                        wrapMode: Text.WordWrap
                    }

                    Text {
                        text: "Qualifications:"
                        font.pixelSize: 14
                        font.bold: true
                        Layout.alignment: Qt.AlignTop
                    }
                    Text {
                        text: applicationDetailsPopup.qualifications || "Not specified"
                        font.pixelSize: 14
                        Layout.fillWidth: true
                        wrapMode: Text.WordWrap
                    }

                    Text {
                        text: "Motivation:"
                        font.pixelSize: 14
                        font.bold: true
                        Layout.alignment: Qt.AlignTop
                    }
                    Text {
                        text: applicationDetailsPopup.motivation || "Not provided"
                        font.pixelSize: 14
                        Layout.fillWidth: true
                        wrapMode: Text.WordWrap
                    }
                }

                // Action Buttons
                RowLayout {
                    Layout.alignment: Qt.AlignRight
                    spacing: 10

                    Button {
                        text: "Approve"
                        visible: applicationDetailsPopup.status === "Pending"
                        onClicked: {
                            fileManager.approveApplication(applicationDetailsPopup.index);
                            applicationDetailsPopup.close();
                        }
                        background: Rectangle {
                            radius: 5
                            color: "#27ae60"
                        }
                        contentItem: Text {
                            text: parent.text
                            color: "white"
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }
                    }

                    Button {
                        text: "Reject"
                        visible: applicationDetailsPopup.status === "Pending"
                        onClicked: {
                            fileManager.removeApplication(applicationDetailsPopup.index);
                            applicationDetailsPopup.close();
                        }
                        background: Rectangle {
                            radius: 5
                            color: "#e74c3c"
                        }
                        contentItem: Text {
                            text: parent.text
                            color: "white"
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }
                    }

                    Button {
                        text: "Close"
                        onClicked: applicationDetailsPopup.close()
                        background: Rectangle {
                            radius: 5
                            color: "#3498db"
                        }
                        contentItem: Text {
                            text: parent.text
                            color: "white"
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }
                    }
                }
            }
        }

        Popup {
            id: manageRequestsPopup
            width: 800
            height: 500
            modal: true
            focus: true
            closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside
            padding: 20
            anchors.centerIn: parent

            function reloadRequests() {
                requestsModel.clear();
                var reqs = fileManager.loadTutorRequests();
                for (var i = 0; i < reqs.length; i++) {
                    requestsModel.append(reqs[i]);
                }
            }

            onOpened: {
                reloadRequests();
                fileManager.tutorRequestsChanged.connect(reloadRequests);
            }

            onClosed: {
                fileManager.tutorRequestsChanged.disconnect(reloadRequests);
            }

            background: Rectangle {
                radius: 15
                color: "white"
                layer.enabled: true
                layer.effect: DropShadow {
                    color: "#20000000"
                    radius: 12
                    samples: 15
                    verticalOffset: 2
                }
            }

            ColumnLayout {
                anchors.fill: parent
                spacing: 15

                Text {
                    text: "Manage Tutor Requests"
                    font.pixelSize: 20
                    font.bold: true
                    Layout.alignment: Qt.AlignHCenter
                }

                // Requests Table Header
                RowLayout {
                    Layout.fillWidth: true
                    height: 40

                    Text {
                        text: "Tutee"
                        font.bold: true
                        Layout.preferredWidth: 155
                    }

                    Text {
                        text: "Contact"
                        font.bold: true
                        Layout.preferredWidth: 137
                    }

                    Text {
                        text: "Date"
                        font.bold: true
                        Layout.preferredWidth: 175
                    }

                    Text {
                        text: "Status"
                        font.bold: true
                        Layout.preferredWidth: 80
                    }
                }

                Rectangle {
                    Layout.fillWidth: true
                    height: 1
                    color: "#e0e0e0"
                }

                // Requests List
                ListView {
                    id: requestsList
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    clip: true
                    spacing: 10
                    model: ListModel { id: requestsModel }

                    delegate: Rectangle {
                        width: requestsList.width
                        height: 50
                        radius: 8
                        color: "#f8f9fa"
                        border.color: "#e9ecef"
                        border.width: 1

                        RowLayout {
                            anchors.fill: parent
                            anchors.margins: 10
                            spacing: 10

                            Text {
                                text: tuteeName
                                Layout.preferredWidth: 100
                                elide: Text.ElideRight
                            }

                            Text {
                                text: tuteeEmail
                                Layout.preferredWidth: 100
                                elide: Text.ElideRight
                            }

                            Text {
                                text: Qt.formatDate(Date(), "MMMM d yyyy")
                                Layout.preferredWidth: 120
                            }

                            Text {
                                text: status
                                font.bold: true
                                color: status === "Approved" ? "#27ae60" : "#f39c12"
                                Layout.preferredWidth: 80
                            }

                            RowLayout {
                                spacing: 10
                                Layout.fillWidth: true
                                Layout.alignment: Qt.AlignRight

                                Button {
                                    text: "Approve"
                                    padding: 8
                                    font.pixelSize: 12
                                    background: Rectangle {
                                        radius: 5
                                        color: "#27ae60"
                                    }
                                    contentItem: Text {
                                        text: parent.text
                                        color: "white"
                                        horizontalAlignment: Text.AlignHCenter
                                        verticalAlignment: Text.AlignVCenter
                                    }
                                    onClicked: {
                                        // Update status to Approved
                                        requestsModel.setProperty(index, "status", "Approved");
                                        fileManager.saveAllRequests(requestsModel);
                                    }
                                }

                                Button {
                                    text: "Reject"
                                    padding: 8
                                    font.pixelSize: 12
                                    background: Rectangle {
                                        radius: 5
                                        color: "#e74c3c"
                                    }
                                    contentItem: Text {
                                        text: parent.text
                                        color: "white"
                                        horizontalAlignment: Text.AlignHCenter
                                        verticalAlignment: Text.AlignVCenter
                                    }
                                    onClicked: {
                                        // Remove the request
                                        requestsModel.remove(index);
                                        fileManager.saveAllRequests(requestsModel);
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        // ---------------------------------------------------------------------------------Manage Rooms----------------------------------------------------------------------------------------------------
        ColumnLayout {
            id: roomsView
            visible: dashboardPage === "manage rooms"
            anchors.fill: parent
            anchors.margins: 30
            spacing: 20

            property string currentRoomFilter: "all"

            function filterRooms(filter) {
                var allRooms = fileManager.loadRooms();
                sampleRoomsModel.clear();

                for (var i = 0; i < allRooms.length; i++) {
                    if (filter === "all" ||
                        (filter === "available" && allRooms[i].availability === "Available") ||
                        (filter === "booked" && allRooms[i].availability === "Booked")) {
                        sampleRoomsModel.append({
                            number: allRooms[i].number,
                            capacity: allRooms[i].capacity,
                            type: allRooms[i].type,
                            availability: allRooms[i].availability
                        });
                    }
                }
            }

            Text {
                text: "Manage Rooms"
                font.pixelSize: 28
                font.bold: true
                color: "#c0392b"
                Layout.alignment: Qt.AlignLeft
            }

            // Add New Room Form
            Rectangle {
                Layout.fillWidth: true
                height: 110
                radius: 15
                color: "white"
                border.color: "#e0e0e0"
                border.width: 1

                layer.enabled: true
                layer.effect: DropShadow {
                    color: "#40000000"
                    radius: 12
                    samples: 25
                    verticalOffset: 3
                }

                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 20
                    spacing: 6

                    Text {
                        text: "Add New Room"
                        font.pixelSize: 20
                        font.bold: true
                        color: "black"
                        Layout.alignment: Qt.AlignLeft
                    }

                    RowLayout {
                        Layout.fillWidth: true
                        spacing: 20

                        TextField {
                            id: roomNumber
                            Layout.preferredWidth: 450
                            font.pixelSize: 16
                            placeholderText: ""
                            padding: 10
                            verticalAlignment: Text.AlignVCenter

                            background: Rectangle {
                                radius: 8
                                border.color: roomNumber.activeFocus ? "#3498db" : "#bdc3c7"
                                border.width: 1
                                implicitHeight: 40
                            }

                            Text {
                                text: "Room Name (e.g. AS Hall, AS 309)"
                                visible: !parent.text && !parent.activeFocus
                                color: "#808080"
                                font: parent.font
                                anchors {
                                    verticalCenter: parent.verticalCenter
                                    left: parent.left
                                    leftMargin: 10
                                }
                            }
                        }


                        TextField {
                            id: roomCapacity
                            Layout.preferredWidth: 150
                            font.pixelSize: 16
                            validator: IntValidator { bottom: 1; top: 999 }
                            placeholderText: ""

                            padding: 10
                            verticalAlignment: Text.AlignVCenter

                            background: Rectangle {
                                radius: 8
                                border.color: roomNumber.activeFocus ? "#3498db" : "#bdc3c7"
                                border.width: 1
                                implicitHeight: 40
                            }

                            Text {
                                text: "Capacity"
                                visible: !parent.text && !parent.activeFocus
                                color: "#808080"
                                font: parent.font
                                anchors {
                                    verticalCenter: parent.verticalCenter
                                    left: parent.left
                                    leftMargin: 10
                                }
                            }
                        }

                        RowLayout {
                            Layout.preferredWidth: 200
                            spacing: 15

                            TextField {
                                id: roomType
                                Layout.fillWidth: true
                                font.pixelSize: 16
                                placeholderText: "e.g., Conference"
                                padding: 10
                                verticalAlignment: Text.AlignVCenter

                                background: Rectangle {
                                radius: 8
                                border.color: roomType.activeFocus ? "#3498db" : "#bdc3c7"
                                border.width: 1
                                implicitHeight: 40
                                }
                            }
                        }


                        Button {
                            id: addRoomButton
                            text: "Add Room"
                            padding: 15
                            font.pixelSize: 16
                            font.bold: true
                            Layout.preferredWidth: 150
                            Layout.preferredHeight: 40
                            background: Rectangle {
                                radius: 8
                                color: parent.down ? "#27ae60" : "#2ecc71"
                            }
                            contentItem: Text {
                                text: parent.text
                                color: "white"
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                                font: parent.font
                            }
                            onClicked: {
                                if (roomNumber.text && roomCapacity.text && roomType.text) {
                                    // Convert capacity to number and save
                                    fileManager.saveRoom(roomNumber.text, roomCapacity.text, roomType.text, "Available");
                                    roomNumber.text = "";
                                    roomCapacity.text = "";
                                    roomType.text = "";

                                }
                            }
                        }
                    }
                }
            }

            // Room Filter Controls
            RowLayout {
                Layout.fillWidth: true
                spacing: 20
                height: 50

                Text {
                    padding: 5
                    text: "Filter:"
                    font.pixelSize: 18
                    color: "black"
                    font.bold: true
                    verticalAlignment: Text.AlignVCenter
                    Layout.alignment: Qt.AlignVCenter
                }

                RowLayout {
                    spacing: 20
                    Layout.alignment: Qt.AlignVCenter

                    RadioButton {
                        id: allRoomsRadio
                        text: "All Rooms"
                        checked: true
                        font.pixelSize: 16
                        Layout.alignment: Qt.AlignVCenter

                        indicator: Rectangle {
                            implicitWidth: 20
                            implicitHeight: 20
                            radius: 10
                            border.color: allRoomsRadio.down ? "#3498db" : "#bdc3c7"
                            anchors.verticalCenter: parent.verticalCenter

                            Rectangle {
                                anchors.fill: parent
                                anchors.margins: 4
                                radius: 7
                                color: allRoomsRadio.checked ? "#3498db" : "transparent"
                                visible: allRoomsRadio.checked
                            }
                        }

                        contentItem: Text {
                            text: allRoomsRadio.text
                            font: allRoomsRadio.font
                            color: "black"
                            verticalAlignment: Text.AlignVCenter
                            leftPadding: allRoomsRadio.indicator.width + allRoomsRadio.spacing
                            anchors.verticalCenter: parent.verticalCenter
                        }

                        onCheckedChanged: {
                            if (checked) {
                                roomsView.currentRoomFilter = "all";
                                roomsView.filterRooms("all");
                            }
                        }
                    }

                    RadioButton {
                        id: availableRadio
                        text: "Available"
                        font.pixelSize: 16
                        Layout.alignment: Qt.AlignVCenter

                        indicator: Rectangle {
                            implicitWidth: 20
                            implicitHeight: 20
                            radius: 10
                            border.color: availableRadio.down ? "#3498db" : "#bdc3c7"
                            anchors.verticalCenter: parent.verticalCenter

                            Rectangle {
                                anchors.fill: parent
                                anchors.margins: 4
                                radius: 7
                                color: availableRadio.checked ? "#3498db" : "transparent"
                                visible: availableRadio.checked
                            }
                        }

                        contentItem: Text {
                            text: availableRadio.text
                            font: availableRadio.font
                            color: "black"
                            verticalAlignment: Text.AlignVCenter
                            leftPadding: availableRadio.indicator.width + availableRadio.spacing
                            anchors.verticalCenter: parent.verticalCenter
                        }

                        onCheckedChanged: {
                            if (checked) {
                                roomsView.currentRoomFilter = "available";
                                roomsView.filterRooms("available");
                            }
                        }
                    }

                    RadioButton {
                        id: bookedRadio
                        text: "Booked"
                        font.pixelSize: 16
                        Layout.alignment: Qt.AlignVCenter

                        indicator: Rectangle {
                            implicitWidth: 20
                            implicitHeight: 20
                            radius: 10
                            border.color: bookedRadio.down ? "#3498db" : "#bdc3c7"
                            anchors.verticalCenter: parent.verticalCenter

                            Rectangle {
                                anchors.fill: parent
                                anchors.margins: 4
                                radius: 7
                                color: bookedRadio.checked ? "#3498db" : "transparent"
                                visible: bookedRadio.checked
                            }
                        }

                        contentItem: Text {
                            text: bookedRadio.text
                            font: bookedRadio.font
                            color: "black"
                            verticalAlignment: Text.AlignVCenter
                            leftPadding: bookedRadio.indicator.width + bookedRadio.spacing
                            anchors.verticalCenter: parent.verticalCenter
                        }

                        onCheckedChanged: {
                            if (checked) {
                                roomsView.currentRoomFilter = "booked";
                                roomsView.filterRooms("booked");
                            }
                        }
                    }
                }

                Item { Layout.fillWidth: true }
            }

            // Current Rooms List
            Rectangle {
                Layout.fillWidth: true
                Layout.fillHeight: true
                radius: 15
                color: "white"
                border.color: "#e0e0e0"
                border.width: 1

                layer.enabled: true
                layer.effect: DropShadow {
                    color: "#40000000"
                    radius: 12
                    samples: 25
                    verticalOffset: 3
                }

                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 20
                    spacing: 15

                    // Header Row
                    RowLayout {
                        Layout.fillWidth: true
                        spacing: 20
                        visible: sampleRoomsModel.count > 0

                        Text {
                            text: "Added Rooms"
                            font.bold: true
                            font.pixelSize: 16
                            color: "black"
                            Layout.preferredWidth: 250
                        }

                        Text {
                            font.bold: true
                            font.pixelSize: 16
                            color: "black"
                            Layout.preferredWidth: 100
                        }

                        Text {
                            font.bold: true
                            font.pixelSize: 16
                            color: "black"
                            Layout.preferredWidth: 120
                        }

                        Item { Layout.fillWidth: true }
                    }

                    ListView {
                        id: roomsList
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        clip: true
                        spacing: 15
                        model: sampleRoomsModel

                        delegate: Rectangle {
                            width: roomsList.width
                            height: 80
                            radius: 10
                            color: availability === "Available" ? "#f0f9f0" : "#fef2f2"
                            border.color: availability === "Available" ? "#d1fae5" : "#fee2e2"

                            RowLayout {
                                anchors.fill: parent
                                anchors.margins: 15
                                spacing: 20

                                Text {
                                    text: number
                                    font.pixelSize: 18
                                    font.bold: true
                                    color: "#2d3436"
                                    Layout.preferredWidth: 250
                                }

                                Text {
                                    text: capacity + " people"
                                    font.pixelSize: 16
                                    color: "#636e72"
                                    Layout.preferredWidth: 100
                                }

                                Text {
                                    text: type
                                    font.pixelSize: 14
                                    color: "#2c3e50"
                                    Layout.preferredWidth: 200
                                    elide: Text.ElideRight
                                }

                                Rectangle {
                                    radius: 12
                                    width: 120
                                    height: 30
                                    color: availability === "Available" ? "#dcfce7" : "#fee2e2"
                                    border.color: availability === "Available" ? "#bbf7d0" : "#fecaca"

                                    Text {
                                        anchors.centerIn: parent
                                        text: availability
                                        font.pixelSize: 14
                                        font.bold: true
                                        color: availability === "Available" ? "#166534" : "#b91c1c"
                                    }
                                }

                                Row {
                                    spacing: 10
                                    Layout.alignment: Qt.AlignRight

                                    Button {
                                        text: "Update"
                                        padding: 12
                                        font.pixelSize: 14
                                        background: Rectangle {
                                            id: recColoradjust
                                            radius: 8
                                            color: parent.down ? "#dbeafe" : "#eff6ff"
                                            border.color: "#dbeafe"
                                        }
                                        onClicked: {
                                            var newStatus = (availability === "Available") ? "Booked" : "Available";
                                            fileManager.updateRoomAvailability(index, newStatus);
                                        }
                                    }

                                    Button {
                                        text: "Delete"
                                        padding: 12
                                        font.pixelSize: a14
                                        background: Rectangle {
                                            radius: 8
                                            color: parent.down ? "#fee2e2" : "#fff1f2"
                                            border.color: "#fee2e2"
                                        }
                                        onClicked: {
                                            fileManager.removeRoom(index);
                                        }
                                    }
                                }
                            }
                        }
                    }

                    // Empty state
                    Text {
                        text: "No additional rooms available\nClick 'Add Room' to create a new room"
                        visible: sampleRoomsModel.count === 0
                        font.pixelSize: 18
                        color: "#95a5a6"
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                    }
                }
            }
        }
}
