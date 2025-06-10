#ifndef FILEMANAGER_H
#define FILEMANAGER_H

#include <QObject>
#include <QFile>
#include <QTextStream>
#include <QJsonDocument>
#include <QJsonArray>
#include <QJsonObject>


class FileManager : public QObject {
    Q_OBJECT
public:
    explicit FileManager(QObject *parent = nullptr);

    Q_INVOKABLE void saveAnnouncement(const QString &title, const QString &date, const QString &content);
    Q_INVOKABLE QJsonArray loadAnnouncements();
    Q_INVOKABLE void saveEvent(const QString &title, const QString &date);
    Q_INVOKABLE QJsonArray loadEvents();
    Q_INVOKABLE void removeAnnouncement(int index);
    Q_INVOKABLE void removeEvent(int index);

    Q_INVOKABLE void saveScholarship(const QString &name, const QString &deadline, const QString &description,
                                     const QString &link, const QJsonArray &courses, const QString &yearLevel,
                                     const QString &financialNeed);
    Q_INVOKABLE QJsonArray loadScholarships();
    Q_INVOKABLE void removeScholarship(int index);

    Q_INVOKABLE void saveInternship(const QString &name, const QString &deadline, const QString &description,
                                    const QString &link, const QJsonArray &courses, const QString &yearLevel);
    Q_INVOKABLE QJsonArray loadInternships();
    Q_INVOKABLE void removeInternship(int index);

    Q_INVOKABLE void saveTutor(const QJsonObject &tutor);
    Q_INVOKABLE QJsonArray loadTutors();
    Q_INVOKABLE void removeTutor(int index);
    Q_INVOKABLE void updateTutor(int index, const QJsonObject &tutor);

    Q_INVOKABLE void saveApplication(const QJsonObject &application);
    Q_INVOKABLE QJsonArray loadApplications();
    Q_INVOKABLE void removeApplication(int index);
    Q_INVOKABLE void approveApplication(int index);

    Q_INVOKABLE void saveRoom(const QString &number, const QString &capacity, const QString &type, const QString &availability);
    Q_INVOKABLE QJsonArray loadRooms();
    Q_INVOKABLE void removeRoom(int index);
    Q_INVOKABLE void updateRoom(int index, const QString &number, const QString &capacity, const QString &type, const QString &availability);
    Q_INVOKABLE void updateRoomAvailability(int index, const QString &newStatus);

    Q_INVOKABLE void saveTutorRequest(const QVariantMap &requestMap);
    Q_INVOKABLE QJsonArray loadTutorRequests();
    Q_INVOKABLE void saveAllTutorRequests(const QJsonArray &requests);

    Q_INVOKABLE void setRoomAvailabilityByName(const QString &roomNumber, const QString &newStatus);



signals:
    void tutorsChanged();
    void applicationsChanged();
    void roomsChanged();
    void tutorRequestsChanged();

private:
    QString ANNOUNCEMENTS_FILE = "announcements.json";
    QString EVENTS_FILE = "events.json";
    QString SCHOLARSHIPS = "scholarships.json";
    QString INTERNSHIPS = "internships.json";

    QString TUTORS_FILE = "tutors.json";
    QString APPLICATIONS_FILE = "applications.json";
    QString ROOMS_FILE = "ver2rooms.json";

    QString TUTOR_REQUESTS_FILE = "tutorrequests.json";

    QJsonArray loadArrayFromFile(const QString &filename);
    void saveArrayToFile(const QJsonArray &array, const QString &filename);
};

#endif // FILEMANAGER_H
