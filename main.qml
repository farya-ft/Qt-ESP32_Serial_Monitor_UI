import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

ApplicationWindow {
    visible: true
    width: 400
    height: 500
    title: "ESP32 Monitor"
    color: "#1E1E1E"

    property bool isConnected: false
    property string tempState: "normal" // حالت متنی برای انیمیشن

    Rectangle {
        width: 320
        height: 450
        radius: 24
        color: "#2B2B2B"
        border.color: "#444"
        border.width: 1
        anchors.centerIn: parent

        Column {
            anchors.fill: parent
            anchors.margins: 24
            spacing: 24

            Text {
                text: "🌈 Magic Sensor Panel"
                font.pixelSize: 22
                font.bold: true
                color: "#C5CAE9"
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Rectangle {
                width: parent.width
                height: 100
                radius: 20
                color: "#37474F"

                Text {
                    id: tempText
                    anchors.centerIn: parent
                    text: "🌡️ Temp: -- °C"
                    font.pixelSize: 24
                    color: "#E3F2FD"
                }

                // حالت‌ها برای انیمیشن متن
                states: [
                    State {
                        name: "normal"
                        PropertyChanges {
                            target: tempText
                            font.pixelSize: 24
                            color: "#E3F2FD"
                        }
                    },
                    State {
                        name: "cool"
                        PropertyChanges {
                            target: tempText
                            font.pixelSize: 26
                            color: "#2196f3" // blue
                        }
                    },
                    State {
                        name: "warm"
                        PropertyChanges {
                            target: tempText
                            font.pixelSize: 26
                            color: "#43a047" // green
                        }
                    },
                    State {
                        name: "hot"
                        PropertyChanges {
                            target: tempText
                            font.pixelSize: 28
                            color: "#e53935" // red
                        }
                    }
                ]

                // انیمیشن بین حالت‌ها
                transitions: [
                    Transition {
                        NumberAnimation { properties: "font.pixelSize,color"; duration: 300; easing.type: Easing.InOutQuad }
                    }
                ]
            }

            Button {
                id: connectButton
                width: 250
                height: 48
                anchors.horizontalCenter: parent.horizontalCenter
                scale: 1.0

                background: Rectangle {
                    color: isConnected ? "#66bb6a" : "#ba68c8"
                    radius: 24
                }

                contentItem: Text {
                    text: isConnected ? "Connected 🔗" : "Connect to ESP32 ✨"
                    anchors.centerIn: parent
                    color: "white"
                    font.pixelSize: 16
                    font.bold: true
                }

                onClicked: {
                    if (!isConnected) {
                        serialReader.start("/dev/tty.usbserial-210")
                        isConnected = true
                        connectAnim.running = true
                    }
                }

                SequentialAnimation on scale {
                    id: connectAnim
                    running: false
                    PropertyAnimation { to: 0.9; duration: 100 }
                    PropertyAnimation { to: 1.0; duration: 100 }
                }
            }

            Image {
               source: "images/example.png"
                width: 64
                height: 64
                anchors.horizontalCenter: parent.horizontalCenter
                fillMode: Image.PreserveAspectFit
                onStatusChanged: {
                    if (status === Image.Error) {
                        console.log("❌ Image load failed:", source)
                    }
                }
            }
        }

        // ارتباط با C++ برای دریافت داده
        Connections {
            target: serialReader
            function onNewDataReceived(data) {
                tempText.text = "🌡️ " + data + " °C"
                let temp = parseFloat(data)
                if (temp < 25) {
                    tempState = "cool"
                } else if (temp < 30) {
                    tempState = "warm"
                } else {
                    tempState = "hot"
                }
            }
        }

        // وصل کردن state به tempText
        Component.onCompleted: tempText.state = tempState
       
    }
}