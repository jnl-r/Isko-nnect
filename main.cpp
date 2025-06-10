#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QStandardPaths>
#include "filemanager.h"

int main(int argc, char *argv[]) {
    QGuiApplication app(argc, argv);

    QCoreApplication::setOrganizationName("Iskonnect");
    QCoreApplication::setApplicationName("StudentPortal");

    qmlRegisterType<FileManager>("FileManager", 1, 0, "FileManager");

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}
