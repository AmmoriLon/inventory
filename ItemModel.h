// ItemModel.h
#ifndef ITEMMODEL_H
#define ITEMMODEL_H

#include <QAbstractListModel>
#include <QVariant>

struct InventoryItem {
    QString name;
    int quantity;
    QString category;
    QString note;
    QString imagePath;
};

class ItemModel : public QAbstractListModel
{
    Q_OBJECT

public:
    enum ItemRoles {
        NameRole = Qt::UserRole + 1,
        QuantityRole,
        CategoryRole,
        NoteRole,
        ImagePathRole
    };

    explicit ItemModel(QObject *parent = nullptr);

    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    QHash<int, QByteArray> roleNames() const override;

    Q_INVOKABLE void addItem(const QString &name, int quantity,
                             const QString &category, const QString &note,
                             const QString &imagePath = "");
    Q_INVOKABLE void removeItem(int index);
    Q_INVOKABLE void saveToFile(const QString &filePath);
    Q_INVOKABLE void loadFromFile(const QString &filePath);

private:
    QList<InventoryItem> m_items;
    QStringList m_categories = {
        "Верхняя одежда", "Средний слой", "Нижняя одежда",
        "Бельё", "Постельное бельё", "Посуда",
        "Гигиена", "Безделушки", "Другое"
    };
};

#endif // ITEMMODEL_H
