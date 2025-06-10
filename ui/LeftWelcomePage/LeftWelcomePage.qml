import QtQuick 2.15
import QtQuick.Layouts 1.15
import Qt5Compat.GraphicalEffects

Item {
    id: leftWelcomePage
    anchors {
        top: parent.top
        bottom: bottomBar.top
        left: parent.left
    }
    width: parent.width * 6 / 10

    Image {
            id: bgImage
            anchors.fill: parent
            source: "qrc:/ui/assets/classroom4.jpg"
            fillMode: Image.PreserveAspectCrop
            smooth: true
            opacity: 0.9
        }

    FontLoader {
        id: rubikFont
        source: "qrc:/ui/assets/Rubik.ttf"
    }


    Rectangle {
        anchors.fill: parent
        opacity: 0.03
        layer.enabled: true

        gradient: Gradient {
        GradientStop { position: 0.0; color: "#9a0b0b" }
        GradientStop { position: 0.4; color: "#b71c1c" }
        GradientStop { position: 1.0; color: "#c0392b" }
        }
    }


    // snow effects hihi but distracting daw
    // Repeater {
    //     model: 20
    //     delegate: Rectangle {
    //         width: 2 + Math.random() * 3
    //         height: width
    //         radius: width / 2
    //         color: "white"
    //         opacity: 0.05 + Math.random() * 0.08
    //         antialiasing: true

    //         x: Math.random() * parent.width
    //         y: Math.random() * parent.height

    //         PropertyAnimation on y {
    //             from: -20
    //             to: parent.height + 20
    //             duration: 4000 + Math.random() * 10000
    //             loops: Animation.Infinite
    //             easing.type: Easing.InOutSine
    //         }
    //     }
    // }

        Row {
            id: logoRow
            anchors {
                top: parent.top
                topMargin: 30
                horizontalCenter: parent.horizontalCenter
            }
            spacing: 40

            Image {
                source: "qrc:/ui/assets/upcebLogo.png"
                sourceSize.width: 70
                sourceSize.height: 70
                fillMode: Image.PreserveAspectFit
                opacity: 0.9
            }

            Image {
                source: "qrc:/ui/assets/UP logo.png"
                sourceSize.width: 70
                sourceSize.height: 70
                fillMode: Image.PreserveAspectFit
                opacity: 0.9
            }
        }

    // Main content
    ColumnLayout {
        id: contentLayout
        anchors {
            left: parent.left
            leftMargin: 60
            verticalCenter: parent.verticalCenter
        }
        width: parent.width * 0.75
        spacing: 30

        Item {
            Layout.preferredHeight: 100
        }


        ColumnLayout {
            spacing: -5
            Layout.alignment: Qt.AlignLeft

            Text {
                text: "Welcome to"
                font.family: "Inter"
                font.bold: true
                font.pixelSize: 45
                //font.letterSpacing: 3
                color: "white"
            }

            Text {
                font.family: "Rubik"
                text: "Isko-nnect!"
                font.pixelSize: 90
                font.bold: true
                //font.letterSpacing: 1
                color: "white"
            }

            Item {
                Layout.preferredHeight: 220
            }

            Rectangle {
                Layout.preferredWidth: 500
                Layout.preferredHeight: 2
                Layout.topMargin: 8
                color: "#ccffffff"
                opacity: 0.7
            }
        }

        Text {
            text: "Your comprehensive student services platform\nfor the University of the Philippines Cebu"
            font.pixelSize: 18
            font.family: "Inter"
            font.weight: Font.Medium
            color: "#f5f5f5"
            horizontalAlignment: Text.AlignLeft
            wrapMode: Text.WordWrap
            Layout.fillWidth: true
            lineHeight: 1
        }

    }

}
