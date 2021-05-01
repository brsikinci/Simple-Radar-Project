class Drawer
{
  public void drawRadarCircles() 
  {
    pushMatrix();
    
      translate(width/2, height/2);
      strokeWeight(2);
      stroke(Constant.CircleColor);
      noFill();
    
      for (float R : Constant.RadiusList)
        circle(0, 0, R);
      popMatrix();
  }
  
  public void drawObject() 
  {
    pushMatrix();
    float lineVar = Constant.LineLength;
    float pixelDistance;
    translate(width/2, height/2);
    strokeWeight(9);
    stroke(Constant.RedLineColor);
    
    if(cmDistance <= 80)
      pixelDistance = cmDistance * 1.7;
    else if(cmDistance <= 160)
      pixelDistance = cmDistance * 1.5;
    else if(cmDistance <= 240)
      pixelDistance = cmDistance * 1.6;
    else
      pixelDistance = cmDistance * 1.6;
      
    if(cmDistance < Constant.MaxRange)
    {
      line(pixelDistance*cos(radians(rotateAngle)), pixelDistance*-sin(radians(rotateAngle)), lineVar*cos(radians(rotateAngle)), -(lineVar)*sin(radians(rotateAngle)));
      drawRedDot(pixelDistance);
    }
    popMatrix();
  }
  
  public void drawLine() 
  {
    pushMatrix();
    float lineVar = Constant.LineLength;
    strokeWeight(9);
    stroke(0,250,0);
    translate(width/2, height/2); 
    line(0, 0, lineVar*cos(radians(rotateAngle)), -(lineVar)*sin(radians(rotateAngle)));
    popMatrix();
  }
  
  public void drawRadarLines()
  {
      pushMatrix();
      fill(Constant.LineColor);
      float lineVar = Constant.LineLength;
      translate(width/2, height/2);
    
      for (int i = 30; i <= 360; i+=30)
        line(0, 0, -(lineVar)*cos(radians(i)), -(lineVar)*sin(radians(i)));
  
      popMatrix();
  }
  
  public void drawRadarDistanceNumbers()
  {
    pushMatrix();
    
    translate(width/2, height/2);
    
    fill(Constant.TextColor);
    textSize(width*1.10/100);
    textAlign(LEFT);
    for (int i = 0; i < Constant.RadiusList.length; i++)
      text((i + 1) * Constant.DistanceConst, Constant.RadiusList[i] / 2 + bigger * 0.00260, height*3/100); //bigger * 0.00260 is for simulating a five pixel addition on any resolution.
    
    popMatrix();
  }
  
  public void drawRadarDegreeNumbers()
  {  
    float lineVar = Constant.LineLength;
  
    pushMatrix();
  
    translate(width/2, height/2);
  
    textSize(smaller*1.90/100);
    textAlign(CENTER);
    textLeading(0);
    fill(Constant.TextColor);
  
    float transConstantX = 1.1;
    float transConstantY = 1.1;
  
    for (int i = 0; i < 360; i +=30)
    {
      pushMatrix();
      translate(lineVar * cos(radians(i)) * transConstantX, -lineVar*sin(radians(i)) * transConstantY);
      if (i <= 180)
        rotate(radians(90 - i));
      else
        rotate(radians(270 - i));
      text(i + "°", 0, 0);
      popMatrix();
    }
  
    popMatrix();
  }
    
  public void drawInfoText() 
  { 
    pushMatrix();
    noObject = cmDistance > Constant.MaxRange ? "Out of Range" : "In Range";
    fill(Constant.InfoTextColor);
  
    textAlign(LEFT);
    textSize(bigger*2.08/100);
    textLeading(3);
  
    translate(width/2, height/2);
    text("Object: " + noObject, -width/2*95/100, -height/2*90/100);
  
    text("Angle: " + nfs(rotateAngle, 3, 2) +" °", -width/2*95/100, -height/2*80/100);
    text("Distance:", -width/2*95/100, -height/2*70/100);
  
    int printedDistance = cmDistance > Constant.MaxRange ? 0 : cmDistance;
    text(printedDistance +" cm", -width/2*75/100, -height/2*70/100);
    popMatrix();
  }
  
  public void drawRedDot(float pixelDistance) 
  {
    pushMatrix();
    translate(pixelDistance*cos(radians(rotateAngle)), pixelDistance*-sin(radians(rotateAngle)));
    fill(255,0,0);
    circle(0, 0, 15);
    popMatrix();
  } 
}
