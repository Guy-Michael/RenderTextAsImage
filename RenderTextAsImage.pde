import java.nio.ByteBuffer;
import java.nio.ByteOrder;
String imageName;
byte[] bytes;
int imageWidth;
int imageHeight;
int pixelScale = 1;
float colorScale = 1f;

String fileName;
void settings()
{
  loadImageByName("The Hitchhikers Guide to the Galaxy.txt");
  calcWidthAndHeight();
  size(imageWidth * pixelScale, imageHeight * pixelScale);    
}

void setup()
{
  int k = 0;

  for (int i = 0; i < imageHeight * pixelScale; i+=pixelScale)
  {
    for (int j = 0; j < imageWidth * pixelScale; j+=pixelScale)
    {
      if(k >= bytes.length - 2)
      {
        break;
      }
      int blue = (0xff & bytes[k]);
      int green = ((0xff & bytes[k+1]));
      int red = ((0xff & bytes[k+2]));   

      color current = color(red * colorScale, green * colorScale, blue * colorScale);
 
      stroke(current);
      for(int m = 0; m < pixelScale; m++)
      {
        for(int l = 0; l < pixelScale; l++)
        {
          set(j + l,i + m, current);
        }
      }

      k+=3;
    }
  }
  storeImage();
}

public void calcWidthAndHeight()
{
  int length = bytes.length;
  double root = Math.sqrt(length / 3);
  int flooredRoot = (int) Math.floor(root);
  
  imageWidth = flooredRoot;
  imageHeight = flooredRoot;
}

public void storeImage()
{
  println(imageName);
  String imageExtension = ".png";
  String simpleImageName = split(imageName, ".")[0];
  save(simpleImageName + imageExtension);
}

public void loadImageByName(String imageName)
{
  this.imageName = imageName;
  bytes = loadBytes(imageName);
}
