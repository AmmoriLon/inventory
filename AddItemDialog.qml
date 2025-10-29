// AddItemDialog.qml
import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Dialog {
    id: addItemDialog
    title: "Добавить новую вещь"
    modal: true
    standardButtons: Dialog.Ok | Dialog.Cancel

    property string selectedImage: ""

    ColumnLayout {
        width: parent ? parent.width : 400
        spacing: 10

        TextField {
            id: nameField
            placeholderText: "Название вещи"
            Layout.fillWidth: true
        }

        ComboBox {
            id: categoryCombo
            model: ["Верхняя одежда", "Средний слой", "Нижняя одежда",
                   "Белье", "Постельное белье", "Посуда", "Аксессуары", "Другое"]
            Layout.fillWidth: true
        }

        SpinBox {
            id: quantitySpin
            from: 1
            to: 999
            value: 1
            Layout.fillWidth: true
        }

        TextArea {
            id: descriptionArea
            placeholderText: "Описание..."
            Layout.fillWidth: true
            Layout.preferredHeight: 80
        }

        Button {
            text: "Выбрать изображение"
            onClicked: fileDialog.open()
            Layout.fillWidth: true
        }

        Image {
            id: previewImage
            Layout.preferredWidth: 100
            Layout.preferredHeight: 100
            source: selectedImage
            fillMode: Image.PreserveAspectFit
        }
    }

    FileDialog {
        id: fileDialog
        title: "Выберите изображение"
        nameFilters: ["Image files (*.jpg *.png *.jpeg)"]
        onAccepted: {
            selectedImage = fileDialog.selectedFile
        }
    }

    onAccepted: {
        inventoryManager.addItem(
            nameField.text,
            categoryCombo.currentText,
            quantitySpin.value,
            descriptionArea.text,
            selectedImage
        )
    }
}
