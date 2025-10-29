// ItemCard.qml
import QtQuick 2.15
import QtQuick.Controls 2.15

Rectangle {
    id: card
    property var itemData: modelData

    radius: 10
    border.color: "#bdc3c7"
    border.width: 1

    Column {
        anchors.fill: parent
        anchors.margins: 10
        spacing: 5

        // Изображение предмета
        Rectangle {
            width: parent.width
            height: 100
            color: "#f8f9fa"
            radius: 5

            Image {
                anchors.centerIn: parent
                width: Math.min(parent.width - 20, 80)
                height: Math.min(parent.height - 20, 80)
                source: itemData ? itemData.imagePath : ""
                fillMode: Image.PreserveAspectFit

                // Заглушка если нет изображения
                Rectangle {
                    anchors.fill: parent
                    color: "transparent"
                    border.color: "#bdc3c7"
                    visible: !parent.source

                    Text {
                        anchors.centerIn: parent
                        text: "📷"
                        font.pixelSize: 24
                    }
                }
            }
        }

        // Название
        Text {
            width: parent.width
            text: itemData ? itemData.name : ""
            font.pixelSize: 14
            font.bold: true
            elide: Text.ElideRight
        }

        // Категория
        Text {
            width: parent.width
            text: itemData ? itemData.category : ""
            font.pixelSize: 12
            color: "#7f8c8d"
        }

        // Количество
        Row {
            width: parent.width
            spacing: 5

            Text {
                text: "Количество:"
                font.pixelSize: 12
                color: "#7f8c8d"
            }

            Text {
                text: itemData ? itemData.quantity : 0
                font.pixelSize: 12
                font.bold: true
            }
        }

        // Кнопки действий
        Row {
            width: parent.width
            spacing: 5

            Button {
                text: "✏️"
                onClicked: editItem(itemData)
                background: Rectangle {
                    color: "transparent"
                }
            }

            Button {
                text: "🗑️"
                onClicked: deleteItem(index)
                background: Rectangle {
                    color: "transparent"
                }
            }
        }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: itemDetailsDialog.showItem(itemData)
        cursorShape: Qt.PointingHandCursor
    }
}
