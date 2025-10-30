// ItemModel.cpp
#include "ItemModel.h"
#include <QFile>
#include <QJsonDocument>
#include <QJsonArray>
#include <QJsonObject>
#include <QDebug>

ItemModel::ItemModel(QObject *parent)
    : QAbstractListModel(parent)
{
}

int ItemModel::rowCount(const QModelIndex &) const
{
    return m_items.size();
}

QVariant ItemModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid() || index.row() >= m_items.size())
        return QVariant();

    const InventoryItem &item = m_items[index.row()];

    switch (role) {
    case NameRole: return item.name;
    case QuantityRole: return item.quantity;
    case CategoryRole: return item.category;
    case NoteRole: return item.note;
    case ImagePathRole: return item.imagePath;
    default: return QVariant();
    }
}

QHash<int, QByteArray> ItemModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[NameRole] = "name";
    roles[QuantityRole] = "quantity";
    roles[CategoryRole] = "category";
    roles[NoteRole] = "note";
    roles[ImagePathRole] = "imagePath";
    return roles;
}

void ItemModel::addItem(const QString &name, int quantity,
                        const QString &category, const QString &note,
                        const QString &imagePath)
{
    beginInsertRows(QModelIndex(), m_items.size(), m_items.size());
    InventoryItem item;
    item.name = name;
    item.quantity = quantity;
    item.category = category;
    item.note = note;
    item.imagePath = imagePath;
    m_items.append(item);
    endInsertRows();
}

void ItemModel::removeItem(int index)
{
    if (index < 0 || index >= m_items.size()) return;
    beginRemoveRows(QModelIndex(), index, index);
    m_items.removeAt(index);
    endRemoveRows();
}

void ItemModel::saveToFile(const QString &filePath)
{
    QJsonArray array;
    for (const auto &item : m_items) {
        QJsonObject obj;
        obj["name"] = item.name;
        obj["quantity"] = item.quantity;
        obj["category"] = item.category;
        obj["note"] = item.note;
        obj["imagePath"] = item.imagePath;
        array.append(obj);
    }

    QFile file(filePath);
    if (file.open(QIODevice::WriteOnly)) {
        file.write(QJsonDocument(array).toJson());
        file.close();
    }
}

void ItemModel::loadFromFile(const QString &filePath)
{
    QFile file(filePath);
    if (!file.exists()) return;

    if (file.open(QIODevice::ReadOnly)) {
        QJsonDocument doc = QJsonDocument::fromJson(file.readAll());
        QJsonArray array = doc.array();

        beginResetModel();
        m_items.clear();
        for (const auto &value : array) {
            QJsonObject obj = value.toObject();
            InventoryItem item;
            item.name = obj["name"].toString();
            item.quantity = obj["quantity"].toInt();
            item.category = obj["category"].toString();
            item.note = obj["note"].toString();
            item.imagePath = obj["imagePath"].toString();
            m_items.append(item);
        }
        endResetModel();
        file.close();
    }
}
