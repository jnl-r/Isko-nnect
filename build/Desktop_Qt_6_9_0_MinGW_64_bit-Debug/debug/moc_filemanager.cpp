/****************************************************************************
** Meta object code from reading C++ file 'filemanager.h'
**
** Created by: The Qt Meta Object Compiler version 69 (Qt 6.9.0)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../../filemanager.h"
#include <QtCore/qmetatype.h>

#include <QtCore/qtmochelpers.h>

#include <memory>


#include <QtCore/qxptype_traits.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'filemanager.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 69
#error "This file was generated using the moc from 6.9.0. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

#ifndef Q_CONSTINIT
#define Q_CONSTINIT
#endif

QT_WARNING_PUSH
QT_WARNING_DISABLE_DEPRECATED
QT_WARNING_DISABLE_GCC("-Wuseless-cast")
namespace {
struct qt_meta_tag_ZN11FileManagerE_t {};
} // unnamed namespace

template <> constexpr inline auto FileManager::qt_create_metaobjectdata<qt_meta_tag_ZN11FileManagerE_t>()
{
    namespace QMC = QtMocConstants;
    QtMocHelpers::StringRefStorage qt_stringData {
        "FileManager",
        "tutorsChanged",
        "",
        "applicationsChanged",
        "roomsChanged",
        "tutorRequestsChanged",
        "saveAnnouncement",
        "title",
        "date",
        "content",
        "loadAnnouncements",
        "saveEvent",
        "loadEvents",
        "removeAnnouncement",
        "index",
        "removeEvent",
        "saveScholarship",
        "name",
        "deadline",
        "description",
        "link",
        "courses",
        "yearLevel",
        "financialNeed",
        "loadScholarships",
        "removeScholarship",
        "saveInternship",
        "loadInternships",
        "removeInternship",
        "saveTutor",
        "tutor",
        "loadTutors",
        "removeTutor",
        "updateTutor",
        "saveApplication",
        "application",
        "loadApplications",
        "removeApplication",
        "approveApplication",
        "saveRoom",
        "number",
        "capacity",
        "type",
        "availability",
        "loadRooms",
        "removeRoom",
        "updateRoom",
        "updateRoomAvailability",
        "newStatus",
        "saveTutorRequest",
        "QVariantMap",
        "requestMap",
        "loadTutorRequests",
        "saveAllTutorRequests",
        "requests",
        "setRoomAvailabilityByName",
        "roomNumber"
    };

    QtMocHelpers::UintData qt_methods {
        // Signal 'tutorsChanged'
        QtMocHelpers::SignalData<void()>(1, 2, QMC::AccessPublic, QMetaType::Void),
        // Signal 'applicationsChanged'
        QtMocHelpers::SignalData<void()>(3, 2, QMC::AccessPublic, QMetaType::Void),
        // Signal 'roomsChanged'
        QtMocHelpers::SignalData<void()>(4, 2, QMC::AccessPublic, QMetaType::Void),
        // Signal 'tutorRequestsChanged'
        QtMocHelpers::SignalData<void()>(5, 2, QMC::AccessPublic, QMetaType::Void),
        // Method 'saveAnnouncement'
        QtMocHelpers::MethodData<void(const QString &, const QString &, const QString &)>(6, 2, QMC::AccessPublic, QMetaType::Void, {{
            { QMetaType::QString, 7 }, { QMetaType::QString, 8 }, { QMetaType::QString, 9 },
        }}),
        // Method 'loadAnnouncements'
        QtMocHelpers::MethodData<QJsonArray()>(10, 2, QMC::AccessPublic, QMetaType::QJsonArray),
        // Method 'saveEvent'
        QtMocHelpers::MethodData<void(const QString &, const QString &)>(11, 2, QMC::AccessPublic, QMetaType::Void, {{
            { QMetaType::QString, 7 }, { QMetaType::QString, 8 },
        }}),
        // Method 'loadEvents'
        QtMocHelpers::MethodData<QJsonArray()>(12, 2, QMC::AccessPublic, QMetaType::QJsonArray),
        // Method 'removeAnnouncement'
        QtMocHelpers::MethodData<void(int)>(13, 2, QMC::AccessPublic, QMetaType::Void, {{
            { QMetaType::Int, 14 },
        }}),
        // Method 'removeEvent'
        QtMocHelpers::MethodData<void(int)>(15, 2, QMC::AccessPublic, QMetaType::Void, {{
            { QMetaType::Int, 14 },
        }}),
        // Method 'saveScholarship'
        QtMocHelpers::MethodData<void(const QString &, const QString &, const QString &, const QString &, const QJsonArray &, const QString &, const QString &)>(16, 2, QMC::AccessPublic, QMetaType::Void, {{
            { QMetaType::QString, 17 }, { QMetaType::QString, 18 }, { QMetaType::QString, 19 }, { QMetaType::QString, 20 },
            { QMetaType::QJsonArray, 21 }, { QMetaType::QString, 22 }, { QMetaType::QString, 23 },
        }}),
        // Method 'loadScholarships'
        QtMocHelpers::MethodData<QJsonArray()>(24, 2, QMC::AccessPublic, QMetaType::QJsonArray),
        // Method 'removeScholarship'
        QtMocHelpers::MethodData<void(int)>(25, 2, QMC::AccessPublic, QMetaType::Void, {{
            { QMetaType::Int, 14 },
        }}),
        // Method 'saveInternship'
        QtMocHelpers::MethodData<void(const QString &, const QString &, const QString &, const QString &, const QJsonArray &, const QString &)>(26, 2, QMC::AccessPublic, QMetaType::Void, {{
            { QMetaType::QString, 17 }, { QMetaType::QString, 18 }, { QMetaType::QString, 19 }, { QMetaType::QString, 20 },
            { QMetaType::QJsonArray, 21 }, { QMetaType::QString, 22 },
        }}),
        // Method 'loadInternships'
        QtMocHelpers::MethodData<QJsonArray()>(27, 2, QMC::AccessPublic, QMetaType::QJsonArray),
        // Method 'removeInternship'
        QtMocHelpers::MethodData<void(int)>(28, 2, QMC::AccessPublic, QMetaType::Void, {{
            { QMetaType::Int, 14 },
        }}),
        // Method 'saveTutor'
        QtMocHelpers::MethodData<void(const QJsonObject &)>(29, 2, QMC::AccessPublic, QMetaType::Void, {{
            { QMetaType::QJsonObject, 30 },
        }}),
        // Method 'loadTutors'
        QtMocHelpers::MethodData<QJsonArray()>(31, 2, QMC::AccessPublic, QMetaType::QJsonArray),
        // Method 'removeTutor'
        QtMocHelpers::MethodData<void(int)>(32, 2, QMC::AccessPublic, QMetaType::Void, {{
            { QMetaType::Int, 14 },
        }}),
        // Method 'updateTutor'
        QtMocHelpers::MethodData<void(int, const QJsonObject &)>(33, 2, QMC::AccessPublic, QMetaType::Void, {{
            { QMetaType::Int, 14 }, { QMetaType::QJsonObject, 30 },
        }}),
        // Method 'saveApplication'
        QtMocHelpers::MethodData<void(const QJsonObject &)>(34, 2, QMC::AccessPublic, QMetaType::Void, {{
            { QMetaType::QJsonObject, 35 },
        }}),
        // Method 'loadApplications'
        QtMocHelpers::MethodData<QJsonArray()>(36, 2, QMC::AccessPublic, QMetaType::QJsonArray),
        // Method 'removeApplication'
        QtMocHelpers::MethodData<void(int)>(37, 2, QMC::AccessPublic, QMetaType::Void, {{
            { QMetaType::Int, 14 },
        }}),
        // Method 'approveApplication'
        QtMocHelpers::MethodData<void(int)>(38, 2, QMC::AccessPublic, QMetaType::Void, {{
            { QMetaType::Int, 14 },
        }}),
        // Method 'saveRoom'
        QtMocHelpers::MethodData<void(const QString &, const QString &, const QString &, const QString &)>(39, 2, QMC::AccessPublic, QMetaType::Void, {{
            { QMetaType::QString, 40 }, { QMetaType::QString, 41 }, { QMetaType::QString, 42 }, { QMetaType::QString, 43 },
        }}),
        // Method 'loadRooms'
        QtMocHelpers::MethodData<QJsonArray()>(44, 2, QMC::AccessPublic, QMetaType::QJsonArray),
        // Method 'removeRoom'
        QtMocHelpers::MethodData<void(int)>(45, 2, QMC::AccessPublic, QMetaType::Void, {{
            { QMetaType::Int, 14 },
        }}),
        // Method 'updateRoom'
        QtMocHelpers::MethodData<void(int, const QString &, const QString &, const QString &, const QString &)>(46, 2, QMC::AccessPublic, QMetaType::Void, {{
            { QMetaType::Int, 14 }, { QMetaType::QString, 40 }, { QMetaType::QString, 41 }, { QMetaType::QString, 42 },
            { QMetaType::QString, 43 },
        }}),
        // Method 'updateRoomAvailability'
        QtMocHelpers::MethodData<void(int, const QString &)>(47, 2, QMC::AccessPublic, QMetaType::Void, {{
            { QMetaType::Int, 14 }, { QMetaType::QString, 48 },
        }}),
        // Method 'saveTutorRequest'
        QtMocHelpers::MethodData<void(const QVariantMap &)>(49, 2, QMC::AccessPublic, QMetaType::Void, {{
            { 0x80000000 | 50, 51 },
        }}),
        // Method 'loadTutorRequests'
        QtMocHelpers::MethodData<QJsonArray()>(52, 2, QMC::AccessPublic, QMetaType::QJsonArray),
        // Method 'saveAllTutorRequests'
        QtMocHelpers::MethodData<void(const QJsonArray &)>(53, 2, QMC::AccessPublic, QMetaType::Void, {{
            { QMetaType::QJsonArray, 54 },
        }}),
        // Method 'setRoomAvailabilityByName'
        QtMocHelpers::MethodData<void(const QString &, const QString &)>(55, 2, QMC::AccessPublic, QMetaType::Void, {{
            { QMetaType::QString, 56 }, { QMetaType::QString, 48 },
        }}),
    };
    QtMocHelpers::UintData qt_properties {
    };
    QtMocHelpers::UintData qt_enums {
    };
    return QtMocHelpers::metaObjectData<FileManager, qt_meta_tag_ZN11FileManagerE_t>(QMC::MetaObjectFlag{}, qt_stringData,
            qt_methods, qt_properties, qt_enums);
}
Q_CONSTINIT const QMetaObject FileManager::staticMetaObject = { {
    QMetaObject::SuperData::link<QObject::staticMetaObject>(),
    qt_staticMetaObjectStaticContent<qt_meta_tag_ZN11FileManagerE_t>.stringdata,
    qt_staticMetaObjectStaticContent<qt_meta_tag_ZN11FileManagerE_t>.data,
    qt_static_metacall,
    nullptr,
    qt_staticMetaObjectRelocatingContent<qt_meta_tag_ZN11FileManagerE_t>.metaTypes,
    nullptr
} };

void FileManager::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    auto *_t = static_cast<FileManager *>(_o);
    if (_c == QMetaObject::InvokeMetaMethod) {
        switch (_id) {
        case 0: _t->tutorsChanged(); break;
        case 1: _t->applicationsChanged(); break;
        case 2: _t->roomsChanged(); break;
        case 3: _t->tutorRequestsChanged(); break;
        case 4: _t->saveAnnouncement((*reinterpret_cast< std::add_pointer_t<QString>>(_a[1])),(*reinterpret_cast< std::add_pointer_t<QString>>(_a[2])),(*reinterpret_cast< std::add_pointer_t<QString>>(_a[3]))); break;
        case 5: { QJsonArray _r = _t->loadAnnouncements();
            if (_a[0]) *reinterpret_cast< QJsonArray*>(_a[0]) = std::move(_r); }  break;
        case 6: _t->saveEvent((*reinterpret_cast< std::add_pointer_t<QString>>(_a[1])),(*reinterpret_cast< std::add_pointer_t<QString>>(_a[2]))); break;
        case 7: { QJsonArray _r = _t->loadEvents();
            if (_a[0]) *reinterpret_cast< QJsonArray*>(_a[0]) = std::move(_r); }  break;
        case 8: _t->removeAnnouncement((*reinterpret_cast< std::add_pointer_t<int>>(_a[1]))); break;
        case 9: _t->removeEvent((*reinterpret_cast< std::add_pointer_t<int>>(_a[1]))); break;
        case 10: _t->saveScholarship((*reinterpret_cast< std::add_pointer_t<QString>>(_a[1])),(*reinterpret_cast< std::add_pointer_t<QString>>(_a[2])),(*reinterpret_cast< std::add_pointer_t<QString>>(_a[3])),(*reinterpret_cast< std::add_pointer_t<QString>>(_a[4])),(*reinterpret_cast< std::add_pointer_t<QJsonArray>>(_a[5])),(*reinterpret_cast< std::add_pointer_t<QString>>(_a[6])),(*reinterpret_cast< std::add_pointer_t<QString>>(_a[7]))); break;
        case 11: { QJsonArray _r = _t->loadScholarships();
            if (_a[0]) *reinterpret_cast< QJsonArray*>(_a[0]) = std::move(_r); }  break;
        case 12: _t->removeScholarship((*reinterpret_cast< std::add_pointer_t<int>>(_a[1]))); break;
        case 13: _t->saveInternship((*reinterpret_cast< std::add_pointer_t<QString>>(_a[1])),(*reinterpret_cast< std::add_pointer_t<QString>>(_a[2])),(*reinterpret_cast< std::add_pointer_t<QString>>(_a[3])),(*reinterpret_cast< std::add_pointer_t<QString>>(_a[4])),(*reinterpret_cast< std::add_pointer_t<QJsonArray>>(_a[5])),(*reinterpret_cast< std::add_pointer_t<QString>>(_a[6]))); break;
        case 14: { QJsonArray _r = _t->loadInternships();
            if (_a[0]) *reinterpret_cast< QJsonArray*>(_a[0]) = std::move(_r); }  break;
        case 15: _t->removeInternship((*reinterpret_cast< std::add_pointer_t<int>>(_a[1]))); break;
        case 16: _t->saveTutor((*reinterpret_cast< std::add_pointer_t<QJsonObject>>(_a[1]))); break;
        case 17: { QJsonArray _r = _t->loadTutors();
            if (_a[0]) *reinterpret_cast< QJsonArray*>(_a[0]) = std::move(_r); }  break;
        case 18: _t->removeTutor((*reinterpret_cast< std::add_pointer_t<int>>(_a[1]))); break;
        case 19: _t->updateTutor((*reinterpret_cast< std::add_pointer_t<int>>(_a[1])),(*reinterpret_cast< std::add_pointer_t<QJsonObject>>(_a[2]))); break;
        case 20: _t->saveApplication((*reinterpret_cast< std::add_pointer_t<QJsonObject>>(_a[1]))); break;
        case 21: { QJsonArray _r = _t->loadApplications();
            if (_a[0]) *reinterpret_cast< QJsonArray*>(_a[0]) = std::move(_r); }  break;
        case 22: _t->removeApplication((*reinterpret_cast< std::add_pointer_t<int>>(_a[1]))); break;
        case 23: _t->approveApplication((*reinterpret_cast< std::add_pointer_t<int>>(_a[1]))); break;
        case 24: _t->saveRoom((*reinterpret_cast< std::add_pointer_t<QString>>(_a[1])),(*reinterpret_cast< std::add_pointer_t<QString>>(_a[2])),(*reinterpret_cast< std::add_pointer_t<QString>>(_a[3])),(*reinterpret_cast< std::add_pointer_t<QString>>(_a[4]))); break;
        case 25: { QJsonArray _r = _t->loadRooms();
            if (_a[0]) *reinterpret_cast< QJsonArray*>(_a[0]) = std::move(_r); }  break;
        case 26: _t->removeRoom((*reinterpret_cast< std::add_pointer_t<int>>(_a[1]))); break;
        case 27: _t->updateRoom((*reinterpret_cast< std::add_pointer_t<int>>(_a[1])),(*reinterpret_cast< std::add_pointer_t<QString>>(_a[2])),(*reinterpret_cast< std::add_pointer_t<QString>>(_a[3])),(*reinterpret_cast< std::add_pointer_t<QString>>(_a[4])),(*reinterpret_cast< std::add_pointer_t<QString>>(_a[5]))); break;
        case 28: _t->updateRoomAvailability((*reinterpret_cast< std::add_pointer_t<int>>(_a[1])),(*reinterpret_cast< std::add_pointer_t<QString>>(_a[2]))); break;
        case 29: _t->saveTutorRequest((*reinterpret_cast< std::add_pointer_t<QVariantMap>>(_a[1]))); break;
        case 30: { QJsonArray _r = _t->loadTutorRequests();
            if (_a[0]) *reinterpret_cast< QJsonArray*>(_a[0]) = std::move(_r); }  break;
        case 31: _t->saveAllTutorRequests((*reinterpret_cast< std::add_pointer_t<QJsonArray>>(_a[1]))); break;
        case 32: _t->setRoomAvailabilityByName((*reinterpret_cast< std::add_pointer_t<QString>>(_a[1])),(*reinterpret_cast< std::add_pointer_t<QString>>(_a[2]))); break;
        default: ;
        }
    }
    if (_c == QMetaObject::IndexOfMethod) {
        if (QtMocHelpers::indexOfMethod<void (FileManager::*)()>(_a, &FileManager::tutorsChanged, 0))
            return;
        if (QtMocHelpers::indexOfMethod<void (FileManager::*)()>(_a, &FileManager::applicationsChanged, 1))
            return;
        if (QtMocHelpers::indexOfMethod<void (FileManager::*)()>(_a, &FileManager::roomsChanged, 2))
            return;
        if (QtMocHelpers::indexOfMethod<void (FileManager::*)()>(_a, &FileManager::tutorRequestsChanged, 3))
            return;
    }
}

const QMetaObject *FileManager::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *FileManager::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_staticMetaObjectStaticContent<qt_meta_tag_ZN11FileManagerE_t>.strings))
        return static_cast<void*>(this);
    return QObject::qt_metacast(_clname);
}

int FileManager::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 33)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 33;
    }
    if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 33)
            *reinterpret_cast<QMetaType *>(_a[0]) = QMetaType();
        _id -= 33;
    }
    return _id;
}

// SIGNAL 0
void FileManager::tutorsChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 0, nullptr);
}

// SIGNAL 1
void FileManager::applicationsChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 1, nullptr);
}

// SIGNAL 2
void FileManager::roomsChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 2, nullptr);
}

// SIGNAL 3
void FileManager::tutorRequestsChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 3, nullptr);
}
QT_WARNING_POP
