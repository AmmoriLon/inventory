#ifndef INVENTORYMANAGER_H
#define INVENTORYMANAGER_H

#include <QObject>
#include <QVector>
#include <QString>
#include <QVariantList>
#include "item.h"

class InventoryManager : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int totalItems READ totalItems NOTIFY totalItemsChanged)
    Q_PROPERTY(QVariantList items READ items NOTIFY itemsChanged)

public:
    static InventoryManager& instance();

    explicit InventoryManager(QObject *parent = nullptr);
    ~InventoryManager();

    int totalItems() const { return m_items.size(); }
    QVariantList items() const;

    Q_INVOKABLE void addItem(const QString& name, const QString& category,
                           int quantity, const QString& description = "",
                           const QString& imagePath = "");
    Q_INVOKABLE void removeItem(int index);
    Q_INVOKABLE void updateItem(int index, const QString& name, const QString& category,
                              int quantity, const QString& description, const QString& imagePath);
    Q_INVOKABLE Item* getItem(int index);

    Q_INVOKABLE QStringList getCategories() const;

signals:
    void itemsChanged();
    void totalItemsChanged();

private:
    QVector<Item*> m_items;
};

#endif // INVENTORYMANAGER_H
