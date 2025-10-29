#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QIcon>
#include "inventorymanager.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    // Регистрируем типы
    qmlRegisterType<Item>("Inventory", 1, 0, "Item");

    // Регистрируем InventoryManager как синглтон
    qmlRegisterSingletonInstance("Inventory", 1, 0, "InventoryManager", &InventoryManager::instance());

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
