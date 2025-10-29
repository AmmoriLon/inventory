#include "inventorymanager.h"
#include <QDebug>

InventoryManager& InventoryManager::instance()
{
    static InventoryManager instance;
    return instance;
}

InventoryManager::InventoryManager(QObject *parent)
    : QObject(parent)
{
    // НЕ создаем Items здесь! Они создаются в неправильном потоке
    qDebug() << "InventoryManager создан";
}

InventoryManager::~InventoryManager()
{
    // Очищаем память
    for (Item* item : m_items) {
        delete item;
    }
    m_items.clear();
}

QVariantList InventoryManager::items() const
{
    QVariantList list;
    for (Item* item : m_items) {
        list.append(QVariant::fromValue(item));
    }
    return list;
}

void InventoryManager::addItem(const QString& name, const QString& category,
                             int quantity, const QString& description,
                             const QString& imagePath)
{
    // Создаем Item с правильным родителем (this)
    Item* newItem = new Item(name, category, quantity, this);
    newItem->setDescription(description);
    newItem->setImagePath(imagePath);

    m_items.append(newItem);
    emit itemsChanged();
    emit totalItemsChanged();

    qDebug() << "Добавлен предмет:" << name << "Всего предметов:" << m_items.size();
}

void InventoryManager::removeItem(int index)
{
    if (index >= 0 && index < m_items.size()) {
        Item* item = m_items.takeAt(index);
        delete item;
        emit itemsChanged();
        emit totalItemsChanged();
    }
}

void InventoryManager::updateItem(int index, const QString& name, const QString& category,
                                int quantity, const QString& description, const QString& imagePath)
{
    if (index >= 0 && index < m_items.size()) {
        Item* item = m_items[index];
        item->setName(name);
        item->setCategory(category);
        item->setQuantity(quantity);
        item->setDescription(description);
        item->setImagePath(imagePath);

        emit itemsChanged();
    }
}

Item* InventoryManager::getItem(int index)
{
    if (index >= 0 && index < m_items.size()) {
        return m_items[index];
    }
    return nullptr;
}

QStringList InventoryManager::getCategories() const
{
    return {
        "Верхняя одежда",
        "Средний слой",
        "Нижняя одежда",
        "Белье",
        "Постельное белье",
        "Посуда",
        "Аксессуары",
        "Другое"
    };
}
