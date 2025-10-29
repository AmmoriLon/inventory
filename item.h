#ifndef ITEM_H
#define ITEM_H

#include <QObject>
#include <QString>

class Item : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString name READ getName WRITE setName NOTIFY nameChanged)
    Q_PROPERTY(QString category READ getCategory WRITE setCategory NOTIFY categoryChanged)
    Q_PROPERTY(int quantity READ getQuantity WRITE setQuantity NOTIFY quantityChanged)
    Q_PROPERTY(QString description READ getDescription WRITE setDescription NOTIFY descriptionChanged)
    Q_PROPERTY(QString imagePath READ getImagePath WRITE setImagePath NOTIFY imagePathChanged)

public:
    explicit Item(QObject *parent = nullptr);
    Item(const QString& name, const QString& category, int quantity, QObject *parent = nullptr);

    QString getName() const { return m_name; }
    QString getCategory() const { return m_category; }
    int getQuantity() const { return m_quantity; }
    QString getDescription() const { return m_description; }
    QString getImagePath() const { return m_imagePath; }

    void setName(const QString& name);
    void setCategory(const QString& category);
    void setQuantity(int quantity);
    void setDescription(const QString& desc);
    void setImagePath(const QString& path);

signals:
    void nameChanged();
    void categoryChanged();
    void quantityChanged();
    void descriptionChanged();
    void imagePathChanged();

private:
    QString m_name;
    QString m_category;
    int m_quantity;
    QString m_description;
    QString m_imagePath;
};

#endif // ITEM_H
