Palette [] p = new Palette [8];
String [] name = {"Coulmn BG", "Menu BG Hover", "Coulmn BG", 
  "Actie Item", "Hover Item", "Text Color", "Active Presence", "Mention Badge"};
PFont font;
color [] col = new color [8];
color [] startcol = {#4D394B, #3E313C, #4C9689, #FFFFFF, #3E313C, #FFFFFF, #38978D, #EB4D5C};

void setup() {
  size(750, 550);
  smooth();
  for (int i = 0; i < 8; i++) {
    p[i] = new Palette(name[i], 200);
    p[i].disp = false;
    p[i].chosedColor = startcol[i];
    p[i].BackColor = "black";
  }
  colorMode(HSB, 360);
  //font = createFont("M+ 1p bold", 28);
  font = createFont("Microsoft Sans Serif", 28);
  textFont(font);
}

void draw() {
  background(-1);
  for (int i = 0; i < 8; i++) {
    stroke(200);
    fill(p[i].chosedColor);
    rect(300, 50+60*i, 30, 30);
    textSize(18);
    fill(0);
    text(name[i], 380, 70+60*i);
    text(p[i].colorcode, 600, 70+60*i);
    if (mousePressed) 
      if (mouseX > 300 && mouseX < 330)
        if (mouseY > 50+60*i && mouseY < 80+60*i) 
          p[i].disp = true;
  }
  for (int i = 0; i < 8; i++) {
    p[i].display(350+27*i, 50+40*i);
  }
  hyouji();
}

void keyPressed() {
  if (keyCode == ENTER) {
    for (int i = 0; i < 8; i++) {
      println(p[i].colorcode);
    }
  }
}
float pos(int pos, int sa, int num) {
  float Pos = pos+num*sa;
  return Pos;
}

void hyouji() {
  int sa = 27;
  noStroke();
  //背景
  fill(p[0].chosedColor);
  rect(0, 0, 250, height);
  //カーソルオン
  fill(p[1].chosedColor);
  rect(0, 0, 250, 80);
  
  //カーソルオンチャンネル
  fill(p[4].chosedColor, 200);
  rect(-10, pos(140,sa,4), 230, 28, 8);
  //選択中チャンネル
  fill(p[2].chosedColor);
  rect(-10, pos(140,sa,2), 230, 28, 8);
  
  //通知
  fill(p[7].chosedColor);
  rect(180, pos(144,sa,3), 30, 20, 22);
  fill(p[5].chosedColor);
  textSize(15);
  text("1", 190, pos(160,sa,3));
  
  //文字
  fill(p[5].chosedColor);
  textSize(25);
  text("TEAM NAME", 30, 40);
  fill(p[5].chosedColor, 200);
  textSize(18);
  text("CHANNELS", 30, 130);
  text("DIRECTMESSAGES", 30, 350);

  for (int i = 0; i < 5; i++) {
    if (i == 2) fill(p[3].chosedColor);//選択中
    else fill(p[5].chosedColor, 200); //それ以外
    text("#channel", 35, pos(160,sa,i));
    fill(p[5].chosedColor, 200);
    text("name", 50, pos(380,sa,i));

    if (i < 2) fill(p[6].chosedColor, 200);//いる
    else {
      //いない
      stroke(p[5].chosedColor, 100);
      strokeWeight(2);
      noFill();
    }
    ellipse(35, pos(375,sa,i), 13, 13);
  }
  
  //上の自分の名前のところ
  fill(p[5].chosedColor, 200);
  textSize(18);
  text("yourname", 50, 65);
  //自分の丸
  fill(p[6].chosedColor);
  noStroke();
  ellipse(35, 61, 15, 15);
  
  //スライダー
  fill(p[4].chosedColor);
  rect(232, 120, 10, 400, 10);
  fill(p[5].chosedColor, 250);
  rect(232, 120, 10, 300, 10);
}