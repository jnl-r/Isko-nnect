import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15
import Qt5Compat.GraphicalEffects
import Qt.labs.platform 1.1

Rectangle {
    id: rightLogin

    anchors {
        right: parent.right
        left: leftWelcomePage.right
        bottom: bottomBar.top
        top: parent.top
    }

    color: "white"

    Button {
        id: backButton
        Layout.fillWidth: true
        font.pixelSize: 50
        padding: 0

        anchors {
            top: parent.top
            left: parent.left
            margins: 20
        }

        text: "Back"

            background: Rectangle {
                color: "transparent"
            }

            contentItem: Row {
                spacing: 8
                leftPadding: 5

                Image {
                    source: "qrc:/ui/assets/Back.png"
                    width: 24
                    height: 24
                    anchors.verticalCenter: parent.verticalCenter
                }

                Text {
                    text: "Back"
                    font.family: "Inter"
                    font.pixelSize: 15
                    color: "#b71c1c"
                    anchors.verticalCenter: parent.verticalCenter
                }
            }

        onClicked: currentPage = "welcome"
    }

    ColumnLayout {
        anchors.centerIn: rightLogin
        spacing: 0

        Rectangle {
            id: formContainer
            width: 390
            Layout.preferredHeight: selectedLoginType === "admin" ? 500 : 500
            radius: 35
            color: "#FFFFFF"

            layer.enabled: true
            layer.effect: DropShadow {
                transparentBorder: true
                horizontalOffset: 0
                verticalOffset: 2
                radius: 8
                samples: 16
                color: "#20000000"
            }

            ColumnLayout {
                anchors.fill: parent
                anchors.centerIn: formContainer
                spacing: 2
                Layout.leftMargin: 30
                Layout.rightMargin: 30

                Item {
                    Layout.preferredHeight: 40
                }

                Text {
                    text: selectedLoginType === "admin" ? "Admin Login" : "Student Login"
                    font.bold: true
                    font.pixelSize: 35
                    font.family: "Inter"
                    color: "black"
                    Layout.alignment: Qt.AlignCenter
                    Layout.bottomMargin: 10
                }

                Text {
                    text: "Please enter your details."
                    font.bold: false
                    font.pixelSize: 18
                    font.family: "Inter"
                    color: "black"
                    Layout.alignment: Qt.AlignCenter
                }

                Item {
                    Layout.preferredHeight: 35
                }

                Loader {
                    sourceComponent: selectedLoginType === "admin" ? adminLoginForm : studentLoginForm
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                }
            }
        }
    }

    // ------------------------------------------- Admin Login Form --------------------------------------------
    Component {
        id: adminLoginForm

        ColumnLayout {
            spacing: 2
            Layout.leftMargin: 30
            Layout.rightMargin: 30

            Text {
                text: "Enter Name"
                font.pixelSize: 15
                font.family: "Inter"
                color: "black"
                Layout.leftMargin: 30
                Layout.rightMargin: 30
            }

            TextField {
                id: adminName
                placeholderText: "ex. Jose Rizal"
                Layout.preferredWidth: 330
                Layout.preferredHeight: 50// Fixed width
                Layout.alignment: Qt.AlignHCenter
                font.pixelSize: 15
                topPadding: 15
                leftPadding: 10
                padding: 15
                background: Rectangle {
                    radius: 4
                    border.color: "#e0e0e0"
                    border.width: 0.5
                }
            }

            Item { Layout.preferredHeight: 5 }

            Text {
                text: "Enter Email Address"
                font.pixelSize: 15
                font.family: "Inter"
                color: "black"
                Layout.leftMargin: 30
                Layout.rightMargin: 30
            }

            TextField {
                id: adminEmail
                placeholderText: "ex. username@up.edu.ph"
                Layout.preferredWidth: 330
                Layout.preferredHeight: 50
                Layout.alignment: Qt.AlignHCenter
                font.pixelSize: 15
                inputMethodHints: Qt.ImhDigitsOnly
                topPadding: 15
                leftPadding: 10
                padding: 15
                background: Rectangle {
                    radius: 4
                    border.color: "#e0e0e0"
                    border.width: 0.5
                }
            }

            Label {
                id: adminError
                color: "#e74c3c"
                Layout.preferredWidth: 330
                Layout.alignment: Qt.AlignHCenter
                wrapMode: Text.Wrap
                horizontalAlignment: Text.AlignHCenter
                visible: text !== ""
                text: ""
                Layout.topMargin: 5
            }

            Item { Layout.preferredHeight: 10 }

            Button {
                text: "Submit"
                Layout.preferredWidth: 150
                Layout.alignment: Qt.AlignHCenter
                padding: 15
                background: Rectangle {
                    id: recLog
                    radius: 38
                    color: parent.down ? "#880e1e" : "#c0392b"
                    height: 50
                }
                contentItem: Text {
                    anchors.centerIn: recLog
                    text: parent.text
                    font.family: "Inter"
                    font.pixelSize: 16
                    font.bold: true
                    color: "white"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
                onClicked: {
                    if (adminName.text && adminEmail.text) {
                        if (adminEmail.text.includes("@up.edu.ph")) {
                            userName = adminName.text;
                            userType = "admin";
                            currentPage = "admin";
                            adminError.text = "";
                        } else {
                            adminError.text = "Please use a valid UP email";
                        }
                    } else {
                        adminError.text = "Please enter both name and email";
                    }
                }
            }

            Item { Layout.preferredHeight: 25 }
        }
    }

    // -------------------------------------------Student Login Form ---------------------------------------------
    Component {
        id: studentLoginForm

        ColumnLayout {
            spacing: 2
            Layout.leftMargin: 30
            Layout.rightMargin: 30

            Text {
                text: "Enter Name"
                font.pixelSize: 15
                font.family: "Inter"
                color: "black"
                Layout.leftMargin: 30  // Add left margin
                Layout.rightMargin: 30 // Add right margin
            }

            TextField {
                id: studentName
                placeholderText: "ex. Jose Rizal"
                Layout.preferredWidth: 330
                Layout.preferredHeight: 50// Fixed width
                Layout.alignment: Qt.AlignHCenter
                font.pixelSize: 15
                topPadding: 15
                leftPadding: 10
                padding: 15
                background: Rectangle {
                    radius: 4
                    border.color: "#e0e0e0"
                    border.width: 0.5
                }
            }

            Item { Layout.preferredHeight: 5 }

            Text {
                text: "Enter Student Number"
                font.pixelSize: 15
                font.family: "Inter"
                color: "black"
                Layout.leftMargin: 30
                Layout.rightMargin: 30
            }

            TextField {
                id: studentNumberInput
                placeholderText: "ex. 202416079"
                Layout.preferredWidth: 330
                Layout.preferredHeight: 50
                Layout.alignment: Qt.AlignHCenter
                font.pixelSize: 15
                inputMethodHints: Qt.ImhDigitsOnly
                maximumLength: 9
                topPadding: 15
                leftPadding: 10
                padding: 15
                background: Rectangle {
                    radius: 4
                    border.color: "#e0e0e0"
                    border.width: 0.5
                }
            }

            Label {
                id: studentError
                color: "#e74c3c"
                Layout.preferredWidth: 330
                Layout.alignment: Qt.AlignHCenter
                wrapMode: Text.Wrap
                horizontalAlignment: Text.AlignHCenter
                visible: text !== ""
                text: ""
                Layout.topMargin: 5
            }

            Item { Layout.preferredHeight: 10 }

            Button {
                text: "Submit"
                Layout.preferredWidth: 150
                Layout.alignment: Qt.AlignHCenter
                padding: 15
                background: Rectangle {
                    id: recLog
                    radius: 38
                    color: parent.down ? "#880e1e" : "#c0392b"
                    height: 50
                }
                contentItem: Text {
                    anchors.centerIn: recLog
                    text: parent.text
                    font.family: "Inter"
                    font.pixelSize: 16
                    font.bold: true
                    color: "white"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
                onClicked: {
                    if (studentName.text && studentNumberInput.text.length === 9) {
                        userName = studentName.text;
                        userType = "student";
                        studentNumber = studentNumberInput.text;
                        currentPage = "student";
                        studentError.text = "";
                    } else {
                        studentError.text = "Invalid student number";
                    }
                }
            }

            Item { Layout.preferredHeight: 25 }
        }
    }
}
