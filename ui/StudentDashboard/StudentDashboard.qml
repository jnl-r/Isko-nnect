import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import Qt5Compat.GraphicalEffects
import Qt.labs.platform 1.1
import FileManager 1.0

Rectangle {

    property ListModel studentAnnouncementsModel: ListModel {}
    property ListModel studentEventsModel: ListModel {}
    property ListModel tutorsModel: ListModel {}
    property ListModel studentScholarshipModel: ListModel{}
    property ListModel filteredScholarshipModel: ListModel {}
    property ListModel selectedPrograms: ListModel {}
    property ListModel selectedYears: ListModel {}
    property ListModel studentInternshipModel: ListModel{}
    property ListModel selectedProgramsIntern: ListModel {}
    property ListModel filteredInternshipModel: ListModel {}

    function reloadStudentData() {
        studentAnnouncementsModel.clear();
        studentEventsModel.clear();
        studentScholarshipModel.clear();
        studentInternshipModel.clear();

        var arr = fileManager.loadAnnouncements();
        for (var i = 0; i < arr.length; i++) {
            studentAnnouncementsModel.append(arr[i]);
        }

        arr = fileManager.loadEvents();
        for (i = 0; i < arr.length; i++) {
            studentEventsModel.append(arr[i]);
        }

        //Load scholarships
                arr = fileManager.loadScholarships();
                for (i = 0; i < arr.length; i++) {
                    var item = arr[i];
                    item.coursesString = item.courses.join(", "); // convert array to string
                    delete item.courses;

                    studentScholarshipModel.append(item);
                }

        //Load internships
        arr = fileManager.loadInternships();
        for (i = 0; i < arr.length; i++) {
            item = arr[i];
            item.coursesString = item.courses.join(", ");
            delete item.courses;
            studentInternshipModel.append(item);
        }

        filterScholarships("");
        filterInternships("");
    }

    function filterInternships(searchText){
            filteredInternshipModel.clear();
            var lowerSearch = searchText.toLowerCase();

            for (var i = 0; i < studentInternshipModel.count; i++) {
                var item = studentInternshipModel.get(i);

                var name = item.name ? item.name.toLowerCase() : "";
                var coursesString = item.coursesString ? item.coursesString.toLowerCase() : "";
                var deadline = item.deadline ? item.deadline.toLowerCase() : "";
                var description = item.description ? item.description.toLowerCase() : "";
                var link = item.link ? item.link.toLowerCase() : "";
                var yearLevel = item.yearLevel ? item.yearLevel.toLowerCase() : "";

                var matchesText =
                    name.indexOf(lowerSearch) !== -1 ||
                    coursesString.indexOf(lowerSearch) !== -1 ||
                    deadline.indexOf(lowerSearch) !== -1 ||
                    description.indexOf(lowerSearch) !== -1 ||
                    link.indexOf(lowerSearch) !== -1 ||
                    yearLevel.indexOf(lowerSearch) !== -1;

                var matchesProgram = selectedProgramsIntern.count === 0;
                for (var p = 0; p < selectedProgramsIntern.count; p++) {
                    if (coursesString.indexOf(selectedProgramsIntern.get(p).value.toLowerCase()) !== -1) {
                        matchesProgram = true;
                        break;
                    }
                }

                if (matchesText && matchesProgram) {
                    filteredInternshipModel.append(item);
                }
            }
        }

    function filterScholarships(searchText) {
            filteredScholarshipModel.clear();
            var lowerSearch = searchText.toLowerCase();

            for (var i = 0; i < studentScholarshipModel.count; i++) {
                var item = studentScholarshipModel.get(i);

                var name = item.name ? item.name.toLowerCase() : "";
                var coursesString = item.coursesString ? item.coursesString.toLowerCase() : "";
                var deadline = item.deadline ? item.deadline.toLowerCase() : "";
                var description = item.description ? item.description.toLowerCase() : "";
                var financialNeed = item.financialNeed ? item.financialNeed.toLowerCase() : "";
                var link = item.link ? item.link.toLowerCase() : "";
                var yearLevel = item.yearLevel ? item.yearLevel.toLowerCase() : "";
                var deadlineYear = item.deadline ? item.deadline.slice(-4) : "";

                var matchesText =
                    name.indexOf(lowerSearch) !== -1 ||
                    coursesString.indexOf(lowerSearch) !== -1 ||
                    deadline.indexOf(lowerSearch) !== -1 ||
                    description.indexOf(lowerSearch) !== -1 ||
                    financialNeed.indexOf(lowerSearch) !== -1 ||
                    link.indexOf(lowerSearch) !== -1 ||
                    yearLevel.indexOf(lowerSearch) !== -1;

                var matchesProgram = selectedPrograms.count === 0;
                for (var p = 0; p < selectedPrograms.count; p++) {
                    if (coursesString.indexOf(selectedPrograms.get(p).value.toLowerCase()) !== -1) {
                        matchesProgram = true;
                        break;
                    }
                }

                var matchesYear = selectedYears.count === 0;
                for (var y = 0; y < selectedYears.count; y++) {
                    if (deadlineYear === selectedYears.get(y).value) {
                        matchesYear = true;
                        break;
                    }
                }

                if (matchesText && matchesProgram && matchesYear) {
                    filteredScholarshipModel.append(item);
                }
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

    function reloadTutors() {
                tutorsModel.clear();
                var tutors = fileManager.loadTutors();
                for (var i = 0; i < tutors.length; i++) {
                    tutorsModel.append(tutors[i]);
                }
            }

    Popup {
        id: applicationSubmittedPopup
        width: 400
        height: 250
        modal: true
        focus: true
        anchors.centerIn: parent
        padding: 30
        closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside

        background: Rectangle {
            height: 300
            radius: 15
            color: "white"
            border.color: "#e0e0e0"
            layer.enabled: true
            layer.effect: DropShadow {
                color: "#40000000"
                radius: 12
                samples: 15
                verticalOffset: 3
            }
        }

        ColumnLayout {
            anchors.fill: parent
            spacing: 15

            // icon
            Rectangle {
                Layout.alignment: Qt.AlignHCenter
                width: 70
                height: 70
                radius: width/2
                color: "#e8f5e9"

                Text {
                    anchors.centerIn: parent
                    text: "✓"
                    font.pixelSize: 36
                    font.bold: true
                    color: "#4CAF50"
                }
            }

            // message
            Text {
                Layout.alignment: Qt.AlignHCenter
                text: "Application Submitted!"
                font.pixelSize: 22
                font.bold: true
                color: "#333"
            }

            Text {
                Layout.alignment: Qt.AlignHCenter
                text: "Your tutor application has been successfully submitted."
                font.pixelSize: 14
                color: "#666"
                horizontalAlignment: Text.AlignHCenter
                wrapMode: Text.WordWrap
                Layout.maximumWidth: 300
            }

            Item {
                Layout.fillHeight: true
            }

            // Button container
            RowLayout {
                Layout.alignment: Qt.AlignHCenter
                spacing: 15

                Button {
                    text: "OK"
                    Layout.preferredWidth: 120
                    Layout.preferredHeight: 40

                    background: Rectangle {
                        radius: 8
                        color: parent.down ? "#2e7d32" : "#4CAF50"
                    }

                    contentItem: Text {
                        text: parent.text
                        color: "white"
                        font.pixelSize: 14
                        font.bold: true
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }

                    onClicked: applicationSubmittedPopup.close()
                }
            }
        }
    }


    Popup {
        id: requestSubmittedPopup
        width: 400
        height: 250
        modal: true
        focus: true
        anchors.centerIn: parent
        padding: 30
        closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside

        background: Rectangle {
            height: 240
            radius: 15
            color: "white"
            border.color: "#e0e0e0"
            layer.enabled: true
            layer.effect: DropShadow {
                color: "#40000000"
                radius: 12
                samples: 15
                verticalOffset: 3
            }
        }

        ColumnLayout {
            anchors.fill: parent
            spacing: 11

            Text {
                Layout.alignment: Qt.AlignHCenter
                text: "Request Submitted!"
                font.pixelSize: 22
                font.bold: true
                color: "#333"
            }

            Text {
                Layout.alignment: Qt.AlignHCenter
                text: "Your tutor request has been successfully submitted."
                font.pixelSize: 14
                color: "#666"
                horizontalAlignment: Text.AlignHCenter
                wrapMode: Text.WordWrap
                Layout.maximumWidth: 300
            }

            // Button container
            RowLayout {
                Layout.alignment: Qt.AlignHCenter

                Button {
                    text: "OK"
                    Layout.preferredWidth: 120
                    Layout.preferredHeight: 40

                    background: Rectangle {
                        radius: 8
                        color: parent.down ? "#2e7d32" : "#4CAF50"
                    }

                    contentItem: Text {
                        text: parent.text
                        color: "white"
                        font.pixelSize: 14
                        font.bold: true
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }

                    onClicked: requestSubmittedPopup.close()
                }
            }
        }
    }

    Component.onCompleted: {
        reloadStudentData()
        reloadTutors();
        fileManager.tutorsChanged.connect(reloadTutors);
        reloadTutorRequests();
        fileManager.tutorRequestsChanged.connect(reloadTutorRequests);
    }

    FileManager {
        id: fileManager
    }

    id: studentDashboard
    width: 1280
    height: 720
    color: "white"

    property bool sidebarVisible: false
    property string dashboardPage: "dashboard"

    // ----------------------------------------------------------------- Top Bar --------------------------------------------------------
    Rectangle {
        id: topBar
        height: studentDashboard.width / 19
        width: studentDashboard.width
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
                text: "Student Dashboard"
                font.pixelSize: 25
                font.family: "Inter"
                font.bold: true
                color: "white"
                verticalAlignment: Text.AlignVCenter
                anchors.verticalCenterOffset: 2
            }

            Row {
                id: studentInfoSection
                spacing: 30
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                anchors.rightMargin: 10

                Text {
                    id: studentNumberText
                    text: "Student Number: " + studentNumber
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

    // ----------------------------------------------------------------- Sidebar --------------------------------------------------------
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
                    dashboardPage = "dashboard"
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
                    dashboardTitle.text = "Scholarships"
                    dashboardPage = "scholarships"
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
                    dashboardTitle.text = "Tutoring"
                    dashboardPage = "tutoring"
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
                    dashboardTitle.text = "Internships"
                    dashboardPage = "internships"
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
                    dashboardTitle.text = "Rooms"
                    dashboardPage = "rooms"
                }
            }
        }
    }

    // ------------------------------------------------------------- Main Content Area ---------------------------------------------------
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
            visible: dashboardPage === "dashboard"
            onVisibleChanged: {
                if (visible) reloadStudentData()
            }
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
                columns: 4
                columnSpacing: 20
                rowSpacing: 16

                Repeater {
                    model: [
                        { title: "Scholarships", icon: "qrc:/ui/assets/Scholarship.png", color: "#c0392b" },
                        { title: "Tutoring", icon: "qrc:/ui/assets/Tutoring.png", color: "#c0392b" },
                        { title: "Internships", icon: "qrc:/ui/assets/Internships.png", color: "#c0392b" },
                        { title: "Rooms", icon: "qrc:/ui/assets/Room.png", color: "#c0392b" }
                    ]

                    delegate: Rectangle {
                        Layout.fillWidth: true
                        height: 110
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
                                width: 50
                                height: 50
                                radius: 25
                                color: modelData.color
                                anchors.horizontalCenter: parent.horizontalCenter

                                Image {
                                    source: modelData.icon
                                    width: 28
                                    height: 28
                                    anchors.centerIn: parent
                                    sourceSize: Qt.size(width, height)
                                }
                            }

                            Text {
                                text: modelData.title
                                font.pixelSize: 14
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

            // Announcements & Events Section
            RowLayout {
                Layout.fillWidth: true
                Layout.fillHeight: true
                spacing: 20

                // Announcements Box
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
                            text: "Announcements"
                            font.pixelSize: 20
                            font.bold: true
                            color: "#c0392b"
                        }

                        ListView {
                            model:  studentAnnouncementsModel
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            clip: true

                            delegate: ColumnLayout {
                                width: ListView.view.width
                                spacing: 8

                                RowLayout {
                                    spacing: 10

                                    Rectangle {
                                        width: 8
                                        height: 8
                                        radius: 4
                                        color: "#c0392b"
                                    }

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
                                }

                                Text {
                                    text: content
                                    font.pixelSize: 14
                                    color: "#7f8c8d"
                                    wrapMode: Text.WordWrap
                                    Layout.fillWidth: true
                                    Layout.leftMargin: 18
                                }

                                Rectangle {
                                    Layout.fillWidth: true
                                    height: 1
                                    color: "#ecf0f1"
                                    Layout.topMargin: 10
                                    Layout.bottomMargin: 10
                                }
                            }
                        }

                        Button {
                            text: "Scroll down for more"
                            font.pixelSize: 14
                            flat: true
                            contentItem: Text {
                                text: parent.text
                                color: "#3498db"
                                horizontalAlignment: Text.AlignLeft
                            }
                            background: Rectangle { color: "transparent" }
                        }
                    }
                }

                // Upcoming Events
                Rectangle {
                    Layout.preferredWidth: 300
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
                            text: "Upcoming Events"
                            font.pixelSize: 20
                            font.bold: true
                            color: "#c0392b"
                        }

                        ListView {
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            clip: true
                            model: studentEventsModel

                            delegate: ColumnLayout {
                                width: ListView.view.width
                                spacing: 10

                                Text {
                                    text: model.title
                                    font.pixelSize: 16
                                    font.bold: true
                                    color: "black"
                                }

                                RowLayout {
                                    spacing: 5
                                    Text {
                                        text: "📅 " + model.date
                                        font.pixelSize: 14
                                        color: "#7f8c8d"
                                    }
                                }

                                Rectangle {
                                    Layout.fillWidth: true
                                    height: 1
                                    color: "#ecf0f1"
                                    Layout.topMargin: 10
                                    Layout.bottomMargin: 10
                                }
                            }
                        }

                        Button {
                            text: "Scroll down for more"
                            font.pixelSize: 14
                            flat: true
                            contentItem: Text {
                                text: parent.text
                                color: "#3498db"
                                horizontalAlignment: Text.AlignLeft
                            }
                            background: Rectangle { color: "transparent" }
                        }
                    }
                }
            }
        }


        // --------------------------------------------------------------------------------------Scholarships Page--------------------------------------------------------------------------------------------------------------- //
                RowLayout{

                    id: scholarshipView
                    visible: dashboardPage === "scholarships"
                    onVisibleChanged: {
                        if (visible) reloadStudentData()
                    }
                    anchors.fill: parent
                    anchors.margins: 30
                    spacing: 25

                    ColumnLayout{
                        anchors.top: parent.top
                        width: 240
                        Rectangle {
                            width: parent.width
                            height: 60
                            color: "transparent"

                            // Search Bar
                            TextField {
                                id: searchFilterScholar
                                placeholderText: "Filter..."
                                width: parent.width - 40
                                height: parent.height - 20
                                anchors.centerIn: parent
                                font.pixelSize: 15
                                padding: 16
                                topPadding: 10
                                leftPadding: 50
                                onTextChanged: filterScholarships(text)

                                Item {
                                    id: iconContainerScholar
                                    width: 30
                                    height: 30
                                    anchors {
                                        left: parent.left
                                        leftMargin: 15
                                        verticalCenter: parent.verticalCenter
                                    }

                                    Image {
                                        source: "qrc:/ui/assets/MagnifyinGlass.png"
                                        anchors.centerIn: parent
                                        width: 24
                                        height: 24
                                        fillMode: Image.PreserveAspectFit
                                    }
                                }

                                background: Rectangle {
                                    radius: height / 2
                                    color: "white"
                                    anchors.fill: parent
                                }

                                layer.enabled: true
                                layer.effect: DropShadow {
                                    radius: 12
                                    color: "#1c1b1b"
                                    samples: 32
                                    verticalOffset: 5
                                }
                            }
                        }

                        // Filter Check Box
                        Rectangle{
                            width: parent.width
                            Layout.fillHeight: true
                            radius: width/7
                            color: "white"
                            Layout.topMargin: 20

                            layer.enabled: true
                            layer.effect: DropShadow {
                                radius: 12
                                color: "#1c1b1b"
                                samples: 32
                                verticalOffset: 3
                            }

                            ColumnLayout{
                                width: parent.width

                                Text{
                                    text: "Filter by"
                                    font.pixelSize: 20
                                    anchors.left: parent.left
                                    leftPadding: 20
                                    topPadding: 10
                                    color: "Black"
                                    font.bold: true
                                }

                                Rectangle {
                                    Layout.topMargin: 10
                                    Layout.leftMargin: 20
                                    width: parent.width - 40
                                    height: 1
                                    color: "gray"
                                }

                                Text{
                                    text: "Program"
                                    font.pixelSize: 12
                                    anchors.left: parent.left
                                    leftPadding: 20
                                    topPadding: 5
                                    color: "Black"
                                    font.bold: true
                                }

                                GridLayout{
                                    rows: 10
                                    columns: 1
                                    Layout.topMargin: 5
                                    Layout.leftMargin: 20
                                    width: parent.width
                                    rowSpacing: 10

                                    Repeater{
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
                                            font.bold: true
                                            onCheckedChanged: {
                                                if (checked) {
                                                    selectedPrograms.append({ value: text });
                                                } else {
                                                    for (var i = 0; i < selectedPrograms.count; i++) {
                                                        if (selectedPrograms.get(i).value === text) {
                                                            selectedPrograms.remove(i);
                                                            break;
                                                        }
                                                    }
                                                }
                                                filterScholarships(searchFilterScholar.text);
                                            }
                                        }
                                    }
                                }

                                Rectangle {
                                    Layout.topMargin: 10
                                    Layout.leftMargin: 20
                                    width: parent.width - 40
                                    height: 1
                                    color: "gray"
                                }

                                Text{
                                    text: "Year"
                                    font.pixelSize: 12
                                    anchors.left: parent.left
                                    leftPadding: 20
                                    topPadding: 5
                                    color: "Black"
                                    font.bold: true
                                }

                                GridLayout{
                                    rows: 5
                                    columns: 2
                                    Layout.topMargin: 5
                                    Layout.leftMargin: 20
                                    width: parent.width
                                    rowSpacing: 5
                                    columnSpacing: 80

                                    Repeater{
                                        model: [
                                            "2025",
                                            "2024",
                                            "2023",
                                            "2022",
                                            "2021",
                                            "2020",
                                            "2019",
                                            "2018",
                                            "2017",
                                            "2016"
                                        ]

                                        CheckBox {
                                            text: modelData
                                            font.bold: true
                                            onCheckedChanged: {
                                                if (checked) {
                                                    selectedYears.append({ value: text });
                                                } else {
                                                    for (var i = 0; i < selectedYears.count; i++) {
                                                        if (selectedYears.get(i).value === text) {
                                                            selectedYears.remove(i);
                                                            break;
                                                        }
                                                    }
                                                }
                                                filterScholarships(searchFilterScholar.text);
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                    ListView {
                        model: filteredScholarshipModel
                        Layout.fillWidth: true
                        Layout.fillHeight: true

                        delegate: ColumnLayout {
                            width: ListView.view.width
                            Layout.rightMargin: 30
                            Layout.leftMargin: 30

                        Rectangle {
                            height: 150
                            width: parent.width - 110
                            radius: width/30
                            Layout.leftMargin: 50
                            Layout.topMargin: 12
                            color: "white"

                            layer.enabled: true
                            layer.effect: DropShadow {
                                color: "#20000000"
                                radius: 12
                                samples: 15
                                verticalOffset: 2
                            }

                            RowLayout {
                                spacing: 10
                                anchors.fill: parent

                                RowLayout {
                                    Layout.leftMargin: 15
                                    Layout.topMargin: 5
                                    Image {
                                        source: "qrc:/ui/assets/scholaricon.png"
                                        Layout.preferredWidth: 60
                                        Layout.preferredHeight: 60
                                        fillMode: Image.PreserveAspectFit
                                    }
                                }

                                Column {
                                    Layout.fillWidth: true
                                    Row {
                                        Text {
                                            text: name.toUpperCase()
                                            font.bold: true
                                            leftPadding: 20
                                            font.pixelSize: 20
                                            color: "#880e1e"
                                        }
                                    }
                                    Row {
                                        Text {
                                            leftPadding: 20
                                            text: "Deadline: "
                                            font.bold: true
                                        }
                                        Text {
                                            text: deadline
                                        }
                                    }
                                    Row{
                                        Text{
                                            leftPadding: 20
                                            text: "Courses: "
                                            font.bold: true
                                        }
                                        Text{
                                            text: coursesString
                                            wrapMode: Text.Wrap
                                        }
                                    }
                                    Row{
                                        Text{
                                            leftPadding: 20
                                            text: "Description: "
                                            font.bold: true
                                        }
                                        Text{
                                            text: description
                                        }
                                    }
                                    Row{
                                        Text{
                                            leftPadding: 20
                                            text: "Financial Need: "
                                            font.bold: true
                                        }
                                        Text{
                                            text: financialNeed
                                        }
                                    }
                                    Row{
                                        Text{
                                            leftPadding: 20
                                            text: "Link: "
                                            font.bold: true
                                        }
                                        Text{
                                            text: link
                                        }
                                    }
                                    Row{
                                        Text{
                                            leftPadding: 20
                                            text: "Year Level: "
                                            font.bold: true
                                        }
                                        Text{
                                            text: yearLevel
                                        }
                                    }
                                }


                                Button {
                                    text: "Learn More"
                                    implicitWidth: 120
                                    implicitHeight: 40
                                    Layout.alignment: Qt.AlignRight | Qt.AlignBottom
                                    Layout.rightMargin: 30
                                    Layout.bottomMargin: 15

                                    background: Rectangle {
                                        id: recApply
                                        width: parent.width
                                        height: parent.height
                                        color: parent.down ? "#880e1e" : "#c0392b"
                                        radius: width / 2
                                    }

                                    contentItem: Text {
                                        anchors.centerIn: recApply
                                        text: parent.text
                                        font.family: "Inter"
                                        font.pixelSize: 16
                                        font.bold: true
                                        color: "white"
                                        horizontalAlignment: Text.AlignHCenter
                                        verticalAlignment: Text.AlignVCenter
                                    }

                                    layer.enabled: true
                                    layer.effect: DropShadow {
                                        color: "#20000000"
                                        radius: 12
                                        samples: 15
                                        verticalOffset: 2
                                    }

                                    onClicked: {
                                            Qt.openUrlExternally(link)
                                        }

                                }
                            }
                        }
                    }
                        ScrollBar.vertical: ScrollBar {
                            policy: ScrollBar.AsNeeded
                        }
                    }

                }
        // ------------------------------------------------------------------------------------  Internships page --------------------------------------------------------------------------------------------------------------- //
                RowLayout{
                    id: internshipView
                    visible: dashboardPage === "internships"
                    onVisibleChanged: {
                        if (visible) reloadStudentData()
                    }
                    anchors.fill: parent
                    anchors.margins: 30
                    spacing: 25


                    ColumnLayout{
                        anchors.top: parent.top
                        width: 240
                        Rectangle {
                            width: parent.width
                            height: 60
                            color: "transparent"

                            // Search Bar
                            TextField {
                                id: searchFilterIntern
                                placeholderText: "Filter..."
                                width: parent.width - 40
                                height: parent.height - 20
                                anchors.centerIn: parent
                                font.pixelSize: 15
                                padding: 16
                                topPadding: 10
                                leftPadding: 50
                                onTextChanged: filterInternships(text)

                                Item {
                                    id: iconContainerIntern
                                    width: 30
                                    height: 30
                                    anchors {
                                        left: parent.left
                                        leftMargin: 15
                                        verticalCenter: parent.verticalCenter
                                    }

                                    Image {
                                        source: "qrc:/ui/assets/MagnifyinGlass.png"
                                        anchors.centerIn: parent
                                        width: 24
                                        height: 24
                                        fillMode: Image.PreserveAspectFit
                                    }
                                }

                                background: Rectangle {
                                    radius: height / 2
                                    color: "white"
                                    anchors.fill: parent
                                }

                                layer.enabled: true
                                layer.effect: DropShadow {
                                    radius: 12
                                    color: "#1c1b1b"
                                    samples: 32
                                    verticalOffset: 5
                                }
                            }
                        }

                        Rectangle{
                            width: parent.width
                            Layout.fillHeight: true
                            radius: width/7
                            color: "white"
                            Layout.topMargin: 20

                            layer.enabled: true
                            layer.effect: DropShadow {
                                radius: 12
                                color: "#1c1b1b"
                                samples: 32
                                verticalOffset: 3
                            }

                            ColumnLayout{
                                width: parent.width

                                Text{
                                    text: "Filter by"
                                    font.pixelSize: 20
                                    anchors.left: parent.left
                                    leftPadding: 20
                                    topPadding: 20
                                    color: "Black"
                                    font.bold: true
                                }

                                Rectangle {
                                    Layout.topMargin: 10
                                    Layout.leftMargin: 20
                                    width: parent.width - 40
                                    height: 1
                                    color: "gray"
                                }

                                Text{
                                    text: "Program"
                                    font.pixelSize: 12
                                    anchors.left: parent.left
                                    leftPadding: 20
                                    topPadding: 5
                                    color: "Black"
                                    font.bold: true
                                }

                                GridLayout{
                                    rows: 10
                                    columns: 1
                                    Layout.topMargin: 5
                                    Layout.leftMargin: 20
                                    width: parent.width
                                    rowSpacing: 15

                                    Repeater{
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
                                            font.pixelSize: 13
                                            font.bold: true
                                            onCheckedChanged: {
                                                if (checked) {
                                                    selectedProgramsIntern.append({ value: text });
                                                } else {
                                                    for (var i = 0; i < selectedProgramsIntern.count; i++) {
                                                        if (selectedProgramsIntern.get(i).value === text) {
                                                            selectedProgramsIntern.remove(i);
                                                            break;
                                                        }
                                                    }
                                                }
                                                filterInternships(searchFilterIntern.text);
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                    ListView {
                        model: filteredInternshipModel
                        Layout.fillWidth: true
                        Layout.fillHeight: true

                        delegate: ColumnLayout {
                            width: ListView.view.width
                            Layout.rightMargin: 30
                            Layout.leftMargin: 30

                        Rectangle {
                            height: 150
                            width: parent.width - 110
                            radius: width/30
                            Layout.leftMargin: 50
                            Layout.topMargin: 12
                            color: "white"

                            layer.enabled: true
                            layer.effect: DropShadow {
                                color: "#20000000"
                                radius: 12
                                samples: 15
                                verticalOffset: 2
                            }
                            RowLayout {
                                spacing: 10
                                anchors.fill: parent

                                RowLayout {
                                    Layout.leftMargin: 30
                                    Layout.topMargin: 5
                                    Image {
                                        source: "qrc:/ui/assets/employee.png"
                                        Layout.preferredWidth: 50
                                        Layout.preferredHeight: 50
                                        fillMode: Image.PreserveAspectFit
                                    }
                                }

                                Column {
                                    Layout.fillWidth: true
                                    Row {
                                        Text {
                                            text: name.toUpperCase()
                                            font.bold: true
                                            leftPadding: 20
                                            font.pixelSize: 20
                                            color: "#880e1e"
                                        }
                                    }
                                    Row {
                                        Text {
                                            leftPadding: 20
                                            text: "Deadline: "
                                            font.bold: true
                                        }
                                        Text {
                                            text: deadline
                                        }
                                    }
                                    Row{
                                        Text{
                                            leftPadding: 20
                                            text: "Courses: "
                                            font.bold: true
                                        }
                                        Text{
                                            text: coursesString
                                            wrapMode: Text.Wrap
                                        }
                                    }
                                    Row{
                                        Text{
                                            leftPadding: 20
                                            text: "Description: "
                                            font.bold: true
                                        }
                                        Text{
                                            text: description
                                        }
                                    }
                                    Row{
                                        Text{
                                            leftPadding: 20
                                            text: "Link: "
                                            font.bold: true
                                        }
                                        Text{
                                            text: link
                                        }
                                    }
                                    Row{
                                        Text{
                                            leftPadding: 20
                                            text: "Year Level: "
                                            font.bold: true
                                        }
                                        Text{
                                            text: yearLevel
                                        }
                                    }
                                }

                                Button {
                                    text: "Learn More"
                                    implicitWidth: 120
                                    implicitHeight: 40
                                    Layout.alignment: Qt.AlignRight | Qt.AlignBottom
                                    Layout.rightMargin: 30
                                    Layout.bottomMargin: 15

                                    background: Rectangle {
                                        id: recApplyIntern
                                        width: parent.width
                                        height: parent.height
                                        color: parent.down ? "#880e1e" : "#c0392b"
                                        radius: width / 2
                                    }

                                    contentItem: Text {
                                        anchors.centerIn: recApplyIntern
                                        text: parent.text
                                        font.family: "Inter"
                                        font.pixelSize: 16
                                        font.bold: true
                                        color: "white"
                                        horizontalAlignment: Text.AlignHCenter
                                        verticalAlignment: Text.AlignVCenter
                                    }

                                    layer.enabled: true
                                    layer.effect: DropShadow {
                                        color: "#20000000"
                                        radius: 12
                                        samples: 15
                                        verticalOffset: 2
                                    }

                                    onClicked: {
                                            Qt.openUrlExternally(link)
                                        }

                                }
                            }
                        }
                    }
                        ScrollBar.vertical: ScrollBar {
                            policy: ScrollBar.AsNeeded
                        }
                    }
                }

       // ------------------------------------------------------------------------------------------tutoring page------------------------------------------------------------------------------------------------------------------

        Popup {
            id: tutorRequestPopup
            width: 450
            height: 320
            modal: true
            focus: true
            anchors.centerIn: parent
            padding: 25
            closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside

            property string tutorName: ""

            background: Rectangle {
                height: 350
                radius: 15
                color: "white"
                border.color: "#e0e0e0"
                layer.enabled: true
                layer.effect: DropShadow {
                    color: "#40000000"
                    radius: 12
                    samples: 15
                    verticalOffset: 3
                }
            }

            ColumnLayout {
                anchors.fill: parent
                spacing: 20

                // Header Section
                ColumnLayout {
                    Layout.fillWidth: true
                    spacing: 8

                    Text {
                        text: "Request Tutor"
                        font {
                            pixelSize: 22
                            bold: true
                            family: "Inter"
                        }
                        color: "black"
                        Layout.alignment: Qt.AlignHCenter
                    }
                }

                // Form Fields Section
                GridLayout {
                    columns: 1
                    columnSpacing: 15
                    rowSpacing: 15
                    Layout.fillWidth: true
                    Layout.fillHeight: true

                    // Name Field
                    ColumnLayout {
                        Layout.fillWidth: true
                        spacing: 5

                        Text {
                            text: "Your Name:"
                            font {
                                pixelSize: 14
                                family: "Inter"
                            }
                            color: "black"
                        }

                        Item {
                            Layout.preferredHeight: 5
                        }

                        TextField {
                            id: requestName
                            Layout.fillWidth: true
                            font.pixelSize: 14
                            placeholderText: "Enter your full name"
                            background: Rectangle {
                                radius: 6
                                border.color: "#bdc3c7"
                                border.width: 1
                                implicitHeight: 42  // Consistent height
                            }
                        }
                    }

                    // Email Field
                    ColumnLayout {
                        Layout.fillWidth: true
                        spacing: 5

                        Text {
                            text: "Your Email:"
                            font {
                                pixelSize: 14
                                family: "Inter"
                            }
                            color: "black"
                        }

                        Item {
                            Layout.preferredHeight: 10
                        }

                        TextField {
                            id: requestEmail
                            Layout.fillWidth: true
                            font.pixelSize: 14
                            placeholderText: "Enter your email address"
                            background: Rectangle {
                                radius: 6
                                border.color: "#bdc3c7"
                                border.width: 1
                                implicitHeight: 42  // Consistent height
                            }
                        }
                    }
                }

                // Button Section
                RowLayout {
                    Layout.alignment: Qt.AlignHCenter
                    spacing: 15
                    Layout.topMargin: 10

                    Button {
                        text: "Cancel"
                        Layout.preferredWidth: 140  // Consistent button widths
                        Layout.preferredHeight: 42  // Consistent button heights

                        background: Rectangle {
                            radius: 8
                            color: "#ecf0f1"
                        }

                        contentItem: Text {
                            text: parent.text
                            color: "#7f8c8d"
                            font {
                                pixelSize: 14
                                bold: true
                                family: "Inter"
                            }
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }

                        onClicked: tutorRequestPopup.close()
                    }

                    Button {
                        text: "Submit Request"
                        Layout.preferredWidth: 140
                        Layout.preferredHeight: 42

                        background: Rectangle {
                            radius: 8
                            color: parent.down ? "#2980b9" : "#3498db"
                        }

                        contentItem: Text {
                            text: parent.text
                            color: "white"
                            font {
                                pixelSize: 14
                                bold: true
                                family: "Inter"
                            }
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }

                        onClicked: {
                            if (requestName.text.trim() === "" || requestEmail.text.trim() === "") {
                                return;
                            }

                            var request = {
                                tutorName: tutorName,
                                tuteeName: requestName.text,
                                tuteeEmail: requestEmail.text,
                                date: new Date().toLocaleDateString(),
                                status: "Pending"
                            };

                            fileManager.saveTutorRequest(request);
                            tutorRequestPopup.close();
                            requestSubmittedPopup.open();
                        }
                    }
                }
            }
        }

        ColumnLayout {
            id: tutoringView
            visible: dashboardPage === "tutoring"
            onVisibleChanged: if (visible) reloadStudentData()
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

                    Column {
                        Layout.fillWidth: true
                        spacing: 5

                        Text {
                            text: "Need help with academics?"
                            font.pixelSize: 24
                            font.bold: true
                            color: "#2c3e50"
                        }

                        Text {
                            text: "Discover the one and only Tutoring Hub — your newest partner in academic success!"
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

            // Meet a Tutor and Tutor Application
            RowLayout {
                Layout.fillWidth: true
                Layout.fillHeight: true
                spacing: 20

                // Meet your Tutors (Left Side)
                Rectangle {
                    Layout.preferredWidth: parent.width * 0.63
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
                            text: "Meet your Tutors"
                            font.pixelSize: 20
                            font.bold: true
                            color: "#c0392b"
                        }

                        ListView {
                            id: tutorsListView
                            model: tutorsModel
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            clip: true
                            spacing: 15


                            delegate: Rectangle {
                                width: tutorsListView.width
                                height: tutorColumn.implicitHeight + 25
                                radius: 10
                                color: "#f9f9f9"
                                border.color: "#e0e0e0"
                                border.width: 1

                                ColumnLayout {
                                    id: tutorColumn
                                    anchors.fill: parent
                                    anchors.margins: 15
                                    spacing: 8

                                    Item {
                                        Layout.preferredHeight: 2
                                    }

                                    RowLayout {
                                        width: parent.width
                                        spacing: 10

                                        // Tutor's profile icon (will change)
                                        Rectangle {
                                            id: profilePic
                                            width: 60
                                            height: 60
                                            radius: 30
                                            color: "#c0392b"

                                            Text {
                                                anchors.centerIn: parent
                                                text: name.charAt(0).toUpperCase()
                                                font.pixelSize: 24
                                                font.bold: true
                                                color: "#e0e0e0"
                                            }
                                        }

                                        Item {
                                            Layout.preferredWidth: 2
                                        }

                                        // Tutor details (name + course)
                                        ColumnLayout {
                                            spacing: 4
                                            Layout.fillWidth: true

                                            Text {
                                                text: name
                                                font.pixelSize: 18
                                                font.bold: true
                                                color: "black"
                                            }

                                            Text {
                                                text: course
                                                font.pixelSize: 14
                                                color: "#616161"
                                            }
                                        }

                                        Item {
                                                Layout.fillWidth: true
                                            }

                                        // Request button on far right
                                        Button {
                                            text: "Request"
                                            Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                                            padding: 8
                                            Layout.preferredHeight: 30

                                            background: Rectangle {
                                                radius: 6
                                                color: parent.down ? "#2980b9" : "#3498db"
                                            }

                                            contentItem: Text {
                                                text: parent.text
                                                color: "white"
                                                font.pixelSize: 12
                                                font.bold: true
                                                horizontalAlignment: Text.AlignHCenter
                                                verticalAlignment: Text.AlignVCenter
                                            }

                                            onClicked: {
                                                tutorRequestPopup.tutorName = name;
                                                tutorRequestPopup.open();
                                            }
                                        }
                                    }

                                }
                            }
                        }
                    }
                }

                // Tutor Application Form (Right Side)
                Rectangle {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    radius: 15
                    color: "#FFFFFF"
                    border.color: "#EAEAEA"
                    border.width: 1

                    layer.enabled: true
                    layer.effect: DropShadow {
                        color: "#10000000"
                        radius: 10
                        samples: 15
                        verticalOffset: 3
                    }

                    ColumnLayout {
                        anchors.fill: parent
                        anchors.margins: 25
                        spacing: 20

                        Text {
                            text: "Apply as Tutor!"
                            font {
                                pixelSize: 22
                                family: "Open Sans"
                                weight: Font.Bold
                            }
                            color: "#C0392B"
                            Layout.bottomMargin: 5
                        }

                        // Form Container
                        Rectangle {
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            color: "transparent"

                            ScrollView {
                                anchors.fill: parent
                                clip: true
                                ScrollBar.vertical.policy: ScrollBar.AsNeeded

                                ColumnLayout {
                                    width: parent.width
                                    spacing: 15

                                    // Personal Information Section
                                    ColumnLayout {
                                        spacing: 8
                                        Layout.fillWidth: true

                                        Text {
                                            text: "Personal Information"
                                            font {
                                                pixelSize: 16
                                                family: "Open Sans"
                                                weight: Font.DemiBold
                                            }
                                            color: "black"
                                            bottomPadding: 5
                                        }

                                        Rectangle {
                                            Layout.fillWidth: true
                                            height: 1
                                            color: "#EEEEEE"
                                        }

                                        GridLayout {
                                            columns: 2
                                            columnSpacing: 20
                                            rowSpacing: 15
                                            Layout.fillWidth: true
                                            Layout.topMargin: 5

                                            // Name Field
                                            Label {
                                                text: "Full Name"
                                                font.pixelSize: 14
                                                color: "black"
                                            }
                                            TextField {
                                                id: tutorName
                                                Layout.fillWidth: true
                                                font.pixelSize: 14
                                                placeholderText: "Janelle Angeli Ranario"
                                                verticalAlignment: TextInput.AlignVCenter
                                                background: Rectangle {
                                                    implicitHeight: 40
                                                    radius: 6
                                                    border.color: "#DDDDDD"
                                                    border.width: 1
                                                }
                                            }

                                            // Program Field
                                            Label {
                                                text: "Program"
                                                font.pixelSize: 14
                                                color: "black"
                                            }
                                            ComboBox {
                                                id: tutorProgram
                                                Layout.fillWidth: true
                                                font.pixelSize: 14
                                                model: ["B Fine Arts (Product Design)",
                                                    "B Fine Arts (Studio Arts)",
                                                    "BA Communication",
                                                    "BA Psychology",
                                                    "BA Political Science",
                                                    "BS Biology",
                                                    "BS Computer Science",
                                                    "BA Management",
                                                    "BS Mathematics",
                                                    "BS Statistics"]
                                                background: Rectangle {
                                                    implicitHeight: 40
                                                    radius: 6
                                                    border.color: "#DDDDDD"
                                                    border.width: 1
                                                    color: "#f6f6f6"
                                                }
                                                popup.background: Rectangle {
                                                    color: "#FFFFFF"
                                                    border.color: "#DDDDDD"
                                                }
                                            }

                                            // Year Level
                                            Label {
                                                text: "Year Level"
                                                font.pixelSize: 14
                                                color: "black"
                                            }
                                            ComboBox {
                                                id: tutorYear
                                                Layout.fillWidth: true
                                                font.pixelSize: 14
                                                model: ["1st Year", "2nd Year", "3rd Year", "4th Year", "Graduate"]
                                                background: Rectangle {
                                                    implicitHeight: 40
                                                    radius: 6
                                                    border.color: "#DDDDDD"
                                                    color: "#f6f6f6"
                                                    border.width: 1
                                                }
                                            }
                                        }
                                    }

                                    // Academic Information Section
                                    ColumnLayout {
                                        spacing: 8
                                        Layout.fillWidth: true
                                        Layout.topMargin: 10

                                        Text {
                                            text: "Academic Information"
                                            font {
                                                pixelSize: 16
                                                family: "Open Sans"
                                                weight: Font.DemiBold
                                            }
                                            color: "black"
                                            bottomPadding: 5
                                        }

                                        Rectangle {
                                            Layout.fillWidth: true
                                            height: 1
                                            color: "#EEEEEE"
                                        }

                                        // Subjects
                                        Label {
                                            text: "Subjects You Can Tutor"
                                            font.pixelSize: 14
                                            color: "black"
                                            Layout.topMargin: 5
                                        }
                                        TextArea {
                                            id: tutorSubjects
                                            Layout.fillWidth: true
                                            font.pixelSize: 14
                                            placeholderText: "Mathematics, Computer Science, Physics..."
                                            wrapMode: Text.WordWrap
                                            background: Rectangle {
                                                radius: 6
                                                border.color: "#DDDDDD"
                                                border.width: 1
                                            }
                                            Layout.preferredHeight: 80
                                        }

                                        // Qualifications
                                        Label {
                                            text: "Qualifications & Experience"
                                            font.pixelSize: 14
                                            color: "black"
                                            Layout.topMargin: 10
                                        }
                                        TextArea {
                                            id: tutorQualifications
                                            Layout.fillWidth: true
                                            font.pixelSize: 14
                                            placeholderText: "Dean's List, Teaching Assistant, Competition Awards..."
                                            wrapMode: Text.WordWrap
                                            background: Rectangle {
                                                radius: 6
                                                border.color: "#DDDDDD"
                                                border.width: 1
                                            }
                                            Layout.preferredHeight: 100
                                        }

                                        // Motivation
                                        Label {
                                            text: "Motivation Statement"
                                            font.pixelSize: 14
                                            color: "black"
                                            Layout.topMargin: 10
                                        }
                                        TextArea {
                                            id: tutorMotivation
                                            Layout.fillWidth: true
                                            font.pixelSize: 14
                                            placeholderText: "Why do you want to become a tutor?..."
                                            wrapMode: Text.WordWrap
                                            background: Rectangle {
                                                radius: 6
                                                border.color: "#DDDDDD"
                                                border.width: 1
                                            }
                                            Layout.preferredHeight: 120
                                        }
                                    }
                                }
                            }
                        }

                        // Submit Button
                        Button {
                            text: "Submit Application"
                            Layout.alignment: Qt.AlignRight
                            font {
                                pixelSize: 50
                                family: "Inter"
                                weight: Font.Bold
                            }
                            background: Rectangle {
                                height: 30
                                radius: 8
                                color: parent.down ? "#27ae60" : "#2ecc71"
                                layer.enabled: true
                                layer.effect: DropShadow {
                                    color: "#40000000"
                                    radius: 4
                                    samples: 8
                                    verticalOffset: 2
                                }
                            }
                            contentItem: Text {
                                text: parent.text
                                color: "white"
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                            }
                            onClicked: {
                                var applicationData = {
                                            "name": tutorName.text,
                                            "course": tutorProgram.currentText,
                                            "yearLevel": tutorYear.currentText,
                                            "subjects": tutorSubjects.text,
                                            "qualifications": tutorQualifications.text,
                                            "motivation": tutorMotivation.text,
                                            "date": Qt.formatDateTime(new Date(), "yyyy-MM-dd"),
                                            "status": "Pending"
                                };
                                fileManager.saveApplication(applicationData);

                                    tutorName.text = "";
                                    tutorProgram.currentIndex = -1;
                                    tutorYear.currentIndex = -1;
                                    tutorSubjects.text = "";
                                    tutorQualifications.text = "";
                                    tutorMotivation.text = "";

                                applicationSubmittedPopup.open();
                            }

                            Layout.topMargin: 15
                        }
                    }
                }
            }
        }

        // ----------------------------------------------------------------------------------------- Rooms page --------------------------------------------------------------------------------------------------------------------
        ColumnLayout {
            id: roomsView
            visible: dashboardPage === "rooms"
            anchors.fill: parent
            anchors.margins: 30
            spacing: 25

            ListModel {
                id: availableRoomsModel
            }

            function updateAvailableRooms() {
                var allRooms = fileManager.loadRooms();
                availableRoomsModel.clear();
                for (var i = 0; i < allRooms.length; i++) {
                    if (allRooms[i].availability === "Available") {
                        availableRoomsModel.append({
                            name: allRooms[i].number,
                            capacity: allRooms[i].capacity + " pax",
                            type: allRooms[i].type
                        });
                    }
                }
            }

            Component.onCompleted: updateAvailableRooms()

            Connections {
                target: fileManager
                function onRoomsChanged() {
                    updateAvailableRooms();
                }
            }

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

                    Column {
                        Layout.fillWidth: true
                        spacing: 5

                        Text {
                            text: "Need a space to study or collaborate?"
                            font.pixelSize: 24
                            font.bold: true
                            color: "#2c3e50"
                        }

                        Text {
                            text: "Book available rooms for your academic needs."
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

            // Main booking area
            RowLayout {
                Layout.fillWidth: true
                Layout.fillHeight: true
                spacing: 20

                // Available Rooms (Left Side)
                Rectangle {
                    Layout.preferredWidth: parent.width * 0.4
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
                            text: "Full List of Rooms"
                            font.pixelSize: 20
                            font.bold: true
                            color: "#c0392b"
                        }

                        ListView {
                            id: roomsListView
                            model: availableRoomsModel

                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            clip: true
                            spacing: 15

                            delegate: Rectangle {
                                width: roomsListView.width
                                height: 90
                                radius: 10
                                color: roomMouseArea.containsMouse ? "#f5f5f5" : "#ffffff"
                                border.color: "#e0e0e0"
                                border.width: 1

                                MouseArea {
                                    id: roomMouseArea
                                    anchors.fill: parent
                                    hoverEnabled: true
                                    onClicked: {
                                        roomNameLabel.text = model.name
                                        roomTypeLabel.text = model.type
                                        roomCapacityLabel.text = model.capacity
                                        updateTimeSlots(model.name)
                                    }
                                }

                                ColumnLayout {
                                    anchors.fill: parent
                                    anchors.margins: 15
                                    spacing: 5

                                    Text {
                                        text: model.name
                                        font.pixelSize: 16
                                        font.bold: true
                                        color: "#2c3e50"
                                    }

                                    RowLayout {
                                        spacing: 10

                                        Text {
                                            text: "Type:"
                                            font.pixelSize: 14
                                            color: "#7f8c8d"
                                        }

                                        Text {
                                            text: model.type
                                            font.pixelSize: 14
                                            color: "#c0392b"
                                        }

                                        Text {
                                            text: "Capacity:"
                                            font.pixelSize: 14
                                            color: "#7f8c8d"
                                        }

                                        Text {
                                            text: model.capacity
                                            font.pixelSize: 14
                                            color: "#c0392b"
                                        }
                                    }
                                }
                            }
                        }
                    }
                }

                // Booking Form (Right Side)
                Rectangle {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    radius: 15
                    color: "#FFFFFF"
                    border.color: "#EAEAEA"
                    border.width: 1

                    layer.enabled: true
                    layer.effect: DropShadow {
                        color: "#10000000"
                        radius: 10
                        samples: 15
                        verticalOffset: 3
                    }

                    ColumnLayout {
                        anchors.fill: parent
                        anchors.margins: 25
                        spacing: 15

                        // Header
                        Text {
                            text: "Book a Room"
                            font {
                                pixelSize: 22
                                family: "Open Sans"
                                weight: Font.Bold
                            }
                            color: "#C0392B"
                            Layout.bottomMargin: 5
                        }

                        // Selected Room Info
                        ColumnLayout {
                            spacing: 10
                            Layout.fillWidth: true

                            Text {
                                id: roomNameLabel
                                text: "Select a room from the list"
                                font.pixelSize: 18
                                font.bold: true
                                color: "#2c3e50"
                            }

                            RowLayout {
                                spacing: 15

                                Text {
                                    id: roomTypeLabel
                                    text: ""
                                    font.pixelSize: 14
                                    color: "#7f8c8d"
                                }

                                Text {
                                    id: roomCapacityLabel
                                    text: ""
                                    font.pixelSize: 14
                                    color: "#7f8c8d"
                                }
                            }
                        }

                        // Time Slot Selection
                        ColumnLayout {
                            spacing: 10
                            Layout.fillWidth: true
                            Layout.topMargin: 20

                            Text {
                                text: "Enter Time Slot"
                                font.pixelSize: 16
                                font.bold: true
                                color: "black"
                            }

                            Rectangle {
                                Layout.fillWidth: true
                                height: 1
                                color: "#EEEEEE"
                            }


                            TextField {
                                    id: timeSlotInput
                                    Layout.fillWidth: true
                                    placeholderText: "e.g., 10:00 AM - 11:30 AM"
                                    font.pixelSize: 14
                                    background: Rectangle {
                                        implicitHeight: 40
                                        radius: 6
                                        border.color: "#DDDDDD"
                                        border.width: 1
                                    }
                                }
                            }

                        // Purpose Field
                        ColumnLayout {
                            spacing: 10
                            Layout.fillWidth: true

                            Text {
                                text: "Purpose (Optional)"
                                font.pixelSize: 16
                                font.bold: true
                                color: "black"
                            }

                            Rectangle {
                                Layout.fillWidth: true
                                height: 1
                                color: "#EEEEEE"
                            }

                            TextField {
                                id: bookingPurpose
                                Layout.fillWidth: true
                                font.pixelSize: 14
                                placeholderText: "Study group, project meeting, etc."
                                background: Rectangle {
                                    implicitHeight: 40
                                    radius: 6
                                    border.color: "#DDDDDD"
                                    border.width: 1
                                }
                            }
                        }

                        // Submit Button
                        Button {
                            text: "Confirm Booking"
                            Layout.alignment: Qt.AlignRight
                            enabled: timeSlotsGrid.selectedTime !== ""
                            font {
                                pixelSize: 14
                                family: "Inter"
                                weight: Font.Bold
                            }
                            background: Rectangle {
                                implicitHeight: 40
                                radius: 8
                                color: parent.enabled ? (parent.down ? "#c0392b" : "#e74c3c") : "#95a5a6"
                                layer.enabled: true
                                layer.effect: DropShadow {
                                    color: "#40000000"
                                    radius: 4
                                    samples: 8
                                    verticalOffset: 2
                                }
                            }
                            contentItem: Text {
                                text: parent.text
                                color: "white"
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                            }
                            onClicked: {
                                var bookingData = {
                                    "room": roomNameLabel.text,
                                    "time": timeSlotInput.text.trim(),
                                    "purpose": bookingPurpose.text,
                                    "student": userName,
                                    "studentNumber": studentNumber,
                                    "date": Qt.formatDateTime(new Date(), "yyyy-MM-dd")
                                };
                                fileManager.setRoomAvailabilityByName(roomNameLabel.text, "Booked");
                                bookingConfirmationPopup.open();

                                timeSlotInput.text = "";
                                bookingPurpose.text = "";

                                roomNameLabel.text = "Select a room from the list";
                                roomTypeLabel.text = "";
                                roomCapacityLabel.text = "";
                            }

                            Layout.topMargin: 15
                        }
                    }
                }
            }
        }

        Popup {
            id: bookingConfirmationPopup
            width: 300
            height: 150
            modal: true
            focus: true
            anchors.centerIn: parent
            padding: 0

            enter: Transition {
                NumberAnimation { property: "opacity"; from: 0; to: 1; duration: 150 }
            }

            exit: Transition {
                NumberAnimation { property: "opacity"; to: 0; duration: 100 }
            }

            background: Rectangle {
                radius: 12
                color: "white"
                border.width: 0

                layer.enabled: true
                layer.effect: DropShadow {
                    transparentBorder: true
                    horizontalOffset: 0
                    verticalOffset: 4
                    radius: 12
                    samples: 25
                    color: "#30000000"
                }
            }

            contentItem: ColumnLayout {
                spacing: 10
                anchors.fill: parent
                anchors.margins: 20

                Text {
                    Layout.alignment: Qt.AlignHCenter
                    text: "Booking Confirmed!"
                    font.bold: true
                    font.pixelSize: 18
                    color: "#2c3e50"
                }

                Text {
                    Layout.alignment: Qt.AlignHCenter
                    Layout.fillWidth: true
                    text: "Your room booking has been confirmed."
                    font.pixelSize: 14
                    horizontalAlignment: Text.AlignHCenter
                    color: "#616161"
                    wrapMode: Text.WordWrap
                }

                Button {
                    Layout.alignment: Qt.AlignHCenter
                    Layout.topMargin: 5
                    Layout.preferredWidth: 80
                    Layout.preferredHeight: 30
                    text: "OK"

                    background: Rectangle {
                        radius: 6
                        color: "#4CAF50"
                    }

                    contentItem: Text {
                        text: parent.text
                        color: "white"
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        font.pixelSize: 14
                    }

                    onClicked: bookingConfirmationPopup.close()
                }
            }
        }

    }

}
