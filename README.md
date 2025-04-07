# 🔌 Qt + ESP32 Serial Monitor UI

A modern Qt Quick (QML) based user interface that connects to an ESP32 over serial (UART), reads incoming data, and displays it in a clean, animated UI. Ideal for real-time monitoring of sensors or other microcontroller outputs.

---

## 🎯 Features

- ✅ Live connection to an ESP32 board over USB
- 🌡️ Real-time display of sensor (temperature) values
- 🎨 Custom animated UI (dark theme)
- 📤 Button to trigger commands to ESP32 (e.g., `LED_ON`, `LED_OFF`)
- ⚙️ C++ backend handling serial communication and signal-slot
- 🔄 Bi-directional communication setup

---

## 🧰 Stack

| Layer         | Tech Used          |
|---------------|--------------------|
| **Frontend**  | QML / Qt Quick     |
| **Backend**   | Qt C++ (QObject)   |
| **Hardware**  | ESP32 (Arduino FW) |
| **Comm**      | Serial (USB UART)  |

---

## 🚀 How It Works

1. **ESP32** sends mock sensor data via `Serial.println()`.
2. **Qt App (C++)** reads this data using `QSerialPort`.
3. The received value is passed to **QML frontend** using a signal.
4. The UI displays the data, with color and animation.
5. A button allows the user to send commands (e.g. `LED_ON`) back to the board.

---

## 📦 Folder Structure

```bash
📁 ledControlEsp32
├── qml/
│   └── main.qml            # UI layout & animations
├── src/
│   ├── serialreader.h      # C++ class for QSerialPort
│   └── serialreader.cpp
├── CMakeLists.txt          # Build configuration
├── main.cpp                # App entry point
├── platformio/             # Optional ESP32 firmware
│   └── src/main.cpp        # Arduino code
```

---

## 🛠 Requirements

- **Qt 6.6+** (w/ QtSerialPort module)
- **CMake + Ninja**
- **PlatformIO** *(optional for firmware)*
- ESP32 Dev Board
- USB to Serial cable / driver

---

## 💻 Build Instructions (Qt App)

```bash
# inside your project folder:
mkdir build && cd build
cmake .. -DCMAKE_PREFIX_PATH=/path/to/Qt/6.x.x/macos/lib/cmake
cmake --build .
./MyApp
```

Replace `/dev/tty.usbserial-XXX` in QML with your port.

---

## 🔧 Upload Firmware to ESP32

```bash
cd platformio
pio run --target upload
```

Sample Arduino code is included to simulate temperature and respond to commands.

---

## 📸 Screenshots

You can also include `.mov` preview (upload with GitHub's video support or convert to gif and embed).

---

## ✨ Roadmap

- [x] Serial read + parse
- [x] Animated QML display
- [x] One-way commands (`LED_ON`, `LED_OFF`)
- [ ] Bi-directional interaction
- [ ] Bluetooth integration
- [ ] Sensor graph over time

---

## 🧑‍💻 Author

**Farya Farhang**  
Passionate about embedded UI, real-time data apps & bridging hardware with software.

---

## 📮 License

MIT — use it, build on it, and share what you create 🙌

---

## 📎 Tags

`#Qt` `#QML` `#ESP32` `#SerialCommunication` `#EmbeddedUI` `#IoT` `#WomenInTech`
