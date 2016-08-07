class Palette {
  //パレットの変数
  color chosedColor;
  int sax = 0;
  int say = 0;
  int posX = 0;
  int posY = 0;
  float Scale;
  String BackColor = "white";
  String Name;
  color back = color(-1);
  color Text = (0);
  boolean drag = false;
  boolean corner = false;
  String colorcode = "#000000";
  boolean disp = true;

  //スライダーの変数
  int maxvalue = 360;
  int slidervalueH = 250;
  int slidervalueB = 250;
  color sliderBackground;
  boolean mouseH;
  boolean mouseB;
  float Sposx, Sposy, Sx, Sy;

  Palette(String name, int sizeX) {
    //大きさと色と文字サイズの初期設定(後でもっとまとめる)
    colorMode(HSB, 360);
    Name = name;
    Scale = sizeX/500.00;
  }

  void Slider(float px, float py, float bx, float by, String name, color inside) {
    int slidervalue;
    if (name == "H") {
      slidervalue = slidervalueH;
    } else {
      slidervalue = slidervalueB;
    }

    Sposx = px;
    Sposy = py;
    Sx = bx;
    Sy = by;
    if (BackColor == "black") sliderBackground = color(-1);
    else sliderBackground = color(0);

    noStroke();
    //スライダーの背景設定
    fill (sliderBackground);
    rect(px, py, bx, by);
    //中身の設定
    fill(inside);
    rect(px, py+by, bx, -by*map(slidervalue, 0, maxvalue, 0, 1));

    mouse(name);

    fill(sliderBackground);
    textAlign(CENTER);
    textSize(dim(20));
    text(slidervalue, px+bx/2, py+by+dim(20));
    text(name, px+bx/2, py-dim(10));
  } 

  void mouse(String name) {
    boolean mouse;
    int slidervalue;
    if (name == "H") {
      mouse = mouseH;
      slidervalue = slidervalueH;
    } else {
      mouse = mouseB;
      slidervalue = slidervalueB;
    }
    //スライダーを持っているかどうかの判定
    if (mousePressed) {
      if (mouseX< Sposx+Sx && mouseX > Sposx ) {
        if (mouseY > Sposy && mouseY < Sposy+Sy ) {
          mouse = true;
        }
      }
    } else mouse = false;

    //持っていたら現在の値を動かす
    //(増やすパラメーターはクラス内でグローバルでないとうまくいかない)
    if (mouse) slidervalue +=(pmouseY-mouseY);

    if (slidervalue > maxvalue) slidervalue = maxvalue;
    if (slidervalue < 0) slidervalue = 0;

    if (name == "H") {
      mouseH = mouse;
      slidervalueH = slidervalue;
    } else {
      mouseB = mouse;
      slidervalueB = slidervalue;
    }
  }

  // 位置を動かせるようにするための計算
  float posx(int iti) {
    float Pos = posX+sax+iti*Scale;
    return Pos;
  }
  float posy(int iti) {
    float Pos = posY+say+iti*Scale;
    return Pos;
  }
  float dim(int nagasa) {
    float Nagasa = nagasa*Scale;
    return Nagasa;
  }
  //宣言する方
  void display(int posx, int posy) {
    colorCode();
    posX = posx;
    posY = posy;
    if (disp) Disp();
  }
  //表示させる方
  void Disp() {
    colorMode(HSB, 360);
    noStroke();
    //白黒か黒白かの選択
    if (BackColor == "black") {
      back = color(0);
      Text = color(-1);
    } else {
      back = color(-1);
      Text = color(0);
    }
    //大きさの初期設定
    float Centerx = posx(190);
    float Centery = posy(225);
    float hankei = dim(140);

    //後で全体の大きさが変えられるようにすべてsizeXを基準に描写したい
    //背景
    fill(back);
    rect(posx(0), posy(0), dim(500), dim(60), dim(30), dim(30), 0, 0);
    fill(back, 300);
    rect(posx(0), posy(0), dim(500), dim(400), dim(30));

    //スライダー
    Slider(posx(370), posy(105), dim(30), dim(250), "H", color(200));
    Slider(posx(420), posy(105), dim(30), dim(250), "B", color(200));

    //円
    for (float c = 0; c <= 360; c+=0.1) {
      stroke(c, slidervalueH, slidervalueB);
      line(Centerx, Centery, Centerx+hankei*cos(radians(c)), Centery+hankei*sin(radians(c)));
      c+=0.01;
    }

    fill(back);
    noStroke();
    ellipse(Centerx, Centery, hankei*4/3, hankei*4/3);

    fill(Text);
    textSize(dim(40));
    textAlign(CENTER);
    text(Name, posx(250), posy(45));
    //真ん中に選択した色を表示させる
    fill(chosedColor);
    rect(posx(150), posy(185), dim(80), dim(80));
    //右下の矢印
    strokeWeight(dim(2));
    stroke(250);
    line(posx(475), posy(375), posx(490), posy(390));
    line(posx(475), posy(375), posx(475), posy(382));
    line(posx(475), posy(375), posx(482), posy(375));
    line(posx(490), posy(390), posx(490), posy(383));
    line(posx(490), posy(390), posx(483), posy(390));
    //右上のバツ印
    fill(back);
    rect(posx(455), posy(20), dim(25), dim(25));
    line(posx(460), posy(25), posx(475), posy(40));
    line(posx(460), posy(40), posx(475), posy(25));

    //判定
    if (mousePressed) {
      //色取得
      if (dist(mouseX, mouseY, Centerx, Centery) < hankei && dist(mouseX, mouseY, Centerx, Centery) > hankei*2/3) {
        chosedColor = get(mouseX, mouseY);
      }
      //上のところを持っているかどうか
      if (mouseX>posx(0) && mouseX< posx(500) && mouseY > posy(0) && mouseY < posy(70)) {
        drag=true;
      }
      //右下の角を持っているかの判定
      if (mouseX > posx(475) && mouseX < posx(510) && mouseY > posy(375) && mouseY < posy(410)) {
        corner = true;
      }
      //右上のバツを押しているかの判定
      if (mouseX > posx(455) && mouseX < posx(480) && mouseY > posy(20) && mouseY < posy(45)) {
        disp = false;
      }
    } else {
      drag = false;
      corner = false;
    }    
    if (drag) {
      sax -= pmouseX-mouseX;
      say -= pmouseY-mouseY;
    }
    if (corner) {
      Scale -= (float)(pmouseX-mouseX)/600;
      mouseH = false;
      mouseB = false;
      drag = false;
    }
    textAlign(LEFT);
  }
  //カラーコード取得
  void colorCode() {
    color C = color(chosedColor);
    colorMode(RGB, 255);
    int r = (int)red(C);
    int g = (int)green(C);
    int b = (int)blue(C);
    int col = (int)(r*pow(16, 4)+g*pow(16, 2)+b);
    colorcode="#"+hex(col, 6);
    colorMode(HSB, 360);
  }
}