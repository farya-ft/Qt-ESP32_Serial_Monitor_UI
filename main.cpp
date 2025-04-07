
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QQuickStyle>
#include "serialreader.h"

int main(int argc, char *argv[])
{
    QQuickStyle::setStyle("Fusion");

    QGuiApplication app(argc, argv);
    QQuickStyle::setStyle("Material");
    QQmlApplicationEngine engine;

    SerialReader reader;
    engine.rootContext()->setContextProperty("serialReader", &reader);

    const QUrl url(u"qrc:/qml/main.qml"_qs);
    engine.load(url);

    return app.exec();
}
