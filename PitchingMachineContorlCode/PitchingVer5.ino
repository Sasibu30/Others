#include <PWM.h>

float ch;

//주파수 설정
int frequency = 10000; //Hz

// 초기 회로 포트 번호 설정
int Speed_Out = 4;  //6~9까지는 차례대로 속도제어 포트

// 모터 회로
float velocity = 0;
float velocity1[5] = {0.0,0.0,0.0,0.0,0.0};
float Ana; // 시리얼 모니어 아날로그 입력값
int power;
int GNo = 1; // 일반 드라이버 사용 모터 번호

// 제어 변수
int No; // 모터 번호
char CMD; // 명령어
int MA; // -> 수동 = 1 or 자동 = 2 or 각도 제어 = 3
int check = 0; 
int dl = 500; // delay 시간
int lp = 0;
// 투구 변수
int Ratio; //
int FF; // -> 3/4:1 or 언더:2 
float rateV[5] = {0.0, 0.0, 0.0, 0.0, 0.0};

//각도 변수
float Angle = 0.0;
float NewAngle;
float DeltaAngle;
float AngleVel;
float Time;

//////////////////////////////////////////////////////////////////////////////////////////
////////////////////// DataBASE/////////////////////////// // 1 = All ,2 = Str, 3 = Fork, 4 = Slider, 5 = Change-Up // 6 = Str, 7 = Curve, 8 = Fork
float DB[8][5]{
{1.0, 1.0, 1.0, 1.0, 0},
{0.93, 1.0, 1.0, 1.0, 4.5},
{1.0, 1.0, 0.5, 1.0, 9.2},
{1.0, 0.53, 1.0, 1.0, 6.0},
{1.0, 0.8, 0.8, 0.8, 5.9},
{0.94, 1.0, 0.84, 1.0, 10},
{0.5, 1.0, 1.0, 1.0, 6.9},
{1.0, 1.0, 0.5, 1.0, 11},
};

//////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////

void setup(){
  InitTimersSafe();
  SetPinFrequencySafe(2, frequency);
  SetPinFrequencySafe(5, frequency);
  SetPinFrequencySafe(6, frequency);
  SetPinFrequencySafe(7, frequency);
  SetPinFrequencySafe(8, frequency);
  
     
  pinMode(Speed_Out,OUTPUT); //속도 제어 
  
  pinMode(9,OUTPUT); 
  pinMode(10,OUTPUT);   
  
  Serial.begin(9600); // Serial 통신

  // 초기 모터 속도 정지 상태로 설정 및 방향 설정
  for(int ii=1;ii<5;ii++)
  {
    if(ii == GNo)
    {
    analogWrite(4+ii,0); 
    ii=ii+1;  
    }
  analogWrite(4+ii,400); 
  }
  analogWrite(2,0); // 일반 모터 방향제어 선 연결 포트 번호

  Serial.println("현재 각도 입력해주세요! ( 0도는 360 입력해주세요 )");
  
  while(1){
    delay(100);
    ch = Serial.parseFloat();
    if( ch >= -8 && ch <= 15 && ch != 0  || ch == 360){
        Serial.println("상태 점검중");
        if(ch == 360){
          Angle = 0;
        }else{
          Angle = ch;
        }
        
      break;
    }
  }
}



void loop(){
  Status();
  Serial.println("===========================================");
  if(lp == 0 ){
    Serial.println("제어 방식 선택 해주세요 : (1 = 수동, 2 = 자동, 3 = 각도 제어, 4 = 현재 각도 보정 ");  
  }else{
    Serial.println("제어 방식 선택 해주세요 : (1 = 수동, 2 = 자동, 3 = 각도 제어, 4 = 현재 각도 보정, 5 = 빅스비 부르기");  
  }
  
  while(1){ 
    MA = Serial.parseInt(); 
    if (MA == 1 || MA == 2 || MA == 3 || MA == 4 || MA == 5){
      Serial.println("입력 확인");
      if (MA == 1 ){
        Serial.println("수동 제어");   
      }else if(MA == 2 ){
        Serial.println("자동 제어");  
      }else if(MA == 3 ){
        Serial.println("각도 제어");   
      }else if(MA == 4 ){
        Serial.println("현재 각도 재설정");
        Serial.println("각도를 입력해주세요! ( 0 deg 를 넣고 싶으면 360을 입력해주세요!");    
      }else if(MA == 5){
        BixB();  
      }
    break;   
    }
  }
 
  if(MA == 1){
    MT();   // 수동 제어 시작
  }else if(MA == 2 ){
    Auto(); // 자동 제어 시작
  }else if(MA == 3 ){
    AOA();  //각도 제어 시작
  }else if(MA == 4 ){
    while(1){
      Angle = Serial.parseFloat();
      if(Angle != 0 && Angle > -10 && Angle <= 15 || Angle == 360){
        if(Angle == 360){
          Angle = 0;
        }
        break;
      }
    }
  }
  lp = lp +1;
}

//////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////  MT  ////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////
void MT(){
  Ratio = 0;
  Serial.println("제어할 모터 번호를 입력해주세요");
  while(1)
  {
    //모터 번호 입력 및 제어 요소 선택
    No = Serial.parseInt();
    
      if (No >= 1 && No <= 4)
      {
      Serial.print("선택하신 모터 번호는 ");
      Serial.println(No);

        if(No == GNo)
        {
        Serial.println("일반모드  모터"); 
        CMD = 'v';  
        break; 
        }else if(No != GNo && No >=1 && No <=4)
        {
         Serial.println("JS모드 모터 "); 
         CMD = 'v';
          break;
        }
      }
  }
  
  // 모터 속도 출력
  if(CMD == 'v'&& No == GNo)
  {
   delay(500);
   Serial.print("회전 속도 입력 : [1000~3000] RPM");
    
   while(1)
    { 
      velocity = Serial.parseInt(); 
      if (velocity>0 && velocity<=3000){
        break;     
      }
    } 
    
   Slow(No,velocity1[No],velocity);
     
  }else if(CMD == 'v' && No != GNo)
  {
   delay(1000);
   Serial.print("회전 속도 입력 : [1000~3000] RPM");
  
   while(1)
    { 
      velocity = Serial.parseInt(); 
      if (velocity>0&& velocity<=3000){
        break;     
      }
    } 
    Slow(No,velocity1[No],velocity); 
  }
  
  velocity1[No] = velocity;
  return;
  }
  
//////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////// Auto ///////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////
void Auto(){
  
    Serial.println("투구폼 선택 해주세요 : (1 = 3/4, 2 = Under)");
    delay(100);
  
    while(1){  
      FF = Serial.parseInt(); 
      if(FF == 1){
        Serial.println("선택하신 투구폼 : 3/4"); 
        break;
      }else if(FF == 2){
        Serial.println("선택하신 투구폼 : Under"); 
        break;
      }
    }

  if(FF == 1){
    Serial.println("구질을 선택 해주세요 : (1 = All same, 2 = Str, 3 = Fork, 4 = Slider, 5 = Change-Up)");
    delay(500);
  }else if(FF == 2){
    Serial.println("구질을 선택 해주세요 : (1 = All same, 6 = Str, 7 = Curve, 8 = Fork)");
    delay(500);
  }
  /////////////////////// DB 정보 알림 //////////////////////////////////////    
  while(1){ 
    Ratio = Serial.parseInt();
    
    if( Ratio > 0){
      delay(500);
      Serial.println("DB Loading");
      for(int i=1;i<5;i++){
        rateV[i] = DB[Ratio-1][i-1];
        Serial.print(i);Serial.print("번 모터 비율 = ");Serial.println(rateV[i]);
      }
    break;
    }
  } 
 
  Serial.println("회전 속도 : [1000~3000]RPM"); 
  delay(100);
  
  while(1){ 
    velocity = Serial.parseInt(); 
    if(velocity > 0 && velocity <= 3000){
      Serial.println(velocity);  
      break;
    }
  }
  ////////////////////////////////////////////////////////////////////////
  
  //JS//
  for(int ii=1;ii<5;ii++)
  { 
   if(ii == GNo){
    ii = ii +1; 
   }
  Serial.print("모터 컨트롤 시작 : ");
  Serial.println(ii);
  Serial.println(velocity1[ii]);
  Slow(ii,velocity1[ii],velocity*rateV[ii]);
  velocity1[ii] = velocity*rateV[ii];       
  }

  //일반 모드//
  Serial.print("모터 컨트롤 시작 : ");
  Serial.println(GNo);
  Slow(GNo,velocity1[GNo],velocity*rateV[GNo]);
  velocity1[GNo] = velocity*rateV[GNo];

  Serial.println("=============");
  Serial.println("신호 출력 완료"); 
  Serial.println("=============");
  Serial.println(" ");
  return;
}

//////////////////////////////////////////////////////////////////////////////////////////
/////////////////////// Velocity Control /////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////
void Slow(int No, float velocity1,float velocity2){
 Serial.println("제어 시작");
 while(1){
  float des = 0;
  float change;
  des = velocity2 - velocity1;  

  if(des <= 3000 && des > 2000 || des >= -3000 && des < -2000){
    change = des/40;
  }else if(des <= 2000 && des > 1000 || des >= -2000 && des < -1000){
    change = des/20;
  }else if(des <= 1000 && des > 500 || des >= -1000 && des < -500 ){
    change = des/10; 
  }else if(des <= 500 || des >= -500){
    change = des/5;  
  }
  
  while(1){
  if(velocity1 >= velocity2*0.9999 && velocity1 <= velocity2*1.0001){
    break;
  }else if(velocity1 >= velocity2*0.99 && velocity1 <= velocity2*1.01){
    break;
  }else if(velocity1 < 0 ){
    velocity1 = 0;
    break;
  }

  if(change < 0){
    velocity1 = velocity1 + change;
    
    if(No != GNo){
    Ana = (3193.4-velocity1)/9.9337;
    }else if(No == GNo){
    Ana = (velocity1+12.809)/3.7745;  
    }

    if(Ana >= 254 && Ana <= 256){
      Ana = 254; 
     }
     
   Serial.println("감소");
   Serial.println(velocity1); 
   analogWrite(Speed_Out+No,Ana);
   delay(dl);
  }else if(change > 0){
    velocity1 = velocity1 + change;
    
    if(No != GNo){
      Ana = (3193.4-velocity1)/9.9337;
    }else if(No == GNo){
      Ana = (velocity1+12.809)/3.7745;  
    }

     if(Ana >= 254 && Ana <= 256){
      Ana = 254; 
     }
     
   Serial.println("증가");
   Serial.println(velocity1);
   analogWrite(Speed_Out+No,Ana);
   delay(dl);
  }
 }
 return; 
 }
}

//////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////// Angle  /////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////

void AOA(){
  Serial.println("원하시는 각도를 입력해주세요 [ ~15] (0도 입력을 위해서는 360을 입력)");
  while(1){
    NewAngle = Serial.parseFloat();
    if(NewAngle != 0 && NewAngle >= -15 && NewAngle <= 15 || NewAngle == 360){
      if(NewAngle == 360){
        NewAngle = 0.0;
        Time = 0;
        }
      DeltaAngle = NewAngle-Angle;
      break;  
    }
  }

  //모터 스펙 [deg/s] 
  AngleVel = 1.3; //+ : 1.6~7 - 2.9~0 - 4.2~3 -  5.5~6 - 6.9~0 - 8.2~3 - 9.5~6 - 10.8~9 - 12.3 - 13.6~7 - 15  
                  //- :  1.3~4 - 2.6~7 - 4.0~1 - 5.4~5 - 6.8~9 - 8.0~1

  Time = DeltaAngle/AngleVel;
  Serial.print(" 작동 시간 : ");
  Serial.println(Time);
  
  while(1){
    if(DeltaAngle > 0){
      analogWrite(9,255);
      analogWrite(10,HIGH);
      delay(Time*1000);
      analogWrite(9,0);
      break;
    }else if(DeltaAngle < 0){
      analogWrite(9,255);
      analogWrite(10,LOW);
      delay(-Time*1000);
      analogWrite(9,0);
      break;
    }  
  }
  Angle = Angle + Time * AngleVel;
  Serial.println("각도 제어 종료 ");
    
  return;
}

//////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////// A.I /////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////
void BixB(){
  int CM=0;
  Serial.println("안녕하세요! 빅스비에요!");
  Serial.println("무엇을 도와드릴까요!");
  Serial.println("  1 = 각도 조절 도와줘! 3 = 나가기");
  
  while(1){
    CM = Serial.parseInt();
    if(CM == 1 || CM == 3){
      Serial.println("네, 알겠습니다 ");
      break;
    }
  }

  if(CM == 1){
    Serial.print("현재 투구폼은 ");
    if(FF == 1 ){
      Serial.print("3/4"); 
    }else if( FF == 2 ){
      Serial.print("Under"); 
    } Serial.println("이고,");

    Serial.print("구질은 ");
    if( Ratio == 1 ){
      Serial.print("All Same"); 
     }else if( Ratio == 2 ){
      Serial.print("Str"); 
    }else if( Ratio == 3 ){
      Serial.print("Fork"); 
    }else if( Ratio == 4 ){
      Serial.print("Slider"); 
    }else if( Ratio == 5 ){
      Serial.print("Change - Up"); 
    }else if( Ratio == 6 ){
      Serial.print("Str"); 
    }else if( Ratio == 7 ){
      Serial.print("Curve"); 
    }else if( Ratio == 8 ){
      Serial.print("Fork"); 
    } Serial.println("입니다!");

    delay(1000);

    Serial.print("권장하는 각도는 ");Serial.print(rateV[5]);Serial.println("deg 입니다!");
    
  while(1){
    Serial.println("투구 되는 위치가 어떤가요? 낮다 = 1, 높다 = 2, 적절하다 = 3, 직접 설정 = 4");
    int Q = 0;
      while(1){
        Q = Serial.parseInt();
          if(Q == 1 || Q == 2 || Q == 3 || Q == 4){
          break;
          }
        }

      if(Q == 1){
        analogWrite(9,255);
        analogWrite(10,HIGH);
        delay(500);
        analogWrite(9,0);
        Serial.println("조절 완료");
        Angle = Angle + 0.5*1.3;
      }else if(Q == 2){
        analogWrite(9,255);
        analogWrite(10,LOW);
        delay(500);
        analogWrite(9,0);
        Serial.println("조절 완료");
        Angle = Angle - 0.5*1.3;
      }else if(Q == 3){
        break;
      }else if(Q == 4){
        AOA();
        loop();  
      }
    }
      
  }else if(CM == 2){
    
  }else if(CM == 3){
    return;
  }
  
}
//////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////// Status /////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////
void Status(){
 Serial.println("==================== 현재 모터 상태 ====================");
 Serial.print("현재 각도 : ");Serial.println(Angle);
 
 Serial.print("현재 투구폼 : ");
 if(FF == 1 ){
  Serial.println("3/4"); 
 }else if( FF == 2 ){
  Serial.println("Under"); 
 }else if( FF == 0 ){
  Serial.println(" 입력 대기중"); 
 }

 Serial.print("구질 : ");
 if( Ratio == 1 ){
  Serial.println("All Same"); 
 }else if( Ratio == 2 ){
  Serial.println("Str");
  Serial.print("권장 각도 : "); Serial.println(DB[Ratio-1][4]); 
 }else if( Ratio == 3 ){
  Serial.println("Fork"); 
  Serial.print("권장 각도 : "); Serial.println(DB[Ratio-1][4]);
 }else if( Ratio == 4 ){
  Serial.println("Slider");
  Serial.print("권장 각도 : "); Serial.println(DB[Ratio-1][4]);
 }else if( Ratio == 5 ){
  Serial.println("Change - Up"); 
  Serial.print("권장 각도 : "); Serial.println(DB[Ratio-1][4]);
 }else if( Ratio == 6 ){
  Serial.println("Str");
  Serial.print("권장 각도 : "); Serial.println(DB[Ratio-1][4]) ;
 }else if( Ratio == 7 ){
  Serial.println("Curve"); 
  Serial.print("권장 각도 : "); Serial.println(DB[Ratio-1][4]);
 }else if( Ratio == 8 ){
  Serial.println("Fork"); 
  Serial.print("권장 각도 : "); Serial.println(DB[Ratio-1][4]);
 }else if( Ratio == 0){
  Serial.println("수동 제어 상태");
 }
 
 Serial.println("======================================================");
      
  if(velocity1[2] == 0){
    Serial.print("       ㅣ"); Serial.print(velocity1[1]); Serial.println("ㅣ");
    Serial.print("_______"); Serial.print("l_______l"); Serial.println("_______");
    Serial.print(velocity1[2]);Serial.print("  ");Serial.print("ㅣ______ㅣ");Serial.println(velocity1[4]);
    Serial.print("_______");  Serial.print("l_______l"); Serial.println("_______");
    Serial.print("       ㅣ"); Serial.print(velocity1[3]); Serial.println("ㅣ");
  }else if(velocity1[2] > 0 && velocity1[2] < 100){
    Serial.print("       ㅣ"); Serial.print(velocity1[1]); Serial.println("ㅣ");
    Serial.print("_______");  Serial.print("l_______l"); Serial.println("_______");
    Serial.print(velocity1[2]);Serial.print(" ");Serial.print("ㅣ______ㅣ");Serial.println(velocity1[4]);
    Serial.print("_______");  Serial.print("l_______l"); Serial.println("_______");
    Serial.print("       ㅣ"); Serial.print(velocity1[3]); Serial.println("ㅣ");  
  }else if(velocity1[2] >= 100 && velocity1[2] < 1000){
    Serial.print("       ㅣ"); Serial.print(velocity1[1]); Serial.println("ㅣ");
    Serial.print("_______");  Serial.print("l_______l"); Serial.println("_______");
    Serial.print(velocity1[2]);Serial.print("ㅣ______ㅣ");Serial.println(velocity1[4]);
    Serial.print("_______");  Serial.print("l_______l"); Serial.println("_______");
    Serial.print("       ㅣ"); Serial.print(velocity1[3]); Serial.println("ㅣ"); 
  }else if(velocity1[2] >= 1000){
    Serial.print("       ㅣ"); Serial.print(velocity1[1]); Serial.println("ㅣ");
    Serial.print("_______");  Serial.print("l_______l"); Serial.println("_______");
    Serial.print(velocity1[2]);Serial.print("ㅣ______ㅣ");Serial.println(velocity1[4]);
    Serial.print("_______");  Serial.print("l_______l"); Serial.println("_______");
    Serial.print("       ㅣ"); Serial.print(velocity1[3]); Serial.println("ㅣ");  
  }
}


