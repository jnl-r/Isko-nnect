import QtQuick 2.15
import QtQuick.Controls 2.15

Rectangle {
    id: bottomBar
    anchors {
        left: parent.left
        right: parent.right
        bottom: parent.bottom
    }
    color: "#F2F0EF"
    height: parent.height / 22

    Rectangle {
        anchors.top: parent.top
        width: parent.width
        height: 1
        color: "#E0E0E0"
    }

    Text {
        anchors {
            verticalCenter: parent.verticalCenter
            horizontalCenter: parent.horizontalCenter
        }
        text: "© 2025 University of the Philippines Cebu. All rights reserved."
        font {
            family: "Inter"
            pixelSize: Math.max(10, parent.height * 0.4)
            weight: Font.Normal
        }
        color: "#7F7F7F"

        // Make the year dynamic
        function updateYear() {
            text = text.replace(/\d{4}/, new Date().getFullYear())
        }

        Component.onCompleted: updateYear()
    }
}
