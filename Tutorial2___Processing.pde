import processing.serial.*;
import cc.arduino.*;

import eeml.*;

Arduino arduino;
float myValue;
float lastUpdate;

DataOut dOut;

void setup()
{
  println(Arduino.list());
  arduino = new Arduino(this, Arduino.list()[0], 57600);

  dOut = new DataOut(this, "http://www.pachube.com/api/35134.xml", "API Key"); 

  dOut.addData(0,"test, lightSensor");

}

void draw()
{
if ((millis() - lastUpdate) > 10000){
        myValue = arduino.analogRead(0);
        println(myValue);      
        println("ready to PUT: ");
        dOut.update(0, myValue);
        int response = dOut.updatePachube();
        println(response);
        lastUpdate = millis();
}   
      
}
