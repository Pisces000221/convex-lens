float totWidth = 1200, totHeight = 600, lensHeight = 400;
float lensFocus = 200;
float candlePos = lensFocus * 1.5, candleHeight = 100;

void setup() {
  size((int)totWidth, (int)totHeight);
}

void dash(float x1, float y1, float x2, float y2, float cnt) {
  for (int i = 0; i < cnt; ++i)
    line(x1 + (x2 - x1) * (i + i) / (cnt + cnt - 1), y1 + (y2 - y1) * (i + i) / (cnt + cnt - 1),
      x1 + (x2 - x1) * (i + i + 1) / (cnt + cnt - 1), y1 + (y2 - y1) * (i + i + 1) / (cnt + cnt - 1));
}

void draw() {
  if (keyPressed && key == 'q' && lensFocus > 15) --lensFocus;
  else if (keyPressed && key == 'e') ++lensFocus;
  else if (keyPressed && key == 'd' && candlePos > 15) --candlePos;
  else if (keyPressed && key == 'a') ++candlePos;
  background(255);

  stroke(0);
  strokeWeight(1);
  for (int i = 0; i < totWidth; i += 10)
    line(i, totHeight / 2, i + 5, totHeight / 2);

  // The lens
  float angle = atan2(lensHeight / 2, lensFocus * 2);
  float radius = sqrt(lensHeight * lensHeight / 4 + lensFocus * lensFocus * 4);
  ellipseMode(CENTER);
  fill(#C0C0FF, 80);
  arc(totWidth / 2 - lensFocus * 2, totHeight / 2, radius * 2, radius * 2, -angle, angle, OPEN);
  arc(totWidth / 2 + lensFocus * 2, totHeight / 2, radius * 2, radius * 2, PI - angle, PI + angle, OPEN);
  // The focals
  fill(0);
  ellipse(totWidth / 2 - lensFocus, totHeight / 2, 5, 5);
  ellipse(totWidth / 2 + lensFocus, totHeight / 2, 5, 5);
  ellipse(totWidth / 2 - lensFocus * 2, totHeight / 2, 5, 5);
  ellipse(totWidth / 2 + lensFocus * 2, totHeight / 2, 5, 5);

  // The candle
  strokeWeight(10);
  line(totWidth / 2 - candlePos, totHeight / 2, totWidth / 2 - candlePos, totHeight / 2 - candleHeight);
  // The image
  float imgPos = candlePos * lensFocus / (candlePos - lensFocus);
  float imgHeight = candleHeight * imgPos / candlePos;
  stroke(0, 80);
  if (imgPos > 0)
    line(totWidth / 2 + imgPos, totHeight / 2, totWidth / 2 + imgPos, totHeight / 2 + imgHeight);
  else dash(totWidth / 2 + imgPos, totHeight / 2, totWidth / 2 + imgPos, totHeight / 2 + imgHeight, 5);
  // The rays
  stroke(0);
  strokeWeight(1);
  // > Ray 1
  line(totWidth / 2 - candlePos, totHeight / 2 - candleHeight, totWidth / 2, totHeight / 2 - candleHeight);
  line(totWidth, totHeight / 2 + candleHeight * (totWidth / 2 - lensFocus) / lensFocus, totWidth / 2, totHeight / 2 - candleHeight);
  // > Ray 2
  line(totWidth / 2 - candlePos, totHeight / 2 - candleHeight,
    totWidth, totHeight / 2 + candleHeight * totWidth / 2 / candlePos);
  // > Optional ray if the image is virtual
  if (imgPos < 0) {
    // >> Ray 1 reverse extension cord
    dash(totWidth / 2 - candlePos, totHeight / 2 - candleHeight, totWidth / 2 + imgPos, totHeight / 2 + imgHeight, 7);
    // >> Ray 2 reverse extension cord
    dash(totWidth / 2, totHeight / 2 - candleHeight, totWidth / 2 + imgPos, totHeight / 2 + imgHeight, 7);
  }
}
