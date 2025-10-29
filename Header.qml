import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    // Определяем свойства, которые будут передаваться из родителя
    property color primaryColor: "#2c3e50"
    property color textColor: "#ecf0f1"
    property color accentColor: "#3498db"

    // Ссылка на диалог добавления (будет установлена извне)
    property var addItemDialog

    color: primaryColor
    height: 60

    RowLayout {
        anchors.fill: parent
        anchors.margins: 10

        Label {
            text: "📦 Мой инвентарь"
            font.pixelSize: 20
            font.bold: true
            color: textColor
            Layout.fillWidth: true
        }

        Button {
            text: "➕ Добавить вещь"
            onClicked: {
                console.log("Кнопка нажата");
                if (addItemDialog) {
                    addItemDialog.open();
                } else {
                    console.log("Диалог не установлен");
                    // Временное сообщение
                    addItemMessage.open();
                }
            }
            background: Rectangle {
                color: accentColor
                radius: 5
            }
            contentItem: Text {
                text: parent.text
                color: textColor
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: 14
            }
        }
    }

    // Временное сообщение вместо диалога
    Dialog {
        id: addItemMessage
        title: "Добавление предмета"
        modal: true
        standardButtons: Dialog.Ok

        Label {
            text: "Функция добавления предмета будет реализована позже"
        }
    }
}
