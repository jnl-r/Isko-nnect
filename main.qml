import QtQuick 2.12
import QtQuick.Window 2.12
import "ui/BottomBar"
import "ui/LeftWelcomePage"
import "ui/RightWelcomePage"
import "ui/RightLogin"
import "ui/StudentDashboard"
import "ui/AdminDashboard"


Window {
    width: 1280
    height: 720
    visible: true
    title: qsTr("Isko-nnect")

    flags: Qt.Window | Qt.WindowTitleHint | Qt.WindowCloseButtonHint

    minimumWidth: 1280
    minimumHeight: 720
    maximumWidth: 1280
    maximumHeight: 720

    property string currentPage: "welcome"
    property string userName: ""
    property string userType: ""
    property string studentNumber: ""
    property string selectedLoginType: ""

    Component {
        id: welcomePage

        Item {
            anchors.fill: parent

            LeftWelcomePage {
                id: leftWelcomePage
            }

            RightWelcomePage {
                id: rightWelcomePage
            }

            BottomBar {
                id: bottomBar
            }
        }
    }

    Component {
        id: loginPage

        Item {
            anchors.fill: parent

            LeftWelcomePage {
                id: leftWelcomePage
            }

            RightLogin {
                id: rightLogin
            }

            BottomBar {
                id: bottomBar
            }
        }
    }

    Component {
            id: studentDashboard
            StudentDashboard {
            }
        }

    Component {
            id: adminDashboard
            AdminDashboard {
            }
        }


    Loader {
            id: pageLoader
            anchors.fill: parent
            sourceComponent: {
                if (currentPage === "welcome") return welcomePage
                else if (currentPage === "login") return loginPage
                else if (currentPage === "admin") return adminDashboard
                else if (currentPage === "student") return studentDashboard
                else return null
            }
        }

}
