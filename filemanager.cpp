#include "filemanager.h"

FileManager::FileManager(QObject *parent) : QObject(parent) {}

void FileManager::saveAnnouncement(const QString &title, const QString &date, const QString &content) {
    QJsonArray existing = loadAnnouncements();
    QJsonObject newItem{
        {"title", title},
        {"date", date},
        {"content", content}
    };
    existing.insert(0, newItem);

    QFile file(ANNOUNCEMENTS_FILE);
    if(file.open(QIODevice::WriteOnly)) {
        file.write(QJsonDocument(existing).toJson());
        file.close();
    }
}

QJsonArray FileManager::loadAnnouncements() {
    QFile file(ANNOUNCEMENTS_FILE);
    if(!file.open(QIODevice::ReadOnly)) return QJsonArray();

    QByteArray data = file.readAll();
    file.close();
    return QJsonDocument::fromJson(data).array();
}

void FileManager::removeAnnouncement(int index) {
    QJsonArray arr = loadAnnouncements();
    if (index >= 0 && index < arr.size()) {
        arr.removeAt(index);
        QFile file(ANNOUNCEMENTS_FILE);
        if (file.open(QIODevice::WriteOnly)) {
            file.write(QJsonDocument(arr).toJson());
            file.close();
        }
    }
}

void FileManager::removeEvent(int index) {
    QJsonArray arr = loadEvents();
    if (index >= 0 && index < arr.size()) {
        arr.removeAt(index);
        QFile file(EVENTS_FILE);
        if (file.open(QIODevice::WriteOnly)) {
            file.write(QJsonDocument(arr).toJson());
            file.close();
        }
    }
}

void FileManager::saveEvent(const QString &title, const QString &date) {
    QJsonArray existing = loadEvents();
    QJsonObject newItem{
        {"title", title},
        {"date", date}
    };
    existing.insert(0, newItem);

    QFile file(EVENTS_FILE);
    if(file.open(QIODevice::WriteOnly)) {
        file.write(QJsonDocument(existing).toJson());
        file.close();
    }
}

void FileManager::saveScholarship(const QString &name, const QString &deadline, const QString &description,
                                  const QString &link, const QJsonArray &courses, const QString &yearLevel,
                                  const QString &financialNeed) {
    QJsonArray existing = loadScholarships();
    QJsonObject newItem{
        {"name", name},
        {"deadline", deadline},
        {"description", description},
        {"link", link},
        {"courses", courses},
        {"yearLevel", yearLevel},
        {"financialNeed", financialNeed}
    };
    existing.insert(0, newItem);

    QFile file(SCHOLARSHIPS);
    if(file.open(QIODevice::WriteOnly)) {
        file.write(QJsonDocument(existing).toJson());
        file.close();
        qDebug() << "Scholarship saved";
    }
}

QJsonArray FileManager::loadScholarships() {
    QFile file(SCHOLARSHIPS);
    if(!file.open(QIODevice::ReadOnly)) {
        return QJsonArray();
    }
    QByteArray data = file.readAll();
    file.close();
    return QJsonDocument::fromJson(data).array();
}

void FileManager::removeScholarship(int index) {
    QJsonArray arr = loadScholarships();
    if (index >= 0 && index < arr.size()) {
        arr.removeAt(index);
        QFile file(SCHOLARSHIPS);
        if (file.open(QIODevice::WriteOnly)) {
            file.write(QJsonDocument(arr).toJson());
            file.close();
        }
    }
}

void FileManager::saveInternship(const QString &name, const QString &deadline, const QString &description,
                                 const QString &link, const QJsonArray &courses, const QString &yearLevel) {
    QJsonArray existing = loadInternships();
    QJsonObject newItem{
        {"name", name},
        {"deadline", deadline},
        {"description", description},
        {"link", link},
        {"courses", courses},
        {"yearLevel", yearLevel}
    };
    existing.insert(0, newItem);

    QFile file(INTERNSHIPS);
    if(file.open(QIODevice::WriteOnly)) {
        file.write(QJsonDocument(existing).toJson());
        file.close();
        qDebug() << "Internship saved";
    }
}

QJsonArray FileManager::loadInternships() {
    QFile file(INTERNSHIPS);
    if(!file.open(QIODevice::ReadOnly)) {
        return QJsonArray();
    }
    QByteArray data = file.readAll();
    file.close();
    return QJsonDocument::fromJson(data).array();
}

void FileManager::removeInternship(int index) {
    QJsonArray arr = loadInternships();
    if (index >= 0 && index < arr.size()) {
        arr.removeAt(index);
        QFile file(INTERNSHIPS);
        if (file.open(QIODevice::WriteOnly)) {
            file.write(QJsonDocument(arr).toJson());
            file.close();
        }
    }
}

void FileManager::saveTutor(const QJsonObject &tutor) {
    QJsonArray existing = loadTutors();
    existing.append(tutor);
    saveArrayToFile(existing, TUTORS_FILE);
    emit tutorsChanged();
}

QJsonArray FileManager::loadTutors() {
    return loadArrayFromFile(TUTORS_FILE);
}

void FileManager::removeTutor(int index) {
    QJsonArray arr = loadTutors();
    if (index >=0 && index < arr.size()) {
        arr.removeAt(index);
        saveArrayToFile(arr, TUTORS_FILE);
        emit tutorsChanged();
    }
}

void FileManager::updateTutor(int index, const QJsonObject &tutor) {
    QJsonArray arr = loadTutors();
    if (index >=0 && index < arr.size()) {
        arr.replace(index, tutor);
        saveArrayToFile(arr, TUTORS_FILE);
        emit tutorsChanged();
    }
}

void FileManager::saveApplication(const QJsonObject &application) {
    QJsonArray existing = loadApplications();
    existing.append(application);
    saveArrayToFile(existing, APPLICATIONS_FILE);
    emit applicationsChanged();
}

QJsonArray FileManager::loadApplications() {
    return loadArrayFromFile(APPLICATIONS_FILE);
}

void FileManager::removeApplication(int index) {
    QJsonArray arr = loadApplications();
    if (index >=0 && index < arr.size()) {
        arr.removeAt(index);
        saveArrayToFile(arr, APPLICATIONS_FILE);
        emit applicationsChanged();
    }
}

void FileManager::approveApplication(int index) {
    QJsonArray apps = loadApplications();
    if (index < 0 || index >= apps.size()) return;

    QJsonObject app = apps[index].toObject();
    QJsonObject tutor;
    tutor["name"] = app["name"];
    tutor["course"] = app["course"];
    tutor["yearLevel"] = app["yearLevel"];
    tutor["status"] = "Approved";

    saveTutor(tutor);
    removeApplication(index);
}

QJsonArray FileManager::loadArrayFromFile(const QString &filename) {
    QFile file(filename);
    if (!file.open(QIODevice::ReadOnly)) {
        return QJsonArray();
    }
    QByteArray data = file.readAll();
    file.close();
    return QJsonDocument::fromJson(data).array();
}

void FileManager::saveArrayToFile(const QJsonArray &array, const QString &filename) {
    QFile file(filename);
    if (file.open(QIODevice::WriteOnly)) {
        file.write(QJsonDocument(array).toJson());
        file.close();
    }
}

QJsonArray FileManager::loadEvents() {
    QFile file(EVENTS_FILE);
    if(!file.open(QIODevice::ReadOnly)) return QJsonArray();

    QByteArray data = file.readAll();
    file.close();
    return QJsonDocument::fromJson(data).array();
}

void FileManager::saveRoom(const QString &number, const QString &capacity, const QString &type, const QString &availability) {
    QJsonArray existing = loadRooms();
    QJsonObject newItem{
        {"number", number},
        {"capacity", capacity},
        {"type", type},
        {"availability", availability}
    };
    existing.append(newItem);

    QFile file(ROOMS_FILE);
    if(file.open(QIODevice::WriteOnly)) {
        file.write(QJsonDocument(existing).toJson());
        file.close();
        emit roomsChanged();
    }
}

QJsonArray FileManager::loadRooms() {
    return loadArrayFromFile(ROOMS_FILE);
}

void FileManager::removeRoom(int index) {
    QJsonArray arr = loadRooms();
    if (index >= 0 && index < arr.size()) {
        arr.removeAt(index);
        QFile file(ROOMS_FILE);
        if (file.open(QIODevice::WriteOnly)) {
            file.write(QJsonDocument(arr).toJson());
            file.close();
            emit roomsChanged();
        }
    }
}

void FileManager::updateRoom(int index, const QString &number, const QString &capacity, const QString &type, const QString &availability) {
    QJsonArray arr = loadRooms();
    if (index >= 0 && index < arr.size()) {
        QJsonObject room = arr[index].toObject();
        room["number"] = number;
        room["capacity"] = capacity;
        room["type"] = type;
        room["availability"] = availability;
        arr.replace(index, room);

        QFile file(ROOMS_FILE);
        if (file.open(QIODevice::WriteOnly)) {
            file.write(QJsonDocument(arr).toJson());
            file.close();
            emit roomsChanged();
        }
    }
}

void FileManager::updateRoomAvailability(int index, const QString &newStatus) {
    QJsonArray rooms = loadRooms();
    if (index >= 0 && index < rooms.size()) {
        QJsonObject room = rooms[index].toObject();
        room["availability"] = newStatus;
        rooms.replace(index, room);

        QFile file(ROOMS_FILE);
        if (file.open(QIODevice::WriteOnly)) {
            file.write(QJsonDocument(rooms).toJson());
            file.close();
            emit roomsChanged();
        }
    }
}

void FileManager::setRoomAvailabilityByName(const QString &roomNumber, const QString &newStatus) {
    QJsonArray rooms = loadRooms();
    bool found = false;

    for (int i = 0; i < rooms.size(); ++i) {
        QJsonObject room = rooms[i].toObject();
        if (room["number"].toString() == roomNumber) {
            room["availability"] = newStatus;
            rooms.replace(i, room);
            found = true;
            break;
        }
    }

    if (found) {
        QFile file(ROOMS_FILE);
        if (file.open(QIODevice::WriteOnly)) {
            file.write(QJsonDocument(rooms).toJson());
            file.close();
            emit roomsChanged();
        }
    }
}

void FileManager::saveTutorRequest(const QVariantMap &requestMap) {
    QJsonObject request = QJsonObject::fromVariantMap(requestMap);
    QJsonArray requests = loadTutorRequests();
    requests.append(request);
    saveArrayToFile(requests, TUTOR_REQUESTS_FILE);
    emit tutorRequestsChanged();
}

QJsonArray FileManager::loadTutorRequests() {
    return loadArrayFromFile(TUTOR_REQUESTS_FILE);
}

void FileManager::saveAllTutorRequests(const QJsonArray &requests) {
    saveArrayToFile(requests, TUTOR_REQUESTS_FILE);
    emit tutorRequestsChanged();
}


