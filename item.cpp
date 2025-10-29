#include "item.h"

Item::Item(QObject *parent)
    : QObject(parent)
    , m_quantity(1)
{
}

Item::Item(const QString& name, const QString& category, int quantity, QObject *parent)
    : QObject(parent)
    , m_name(name)
    , m_category(category)
    , m_quantity(quantity)
{
}

void Item::setName(const QString& name)
{
    if (m_name != name) {
        m_name = name;
        emit nameChanged();
    }
}

void Item::setCategory(const QString& category)
{
    if (m_category != category) {
        m_category = category;
        emit categoryChanged();
    }
}

void Item::setQuantity(int quantity)
{
    if (m_quantity != quantity) {
        m_quantity = quantity;
        emit quantityChanged();
    }
}

void Item::setDescription(const QString& desc)
{
    if (m_description != desc) {
        m_description = desc;
        emit descriptionChanged();
    }
}

void Item::setImagePath(const QString& path)
{
    if (m_imagePath != path) {
        m_imagePath = path;
        emit imagePathChanged();
    }
}
