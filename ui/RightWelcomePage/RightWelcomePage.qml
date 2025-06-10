import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15
import Qt5Compat.GraphicalEffects
import Qt.labs.platform 1.1

Rectangle {
    id: rightWelcomePage

    anchors {
        right: parent.right
        left: leftWelcomePage.right
        bottom: bottomBar.top
        top: parent.top
    }

    color: "white"

    ColumnLayout {
        anchors.centerIn: parent
        spacing: 15

        Item {
            Layout.preferredHeight: 70
        }

        Text {
            text: "Login to your account"
            font.bold: true
            font.pixelSize: 35
            font.family: "Inter"
            color: "black"
            Layout.alignment: Qt.AlignCenter
        }

        Item {
            Layout.preferredHeight: 45
        }

        ColumnLayout {
            spacing: 10
            Layout.alignment: Qt.AlignHCenter
            Layout.fillWidth: true

            Button {
                id: studentButton
                text: "Continue as Student"
                Layout.fillWidth: true
                font.pixelSize: 20
                font.family: "Inter"
                padding: 20
                topPadding: 16
                leftPadding: 55

                hoverEnabled: true

                background: Rectangle {
                    id: recBacStu
                    radius: 100
                    height: 60
                    color: studentButton.hovered ? "#f5f5f5" : "white"
                    border.color: "#e0e0e0"
                    border.width: 1

                    layer.enabled: true
                    layer.effect: DropShadow {
                        transparentBorder: true
                        horizontalOffset: 0
                        verticalOffset: 2
                        radius: 8
                        samples: 16
                        color: "#20000000"
                    }
                }

                contentItem: Item {
                    Row {
                        anchors.centerIn: recBacStu
                        spacing: 15

                        Image {
                            source: "qrc:/ui/assets/Student.png"
                            height: 29
                            width: 29
                            anchors.verticalCenter: parent.verticalCenter
                        }

                        Text {
                            text: studentButton.text
                            color: "black"
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignHCenter
                            font: studentButton.font
                        }
                    }
                }

                onClicked: {
                    selectedLoginType = "student";
                    currentPage = "login";
                }
            }
            Item {
                Layout.preferredHeight: 40
            }

            Button {
                id: adminButton
                text: "Continue as Administrator"
                Layout.fillWidth: true
                font.pixelSize: 20
                font.family: "Inter"
                padding: 20
                topPadding: 16
                leftPadding: 55

                hoverEnabled: true

                background: Rectangle {
                    id: recBackAd
                    radius: 100
                    height: 60
                    color: adminButton.hovered ? "#f5f5f5" : "white"
                    border.color: "#e0e0e0"
                    border.width: 1

                    layer.enabled: true
                    layer.effect: DropShadow {
                        transparentBorder: true
                        horizontalOffset: 0
                        verticalOffset: 2
                        radius: 8
                        samples: 16
                        color: "#20000000"
                    }
                }

                contentItem: Item {
                    Row {
                        anchors.centerIn: recBackAd
                        spacing: 15

                        Image {
                            source: "qrc:/ui/assets/Admin.png"
                            height: 28
                            width: 28
                            anchors.verticalCenter: parent.verticalCenter
                        }

                        Text {
                            text: adminButton.text
                            color: "black"
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignHCenter
                            font: adminButton.font
                        }
                    }
                }

                onClicked: {
                    selectedLoginType = "admin";
                    currentPage = "login";
                }
            }
        }

        Item {
            Layout.preferredHeight: 180
        }

        ColumnLayout {
            spacing: 15
            Layout.alignment: Qt.AlignHCenter
            Layout.fillWidth: true

            Rectangle {
                Layout.fillWidth: true
                height: 1
                color: "#e0e0e0"
            }

            Text {
                text: "Haven't signed into your account before?\nContact  pio.upcebu@edu.ph  or visit  www.upcebu.edu.ph"
                font.pixelSize: 14
                font.family: "Rubik"
                color: "#7f8c8d"
                Layout.alignment: Qt.AlignHCenter
                horizontalAlignment: Text.AlignHCenter
                wrapMode: Text.WordWrap

                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: Qt.openUrlExternally("https://www.upcebu.edu.ph/")
                }
            }
        }
    }
}
