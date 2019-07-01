#include <NTPClient.h>
#include "DHT.h"        // Sensor lib

#define Show(name,value) Serial.print(name); Serial.println(value);
#define DHTPIN D2         // Sensor pin
#define DHTTYPE DHT11     // Sensor type

// Internet variables
NTPtime NTPbr("br.pool.ntp.org");   // Choose server pool as required
char *ssid = "aula-ic3";            // Set you WiFi SSID
char *password  = "iotic@2019";     // Set you WiFi password

// Setting DHT sensor
DHT dht(DHTPIN, DHTTYPE);

// Variables for reading date and sensors
byte hour;
byte minute;
byte sec;
int year;
byte month;
byte day;
byte dayofWeek;
byte humidity;
byte temperature;
short int luminosity;

/********** BASIC FUNCTIONS **********/

// Displays obtained variables for record i
void printSensorsData() {
    // Printing date
    Serial.print("Date: ");
    Serial.print(hour);
    Serial.print(":");
    Serial.print(minute);
    Serial.print(":");
    Serial.print(sec);
    Serial.print(" - ");
    Serial.print(day);
    Serial.print("/");
    Serial.print(month);
    Serial.print("/");
    Serial.print(year);

    // Printing sensors data
    Serial.print("temperature: ");
    Serial.print(temperature);
    Serial.print(", humidity: ");
    Serial.print(humidity);
    Serial.print(", luminosity: ");
    Serial.println(luminosity);
    Serial.println();

    yield();
}

// Connects to Wi-Fi
void connectToWiFi() {
    Show("Connecting to Wi-Fi ", ssid);
    WiFi.mode(WIFI_STA);
    WiFi.begin (ssid, password);
    while (WiFi.status() != WL_CONNECTED) {
        Serial.print(".");
        delay(500);
    }
    Serial.println("WiFi connected\n");
}

// Returns current dateTime
strDateTime getDateTime() {
    strDateTime dateTime;
    int maxConnectionTrials = 10;

    Serial.println("Getting date-time");

    for (i = 1; i <= maxConnectionTrials; i++) {
        // Getting dateTime for Brasilia UTC
        dateTime = NTPbr.getNTPtime(-3.0, 0);  
        delay(1000);

        if (dateTime.valid) {
            NTPbr.printDateTime(dateTime);
            return dateTime;
        }

        Serial.print("*"); //max 10 trials
    }

    return NULL;
}

void setSensorsData() {
    // Setting dateTime variablies
    strDateTime dateTime = getDateTime();

    if (dateTime == NULL) {
        Serial.print("ERROR: Couldn't get date-time");
        hour = minute = sec = day = dayofWeek = month = year = 0;
    } else {
        hour = dateTime.hour;
        minute = dateTime.minute;
        sec = dateTime.second;
        day = dateTime.day;
        dayofWeek = dateTime.dayofWeek;
        month = dateTime.month;
        year = dateTime.year;
        //Show("Current year= ", year);  //DEBUG
    }

    // Setting sensors variables
    humidity = dht.readHumidity();
    temperature = dht.readTemperature();
    luminosity = analogRead(A0);
}

void setup() {
    Serial.begin(115200);
    delay(10);
    Serial.println("-- Booted --");

    connectToWifi();
    setSensorsData();
    printSensorsData();
    Serial.println("Sending data to Firebase\n");    
    // sendDataToFirebase(data); - só falta isso

    Serial.println("Delaying 1 sec before deep sleep\n");
    delay(1 * 1000); // in milliseconds
    Serial.println("Deep sleep for 1 min\n");
    ESP.deepSleep(60 * 1000000, WAKE_RFCAL); // in microseconds
}

void loop() {



    Serial.println("Delaying 30 sec\n");
    delay(30 * 1000); // in milliseconds
}
