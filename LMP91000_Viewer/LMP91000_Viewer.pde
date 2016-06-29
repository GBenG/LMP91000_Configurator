import processing.serial.*;        //  Подключаем библиотеку работы с СОМ-портом
Serial serial_port = null;        // the serial port
 
int     n=0;                       // Позиция в буфере
int     pool=5;                    // Кол-во принимаемых байт
int[]   rxbuf = new int[pool+1];   // Массив-буфер для принятых байт
boolean recive=false;              // Статус приема
PFont   font1,font2,font3,font4;   // Шрифты
int pos;

Button btn_serial_up;
Button btn_serial_dn;
Button btn_serial_cn;

Button read;
Button write;

Button status;

Button tia_000;
Button tia_001;
Button tia_010;
Button tia_011;
Button tia_100;
Button tia_101;
Button tia_110;
Button tia_111;

Button rload_00;
Button rload_01;
Button rload_10;
Button rload_11;

Button rf_0;
Button rf_1;

Button intz_00;
Button intz_01;
Button intz_10;
Button intz_11;

Button bais_s_0;
Button bais_s_1;

Button bais_0000;
Button bais_0001;
Button bais_0010;
Button bais_0011;
Button bais_0100;
Button bais_0101;
Button bais_0110;
Button bais_0111;
Button bais_1000;
Button bais_1001;
Button bais_1010;
Button bais_1011;
Button bais_1100;
Button bais_1101;

Button fet_0;
Button fet_1;

Button mode_000;
Button mode_001;
Button mode_010;
Button mode_011;
Button mode_110;
Button mode_111;

String serial_list;                // list of serial ports
int serial_list_index = 0;         // currently selected serial port 
int num_serial_ports = 0;          // number of serial ports in the l

int marg = 45;

///////////////////////////////////////////////////////////////////////////////////////////////////////////
void setup()
{
  size( 350, 530 );                                // Размер окна Windows для отрисовки
  smooth(10);
  
  font1 = loadFont("Vrinda-Bold-12.vlw");          // Подключаем шрифт
  font2 = loadFont("Vrinda-Bold-14.vlw");          // Подключаем шрифт
  font3 = loadFont("Vrinda-Bold-16.vlw");          // Подключаем шрифт
  font4 = loadFont("IrisUPCBold-16.vlw");          // Подключаем шрифт
 
  // create the button object
  btn_serial_up = new Button(")", 63,height-18, 10, 15);
  btn_serial_dn = new Button("(", 5,height-18, 10, 15);
  btn_serial_cn = new Button("connect...", 78,height-18, 80, 15);
  
  read = new Button("READ", 18,height-50, 150, 15);
  write = new Button("WRITE", 180,height-50, 150, 15);
  
  status = new Button("", 20, 30, 10, 10);
    
  tia_000 = new Button("", 20, 85, 10, 10);
  tia_001 = new Button("", 20, 100, 10, 10);
  tia_010 = new Button("", 20, 115, 10, 10);
  tia_011 = new Button("", 20, 130, 10, 10);
  tia_100 = new Button("", 20, 145, 10, 10);
  tia_101 = new Button("", 20, 160, 10, 10);
  tia_110 = new Button("", 20, 175, 10, 10);
  tia_111 = new Button("", 20, 190, 10, 10);
  
  rload_00 = new Button("", 20, 225, 10, 10);
  rload_01 = new Button("", 20, 240, 10, 10);
  rload_10 = new Button("", 20, 255, 10, 10);
  rload_11 = new Button("", 20, 270, 10, 10);
  
  rf_0 = new Button("", 230, 45, 10, 10);
  rf_1 = new Button("", 230, 60, 10, 10);
  
  intz_00 = new Button("", 230, 90, 10, 10);
  intz_01 = new Button("", 230, 105, 10, 10);
  intz_10 = new Button("", 230, 120, 10, 10);
  intz_11 = new Button("", 230, 135, 10, 10);
  
  bais_s_0 = new Button("", 230, 170, 10, 10);
  bais_s_1 = new Button("", 230, 185, 10, 10);
  
  bais_0000 = new Button("", 230, 220, 10, 10);
  bais_0001 = new Button("", 230, 235, 10, 10);
  bais_0010 = new Button("", 230, 250, 10, 10);
  bais_0011 = new Button("", 230, 265, 10, 10);
  bais_0100 = new Button("", 230, 280, 10, 10);
  bais_0101 = new Button("", 230, 295, 10, 10);
  bais_0110 = new Button("", 230, 310, 10, 10);
  bais_0111 = new Button("", 230, 325, 10, 10);
  bais_1000 = new Button("", 230, 340, 10, 10);
  bais_1001 = new Button("", 230, 355, 10, 10);
  bais_1010 = new Button("", 230, 370, 10, 10);
  bais_1011 = new Button("", 230, 385, 10, 10);
  bais_1100 = new Button("", 230, 400, 10, 10);
  bais_1101 = new Button("", 230, 415, 10, 10);
  
  fet_0 = new Button("", 20, 330, 10, 10);
  fet_1 = new Button("", 20, 345, 10, 10);
  
  mode_000 = new Button("", 20, 380, 10, 10);
  mode_001 = new Button("", 20, 395, 10, 10);
  mode_010 = new Button("", 20, 410, 10, 10);
  mode_011 = new Button("", 20, 425, 10, 10);
  mode_110 = new Button("", 20, 440, 10, 10);
  mode_111 = new Button("", 20, 455, 10, 10);
  
  // get the list of serial ports on the computer
  serial_list = Serial.list()[serial_list_index];
  num_serial_ports = Serial.list().length;
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////
void draw()
{
 //--------------------------------------------------------------------------------------------------------------------  

 //--------------------------------------------------------------------------------------------------------------------   
  background(10);                                  // Устанавливаем цвет фона
  
  textAlign(LEFT); 
  textFont(font3,16);     
  fill(180);

  text("STATUS",10,20);
  line(10,25,100,25);  
  text("TIACN",10,60);
  line(10,65,100,65); 
  text("REFCN",220,20);
  line(220,25,300,25); 
  text("MODECN",10,300);
   line(10,305,100,305);
  
  textFont(font2,14);     
  
  text("TIA_GAIN",20,80);
  text("RLOAD",20,220);
  
  text("REF_SOURCE",230,40);
  text("INT_Z",230,86);
  text("BAIS_SIGN",230,165);
  text("BAIS",230,215);
  
  text("FET_SHORT",20,320);
  text("OP_MODE",20,375);
  
  textFont(font1,12);  
  //------------------------------------
  fill(255);
  // STATUS
  text("Ready",marg,40);
  
  // TIACN - TIA_GAIN 
  text("Ext.R",marg,95);
  text("2,75k",marg,110);
  text("3,5k",marg,125);
  text("7k",marg,140);
  text("14k",marg,155);
  text("35k",marg,170);
  text("120k",marg,185);
  text("350k",marg,200);
  
  // TIACN - RLOAD
  text("10 om",marg,235);
  text("33 om",marg,250);
  text("50 om",marg,265);
  text("100 om",marg,280);
  
  // REFCN - REF_SOURCE
  text("Internal",marg+200,55);
  text("External",marg+200,70);
  
  // RFCN - INT_Z
  text("20%",marg+200,100);
  text("50%",marg+200,115);
  text("67%",marg+200,130);
  text("Bypass",marg+200,145);
  
  // RFCN - BAIS_SIGN  
  text("Negative",marg+200,180);
  text("Positive",marg+200,195);
  
  // RFCN - BAIS
  text("0%",marg+200,230);
  text("1%",marg+200,245);
  text("2%",marg+200,260);
  text("4%",marg+200,275);
  text("6%",marg+200,290);
  text("8%",marg+200,305);
  text("10%",marg+200,320);
  text("12%",marg+200,335);
  text("14%",marg+200,350);
  text("16%",marg+200,365);
  text("18%",marg+200,380);
  text("20%",marg+200,395);
  text("22%",marg+200,410);
  text("24%",marg+200,425);
  
  text("Disabled",marg,340);
  text("Enabled",marg,355);
  
  text("Deep Sleep",marg,390);
  text("2-lead ground ref.",marg,405);
  text("Stendby",marg,420);
  text("3-lead amper. cell",marg,435);
  text("Temperature (TIA OFF)",marg,450);
  text("Temperature (TIA ON)",marg,465);
  
  fill(50);
  line(220,438,300,438);
  text(hex(rxbuf[2],2)+" TIACN",width-119,450);
  text(hex(rxbuf[3],2)+" REFCN",width-119,460);
  text(hex(rxbuf[4],2)+" MODCN",width-119,470);
  //--------------------------------------------------------------------------------------------------------------------  
  stroke(255);                                                // Отрисовываем линии разделения
  line(0,height-22,width,height-22);     

  line(195,height,215,height-22);  

  textFont(font2,14);                
  
  fill(255);  
  textAlign(RIGHT);
  text(":: SPS TECH :: 2016 ::",width-4,height-6);             // Отрисовываем логотип  

//--------------------------------------------------------------------------------------------------------------------    
    fill(200);
    noStroke();
    if (btn_serial_up.MouseIsOver()) rect(63,height-18, 10, 15,3);
    if (btn_serial_dn.MouseIsOver()) rect(5,height-18, 10, 15,3);
    if (btn_serial_cn.MouseIsOver()) rect(78,height-18, 80, 15,3);
    
    if (read.MouseIsOver()) rect(18,height-50, 150, 15,3);
    if (write.MouseIsOver()) rect(180,height-50, 150, 15,3);
    
    fill(50);
    if (serial_port != null) rect(78,height-18, 80, 15,3);

    fill(100); 
    textAlign(LEFT);
    text(serial_list,20,height-6); 
    btn_serial_up.DrawBtn(0);
    btn_serial_dn.DrawBtn(0);
    btn_serial_cn.DrawBtn(0);
    
    read.DrawBtn(0);
    write.DrawBtn(0);
    

    
//-----------------------------------------   

    if (tia_000.MouseIsOver()) rect(20, 85, 10, 10, 3);
    if (tia_001.MouseIsOver()) rect(20, 100, 10, 10, 3);
    if (tia_010.MouseIsOver()) rect(20, 115, 10, 10, 3);
    if (tia_011.MouseIsOver()) rect(20, 130, 10, 10, 3);
    if (tia_100.MouseIsOver()) rect(20, 145, 10, 10, 3);
    if (tia_101.MouseIsOver()) rect(20, 160, 10, 10, 3);
    if (tia_110.MouseIsOver()) rect(20, 175, 10, 10, 3);
    if (tia_111.MouseIsOver()) rect(20, 190, 10, 10, 3);

    if (rload_00.MouseIsOver()) rect(20, 225, 10, 10, 3);
    if (rload_01.MouseIsOver()) rect(20, 240, 10, 10, 3);
    if (rload_10.MouseIsOver()) rect(20, 255, 10, 10, 3);
    if (rload_11.MouseIsOver()) rect(20, 270, 10, 10, 3);
    
    if (rf_0.MouseIsOver()) rect(230, 45, 10, 10, 3);
    if (rf_1.MouseIsOver()) rect(230, 60, 10, 10, 3);   
  
    if (intz_00.MouseIsOver()) rect(230, 90, 10, 10, 3);
    if (intz_01.MouseIsOver()) rect(230, 105, 10, 10, 3);
    if (intz_10.MouseIsOver()) rect(230, 120, 10, 10, 3);
    if (intz_11.MouseIsOver()) rect(230, 135, 10, 10, 3);
    
    if (bais_s_0.MouseIsOver()) rect(230, 170, 10, 10, 3);
    if (bais_s_1.MouseIsOver()) rect(230, 185, 10, 10, 3);  
    
    if (bais_0000.MouseIsOver()) rect(230, 220, 10, 10, 3);  
    if (bais_0001.MouseIsOver()) rect(230, 235, 10, 10, 3);
    if (bais_0010.MouseIsOver()) rect(230, 250, 10, 10, 3);
    if (bais_0011.MouseIsOver()) rect(230, 265, 10, 10, 3);
    if (bais_0100.MouseIsOver()) rect(230, 280, 10, 10, 3);
    if (bais_0101.MouseIsOver()) rect(230, 295, 10, 10, 3);
    if (bais_0110.MouseIsOver()) rect(230, 310, 10, 10, 3);
    if (bais_0111.MouseIsOver()) rect(230, 325, 10, 10, 3);
    if (bais_1000.MouseIsOver()) rect(230, 340, 10, 10, 3);
    if (bais_1001.MouseIsOver()) rect(230, 355, 10, 10, 3);
    if (bais_1010.MouseIsOver()) rect(230, 370, 10, 10, 3);
    if (bais_1011.MouseIsOver()) rect(230, 385, 10, 10, 3);
    if (bais_1100.MouseIsOver()) rect(230, 400, 10, 10, 3);
    if (bais_1101.MouseIsOver()) rect(230, 415, 10, 10, 3);
    
    if (fet_0.MouseIsOver()) rect(20, 330, 10, 10, 3);
    if (fet_1.MouseIsOver()) rect(20, 345, 10, 10, 3);  
    
    if (mode_000.MouseIsOver()) rect(20, 380, 10, 10, 3);
    if (mode_001.MouseIsOver()) rect(20, 395, 10, 10, 3);
    if (mode_010.MouseIsOver()) rect(20, 410, 10, 10, 3);
    if (mode_011.MouseIsOver()) rect(20, 425, 10, 10, 3);
    if (mode_110.MouseIsOver()) rect(20, 440, 10, 10, 3);
    if (mode_111.MouseIsOver()) rect(20, 455, 10, 10, 3);
    
//**********************************************************//
    status.DrawBtn(rxbuf[1] & 0x1);
//**********************************************************//
     pos = (rxbuf[2] & 0x1C) >> 2;
     switch (pos){
       case 0x0: tia_000.DrawBtn(255);  break;
       case 0x1: tia_001.DrawBtn(255);  break;
       case 0x2: tia_010.DrawBtn(255);  break;
       case 0x3: tia_011.DrawBtn(255);  break;
       case 0x4: tia_100.DrawBtn(255);  break;
       case 0x5: tia_101.DrawBtn(255);  break;
       case 0x6: tia_110.DrawBtn(255);  break;
       case 0x7: tia_111.DrawBtn(255);  break;
    }
      tia_000.DrawBtn(0);
      tia_001.DrawBtn(0);
      tia_010.DrawBtn(0);
      tia_011.DrawBtn(0);
      tia_100.DrawBtn(0);
      tia_101.DrawBtn(0);
      tia_110.DrawBtn(0);
      tia_111.DrawBtn(0);
//**********************************************************//
    pos = (rxbuf[2] & 0x03);
    switch (pos){
      case 0x0: rload_00.DrawBtn(255);break;
      case 0x1: rload_01.DrawBtn(255);break;
      case 0x2: rload_10.DrawBtn(255);break;
      case 0x3: rload_11.DrawBtn(255);break;
    }
    rload_00.DrawBtn(0);
    rload_01.DrawBtn(0);
    rload_10.DrawBtn(0);
    rload_11.DrawBtn(0);
//**********************************************************//
    pos = (rxbuf[3] & 0x80) >> 7;
    switch (pos){
      case 0x0: rf_0.DrawBtn(255);break;
      case 0x1: rf_1.DrawBtn(255);break;
    }
    rf_0.DrawBtn(0);
    rf_1.DrawBtn(0);
//**********************************************************// 
    pos = (rxbuf[3] & 0x60) >> 5;
    switch (pos){
      case 0x0: intz_00.DrawBtn(255);break;
      case 0x1: intz_01.DrawBtn(255);break;
      case 0x2: intz_10.DrawBtn(255);break;
      case 0x3: intz_11.DrawBtn(255);break;
    }
    intz_00.DrawBtn(0);
    intz_01.DrawBtn(0);
    intz_10.DrawBtn(0);
    intz_11.DrawBtn(0);
//**********************************************************//  
    pos = (rxbuf[3] & 0x10) >> 4;
    switch (pos){
      case 0x0: bais_s_0.DrawBtn(255);break;
      case 0x1: bais_s_1.DrawBtn(255);break;
    }
    bais_s_0.DrawBtn(0);
    bais_s_1.DrawBtn(0);
//**********************************************************// 
    pos = (rxbuf[3] & 0xF);
    switch (pos){
      case 0x0: bais_0000.DrawBtn(255);break;
      case 0x1: bais_0001.DrawBtn(255);break;
      case 0x2: bais_0010.DrawBtn(255);break;
      case 0x3: bais_0011.DrawBtn(255);break;
      case 0x4: bais_0100.DrawBtn(255);break;
      case 0x5: bais_0101.DrawBtn(255);break;
      case 0x6: bais_0110.DrawBtn(255);break;
      case 0x7: bais_0111.DrawBtn(255);break;
      case 0x8: bais_1000.DrawBtn(255);break;
      case 0x9: bais_1001.DrawBtn(255);break;
      case 0xA: bais_1010.DrawBtn(255);break;
      case 0xB: bais_1011.DrawBtn(255);break;
      case 0xC: bais_1100.DrawBtn(255);break;
      case 0xD: bais_1101.DrawBtn(255);break;
    }
    bais_0000.DrawBtn(0);
    bais_0001.DrawBtn(0);
    bais_0010.DrawBtn(0);
    bais_0011.DrawBtn(0);
    bais_0100.DrawBtn(0);
    bais_0101.DrawBtn(0);
    bais_0110.DrawBtn(0);
    bais_0111.DrawBtn(0);
    bais_1000.DrawBtn(0);
    bais_1001.DrawBtn(0);
    bais_1010.DrawBtn(0);
    bais_1011.DrawBtn(0);
    bais_1100.DrawBtn(0);
    bais_1101.DrawBtn(0);
//**********************************************************// 
    pos = (rxbuf[4] & 0x80)>>7;
    switch (pos){
      case 0x0: fet_0.DrawBtn(255);break;
      case 0x1: fet_1.DrawBtn(255);break;
    }
    fet_0.DrawBtn(0);
    fet_1.DrawBtn(0);
//**********************************************************//  
    pos = (rxbuf[4] & 0x07);
    switch (pos){
      case 0x0: mode_000.DrawBtn(255);break;
      case 0x1: mode_001.DrawBtn(255);break;
      case 0x2: mode_010.DrawBtn(255);break;
      case 0x3: mode_011.DrawBtn(255);break;
      case 0x6: mode_110.DrawBtn(255);break;
      case 0x7: mode_111.DrawBtn(255);break;
    }
    mode_000.DrawBtn(0);
    mode_001.DrawBtn(0);
    mode_010.DrawBtn(0);
    mode_011.DrawBtn(0);
    mode_110.DrawBtn(0);
    mode_111.DrawBtn(0);
//**********************************************************//
    fill(255);
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////
void serialEvent(Serial p)
{
  if(!recive){
    if(p.read()==0xFE){                            // Сравниваем с "ключем" начала передачи. 
      recive = true;                               // Статус - прием активный
    }
  }else{                                           // (0х41 я выбрал от фанаря)
   if(n<pool){n++;}else{n=0;recive=false;}         // Если передача начата и мы еще не все выгребли
   rxbuf[n] = p.read();                            // Считываем принятый байт из порта
  }
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////
void numeric(int xsh, int ysh)
{
  int xmr=15;
  for(int i=7;i>=0;i--)
  {
  text(i,xsh-i*xmr,ysh); 
  }
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////
// the Button class
class Button {
  String label; // button label
  float x;      // top left corner x position
  float y;      // top left corner y position
  float w;      // width of button
  float h;      // height of button
  
  // constructor
  Button(String labelB, float xpos, float ypos, float widthB, float heightB) {
    label = labelB;
    x = xpos;
    y = ypos;
    w = widthB;
    h = heightB;
  }

  void DrawBtn(int fill) {
    if(fill!=0)fill = 100;
    fill(255,255,255,fill);
    stroke(141);
    rect(x, y, w, h, 3);
    textAlign(CENTER, CENTER);
    fill(100);
    textFont(font3,16);
    text(label, x + (w / 2), y + (h / 2));
  }
  
  boolean MouseIsOver() {
    if (mouseX > x && mouseX < (x + w) && mouseY > y && mouseY < (y + h)) {
      return true;
    }
    return false;
  }
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////
// mouse button clicked
void mousePressed()
{
  if (btn_serial_up.MouseIsOver()){
    if (serial_list_index < (num_serial_ports - 1)) {
      // move one position down in the list of serial ports
      serial_list_index++;
      serial_list = Serial.list()[serial_list_index];
    }
  }
  if (btn_serial_dn.MouseIsOver()){
    if (serial_list_index > 0) {
      // move one position up in the list of serial ports
      serial_list_index--;
      serial_list = Serial.list()[serial_list_index];
    }
  }
  if (btn_serial_cn.MouseIsOver()){
     if (serial_port == null) {
      // connect to the selected serial port
      serial_port = new Serial(this, Serial.list()[serial_list_index], 9600);
    }
  }
  
  if (read.MouseIsOver()){
      serial_port.write(65);
  }
  
  if (write.MouseIsOver()){
      serial_port.write(83);
      delay(500);
      serial_port.write(65);
      delay(100);
      serial_port.write(65);
  }
//**********************************************************************************//
  if (tia_000.MouseIsOver()){rxbuf[2] &= ~0x1C;}
  if (tia_001.MouseIsOver()){rxbuf[2] &= ~0x1C; rxbuf[2] |= 0x1<<2;}
  if (tia_010.MouseIsOver()){rxbuf[2] &= ~0x1C; rxbuf[2] |= 0x2<<2;}
  if (tia_011.MouseIsOver()){rxbuf[2] &= ~0x1C; rxbuf[2] |= 0x3<<2;}
  if (tia_100.MouseIsOver()){rxbuf[2] &= ~0x1C; rxbuf[2] |= 0x4<<2;}
  if (tia_101.MouseIsOver()){rxbuf[2] &= ~0x1C; rxbuf[2] |= 0x5<<2;}
  if (tia_110.MouseIsOver()){rxbuf[2] &= ~0x1C; rxbuf[2] |= 0x6<<2;}
  if (tia_111.MouseIsOver()){rxbuf[2] &= ~0x1C; rxbuf[2] |= 0x7<<2;}
  
  if (rload_00.MouseIsOver()){rxbuf[2] &= ~0x03;}
  if (rload_01.MouseIsOver()){rxbuf[2] &= ~0x03; rxbuf[2] |= 0x1;}
  if (rload_10.MouseIsOver()){rxbuf[2] &= ~0x03; rxbuf[2] |= 0x2;}
  if (rload_11.MouseIsOver()){rxbuf[2] &= ~0x03; rxbuf[2] |= 0x3;}

  if (rf_0.MouseIsOver()){rxbuf[3] &= ~0x80;}
  if (rf_1.MouseIsOver()){rxbuf[3] |= 0x80;}
  
  if (intz_00.MouseIsOver()){rxbuf[3] &= ~0x60;}
  if (intz_01.MouseIsOver()){rxbuf[3] &= ~0x60; rxbuf[3] |= 0x1<<5;}
  if (intz_10.MouseIsOver()){rxbuf[3] &= ~0x60; rxbuf[3] |= 0x2<<5;}
  if (intz_11.MouseIsOver()){rxbuf[3] &= ~0x60; rxbuf[3] |= 0x3<<5;}
  
  if (bais_s_0.MouseIsOver()){rxbuf[3] &= ~0x10;}
  if (bais_s_1.MouseIsOver()){rxbuf[3] |= 0x10;}

  if (bais_0000.MouseIsOver()){rxbuf[3] &= ~0xF;}
  if (bais_0001.MouseIsOver()){rxbuf[3] &= ~0xF; rxbuf[3] |= 0x1;}
  if (bais_0010.MouseIsOver()){rxbuf[3] &= ~0xF; rxbuf[3] |= 0x2;}
  if (bais_0011.MouseIsOver()){rxbuf[3] &= ~0xF; rxbuf[3] |= 0x3;}
  if (bais_0100.MouseIsOver()){rxbuf[3] &= ~0xF; rxbuf[3] |= 0x4;}
  if (bais_0101.MouseIsOver()){rxbuf[3] &= ~0xF; rxbuf[3] |= 0x5;}
  if (bais_0110.MouseIsOver()){rxbuf[3] &= ~0xF; rxbuf[3] |= 0x6;}
  if (bais_0111.MouseIsOver()){rxbuf[3] &= ~0xF; rxbuf[3] |= 0x7;}
  if (bais_1000.MouseIsOver()){rxbuf[3] &= ~0xF; rxbuf[3] |= 0x8;}
  if (bais_1001.MouseIsOver()){rxbuf[3] &= ~0xF; rxbuf[3] |= 0x9;}
  if (bais_1010.MouseIsOver()){rxbuf[3] &= ~0xF; rxbuf[3] |= 0xA;}
  if (bais_1011.MouseIsOver()){rxbuf[3] &= ~0xF; rxbuf[3] |= 0xB;}
  if (bais_1100.MouseIsOver()){rxbuf[3] &= ~0xF; rxbuf[3] |= 0xC;}
  if (bais_1101.MouseIsOver()){rxbuf[3] &= ~0xF; rxbuf[3] |= 0xD;}
  
  if (fet_0.MouseIsOver()){rxbuf[4] &= ~0x80;}
  if (fet_1.MouseIsOver()){rxbuf[4] |= 0x80;}
  
  if (mode_000.MouseIsOver()){rxbuf[4] &= ~0x07;}
  if (mode_001.MouseIsOver()){rxbuf[4] &= ~0x07; rxbuf[4] |= 0x1;}
  if (mode_010.MouseIsOver()){rxbuf[4] &= ~0x07; rxbuf[4] |= 0x2;}
  if (mode_011.MouseIsOver()){rxbuf[4] &= ~0x07; rxbuf[4] |= 0x3;}
  if (mode_110.MouseIsOver()){rxbuf[4] &= ~0x07; rxbuf[4] |= 0x6;}
  if (mode_111.MouseIsOver()){rxbuf[4] &= ~0x07; rxbuf[4] |= 0x7;}
/*
  pos = (rxbuf[4] & 0x07);

Button mode_000;
Button mode_001;
Button mode_010;
Button mode_011;
Button mode_110;
Button mode_111;
*/
}