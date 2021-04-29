var redSlide, greenSlide, blueSlide;

function setup() {
  createCanvas(1700, 1000);
  textSize(30);
  noStroke();

  redSlide = createSlider(0, 255, 100);
  redSlide.position(20,20);
  greenSlide = createSlider(0, 255, 0);
  greenSlide.position(20,50);
  blueSlide = createSlider(0,255,255);
  blueSlide.position(20,80)
}

function draw() {
  var r = redSlide.value();
  var g = greenSlide.value();
  var b = blueSlide.value();

  background(r, g, b);

  text("RED", redSlide.x * 3 + redSlide.width, 35);
  text("GREEN", greenSlide.x * 3 + greenSlide.width, 65);
  text("BLUE", blueSlide.x * 3 + blueSlide.width, 95)
}