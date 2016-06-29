#include <Wire.h>
#include "LMP91000.h"

LMP91000 lmp91000;
uint8_t res;
int inb;

void setup(void){
      Serial.begin(9600);
      Serial.println("LMP91000 Test");
      Wire.begin();
      
      res = lmp91000.configure( 
            LMP91000_TIA_GAIN_120K | LMP91000_RLOAD_100OHM,
            LMP91000_REF_SOURCE_EXT | LMP91000_INT_Z_67PCT | LMP91000_BIAS_SIGN_POS | LMP91000_BIAS_1PCT,
            LMP91000_FET_SHORT_DISABLED | LMP91000_OP_MODE_AMPEROMETRIC                  
      );
      
      Serial.print("Config Result: ");
      Serial.println(res);      
     
}

void loop(void){
      if (Serial.available() > 0) {  //если есть доступные данные
        inb = Serial.read();
        
        if(inb == 65){
            Serial.write(0xFE);
            //Serial.print("STATUS: ");
            Serial.write(lmp91000.read(LMP91000_STATUS_REG));
            //Serial.print("TIACN: ");
            Serial.write(lmp91000.read(LMP91000_TIACN_REG));
            //Serial.print("REFCN: ");
            Serial.write(lmp91000.read(LMP91000_REFCN_REG));
            //Serial.print("MODECN: ");
            Serial.write(lmp91000.read(LMP91000_MODECN_REG)); 
            inb=0;
        }else if(inb == 83)
          {
            // пишем данные
            res = lmp91000.configure( 
                LMP91000_TIA_GAIN_14K | LMP91000_RLOAD_33OHM,
                LMP91000_REF_SOURCE_INT | LMP91000_INT_Z_20PCT | LMP91000_BIAS_SIGN_NEG | LMP91000_BIAS_4PCT,
                LMP91000_FET_SHORT_ENABLED | LMP91000_OP_MODE_TIA_OFF                  
            );
          }else{inb=0;}
      }
      delay(100); 
}
