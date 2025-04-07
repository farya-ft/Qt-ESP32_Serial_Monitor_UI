#include "serialreader.h"
#include <QDebug>

SerialReader::SerialReader(QObject *parent) : QObject(parent)
{
    serial = new QSerialPort(this);
    connect(serial, &QSerialPort::readyRead, this, &SerialReader::handleReadyRead);
}

void SerialReader::start(const QString &portName)
{
    serial->setPortName(portName);
    serial->setBaudRate(QSerialPort::Baud115200);
    serial->setDataBits(QSerialPort::Data8);
    serial->setParity(QSerialPort::NoParity);
    serial->setStopBits(QSerialPort::OneStop);
    serial->setFlowControl(QSerialPort::NoFlowControl);
    qDebug() << "Trying to open port:" << serial->portName();
    if (serial->open(QIODevice::ReadOnly)) {
        qDebug() << "✅ Serial port opened.";
    } else {
        qDebug() << "❌ Failed to open port:" << serial->errorString();
    }
}

void SerialReader::handleReadyRead()
{
    buffer.append(serial->readAll());
    if (buffer.contains('\n')) {
        QList<QByteArray> lines = buffer.split('\n');
        for (int i = 0; i < lines.size() - 1; ++i) {
            emit newDataReceived(QString::fromUtf8(lines[i]).trimmed());
        }
        buffer = lines.last(); // ذخیره‌ی خط ناقص برای بعدی
    }
}