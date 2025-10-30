// Main.qml
import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Dialogs 1.3
import Inventory 1.0

Window {
    visible: true
    width: 1000
    height: 600
    title: "Менеджер вещей"

    // Переменные
    property string currentCategory: "Все"
    property string selectedImage: ""

    FileDialog {
        id: fileDialog
        title: "Выберите изображение"
        folder: shortcuts.pictures
        nameFilters: ["Изображения (*.png *.jpg *.jpeg)"]
        onAccepted: {
            selectedImage = fileDialog.fileUrl.toString().replace("file://", "")
        }
    }

    RowLayout {
        anchors.fill: parent
        spacing: 10

        // === ЛЕВАЯ ПАНЕЛЬ: КАТЕГОРИИ ===
        Rectangle {
            width: 200
            Layout.fillHeight: true
            color: "#f0f0f0"
            radius: 8

            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 10

                Text {
                    text: "Категории"
                    font.bold: true
                    font.pixelSize: 18
                }

                ListView {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    model: ["Все"].concat(categoriesList)
                    delegate: Rectangle {
                        width: parent.width
                        height: 40
                        color: modelData === currentCategory ? "#007acc" : "transparent"
                        radius: 6

                        Text {
                            anchors.centerIn: parent
                            text: modelData
                            color: modelData === currentCategory ? "white" : "black"
                        }

                        MouseArea {
                            anchors.fill: parent
                            onClicked: currentCategory = modelData
                        }
                    }
                }
            }
        }

        // === ЦЕНТР: СЕТКА ПРЕДМЕТОВ ===
        ColumnLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true
            spacing: 10

            Text {
                text: currentCategory
                font.pixelSize: 24
                font.bold: true
            }

            GridView {
                Layout.fillWidth: true
                Layout.fillHeight: true
                cellWidth: 150
                cellHeight: 180

                model: inventoryModel

                delegate: Rectangle {
                    width: 140
                    height: 170
                    border.color: "#ccc"
                    radius: 10
                    color: "white"

                    Column {
                        anchors.fill: parent
                        anchors.margins: 8
                        spacing: 5

                        Image {
                            width: 80
                            height: 80
                            anchors.horizontalCenter: parent.horizontalCenter
                            source: model.imagePath ? "file://" + model.imagePath : "qrc:/placeholder.png"
                            fillMode: Image.PreserveAspectFit
                        }

                        Text {
                            text: model.name
                            font.bold: true
                            wrapMode: Text.WordWrap
                            width: parent.width
                            horizontalAlignment: Text.AlignHCenter
                        }

                        Text {
                            text: "×" + model.quantity
                            font.pixelSize: 12
                            color: "gray"
                        }

                        Text {
                            text: model.note
                            font.pixelSize: 10
                            color: "#555"
                            width: parent.width
                            wrapMode: Text.WordWrap
                            elide: Text.ElideRight
                            maximumLineCount: 2
                        }
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            // Пока просто покажем
                            console.log("Нажат:", model.name)
                        }
                    }
                }
            }

            // === КНОПКА ДОБАВЛЕНИЯ ===
            Button {
                text: "Добавить предмет"
                Layout.alignment: Qt.AlignRight
                onClicked: addDialog.open()
            }
        }
    }

    // === ДИАЛОГ ДОБАВЛЕНИЯ ===
    Dialog {
        id: addDialog
        title: "Новый предмет"
        standardButtons: Dialog.Ok | Dialog.Cancel

        ColumnLayout {
            width: 300

            TextField { id: nameField; placeholderText: "Название" }
            SpinBox { id: qtyField; value: 1; from: 1; to: 999 }
            ComboBox {
                id: catCombo
                model: categoriesList
                Layout.fillWidth: true
            }
            TextField { id: noteField; placeholderText: "Примечание" }

            RowLayout {
                Text { text: "Изображение:" }
                Text {
                    text: selectedImage ? selectedImage.split('/').pop() : "не выбрано"
                    elide: Text.ElideLeft
                    Layout.fillWidth: true
                }
                Button {
                    text: "Выбрать"
                    onClicked: fileDialog.open()
                }
            }
        }

        onAccepted: {
            if (nameField.text === "") return;

            inventoryModel.addItem(
                nameField.text,
                qtyField.value,
                catCombo.currentText,
                noteField.text,
                selectedImage
            );

            // Сброс
            nameField.text = ""
            qtyField.value = 1
            noteField.text = ""
            selectedImage = ""
        }
    }

    // === Сохранение при выходе ===
    Component.onDestruction: {
        inventoryModel.saveToFile("inventory.json")
    }
}
