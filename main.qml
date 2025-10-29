import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

ApplicationWindow {
    id: mainWindow
    width: 1200
    height: 800
    title: "Менеджер личных вещей"
    visible: true

    // Цветовая тема
    property color primaryColor: "#2c3e50"
    property color secondaryColor: "#34495e"
    property color accentColor: "#3498db"
    property color textColor: "#ecf0f1"

    // Свойство для текущей категории
    property string currentCategory: "all"

    // Заглушка для диалога (пока не создан)
    property var addItemDialog: null

    // Используем наш Header
    Header {
        id: header
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        height: 60

        // Передаем свойства
        primaryColor: mainWindow.primaryColor
        textColor: mainWindow.textColor
        accentColor: mainWindow.accentColor
        addItemDialog: mainWindow.addItemDialog
    }

    // Используем SideBar
    SideBar {
        id: sideBar
        anchors.top: header.bottom
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        width: 250

        // Передаем свойства
        secondaryColor: mainWindow.secondaryColor
        textColor: mainWindow.textColor
        accentColor: mainWindow.accentColor
    }

    // Основная область контента
    Rectangle {
        id: contentArea
        anchors.top: header.bottom
        anchors.left: sideBar.right
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        color: "#ecf0f1"

        property string currentCategory: mainWindow.currentCategory

        Text {
            anchors.centerIn: parent
            text: "Текущая категория: " + contentArea.currentCategory
            font.pixelSize: 18
            color: "#2c3e50"
        }
    }

    Component.onCompleted: {
        console.log("Приложение загружено");
        // Здесь можно добавить тестовые данные
    }
}
