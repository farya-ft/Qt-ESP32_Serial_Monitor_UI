#ifndef SERIALREADER_H
#define SERIALREADER_H

#include <QObject>
#include <QSerialPort>

class SerialReader : public QObject
{
    Q_OBJECT
public:
    explicit SerialReader(QObject *parent = nullptr);
    Q_INVOKABLE void start(const QString &portName);

signals:
    void newDataReceived(const QString &data);

private slots:
    void handleReadyRead();

private:
    QSerialPort *serial;
    QByteArray buffer;
};

#endif // SERIALREADER_H