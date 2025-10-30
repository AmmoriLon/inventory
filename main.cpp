// main.cpp
#include <QApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "ItemModel.h"

int main(int argc, char *argv[]) // точка входа
{
    QApplication app(argc, argv); // запускаем приложение

    qmlRegisterType<ItemModel>("Inventory", 1, 0, "ItemModel");

    QQmlApplicationEngine engine;

    // Создаём модель
    ItemModel model;
    model.loadFromFile("inventory.json");

    engine.rootContext()->setContextProperty("inventoryModel", &model);
    engine.rootContext()->setContextProperty("categoriesList", model.property("categories"));

    const QUrl url(QStringLiteral("qrc:/main.qml"));
    engine.load(url);

    return app.exec();
}
