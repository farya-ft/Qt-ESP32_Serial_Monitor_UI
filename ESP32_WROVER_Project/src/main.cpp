#include <Arduino.h>

void setup() {
  Serial.begin(115200);
}

void loop() {
  float temp = random(200, 350) / 10.0; // random fake temp between 20.0 to 35.0
  Serial.print("Temp: ");
  Serial.println(temp);
  delay(1000);
}
