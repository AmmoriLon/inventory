// ContentArea.qml
import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    property string currentCategory: "all"

    color: "#ecf0f1"

    ScrollView {
        anchors.fill: parent
        anchors.margins: 20

        GridView {
            id: itemsGrid
            anchors.fill: parent
            cellWidth: 180
            cellHeight: 220

            model: inventoryManager.items

            delegate: ItemCard {
                width: itemsGrid.cellWidth - 10
                height: itemsGrid.cellHeight - 10
            }
        }
    }
}

