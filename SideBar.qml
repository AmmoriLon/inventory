import QtQuick 2.15
import QtQuick.Controls 2.15

Rectangle {
    // Свойства для цветов
    property color secondaryColor: "#34495e"
    property color textColor: "#ecf0f1"
    property color accentColor: "#3498db"

    color: secondaryColor
    width: 250

    ListView {
        id: categoryList
        anchors.fill: parent
        anchors.margins: 10

        model: ListModel {
            ListElement { name: "Все вещи"; category: "all"; icon: "📦" }
            ListElement { name: "Верхняя одежда"; category: "clothing_top"; icon: "🧥" }
            ListElement { name: "Средний слой"; category: "clothing_middle"; icon: "👔" }
            ListElement { name: "Нижняя одежда"; category: "clothing_bottom"; icon: "👖" }
            ListElement { name: "Белье"; category: "underwear"; icon: "🩲" }
            ListElement { name: "Постельное белье"; category: "bedding"; icon: "🛏️" }
            ListElement { name: "Посуда"; category: "dishes"; icon: "🍽️" }
            ListElement { name: "Аксессуары"; category: "accessories"; icon: "👓" }
            ListElement { name: "Другое"; category: "other"; icon: "📎" }
        }

        delegate: Button {
            width: categoryList.width - 20
            height: 50
            text: icon + " " + name

            onClicked: {
                console.log("Выбрана категория:", category);
                // Обновляем свойство в главном окне
                mainWindow.currentCategory = category;
            }

            background: Rectangle {
                color: mainWindow.currentCategory === category ? accentColor : "transparent"
                radius: 5
                border.color: mainWindow.currentCategory === category ? accentColor : "transparent"
                border.width: 2
            }

            contentItem: Text {
                text: parent.text
                color: textColor
                font.pixelSize: 14
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignVCenter
                leftPadding: 10
            }
        }

        // Разделитель между элементами
        spacing: 5
    }
}
