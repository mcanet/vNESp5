//----------------------------------------------------
void setRescale()
{
   pixelSizeX = 4;
   pixelSizeY = 4;
   totalPixels = (frame.width*pixelSizeX)*(frame.height*pixelSizeY);
   img = createImage((int)(frame.width*pixelSizeX), (int)(frame.height*pixelSizeY), ARGB);
    
}
//----------------------------------------------------

void rescale()
{
        
    img.loadPixels();
    frame.loadPixels();
    
    for(int h=0; h<frame.height;h++)
    {
        for(int w=0; w<frame.width; w++)
        {
            int pixelId = (h*frame.width)+((frame.width-1)-(w));
            int p4 = h*pixelSizeY;

            for(int _y=0; _y<pixelSizeY; _y++)
            {
                for(int _x=0; _x<pixelSizeX; _x++)
                {
                   int pixelId2 = ((((h*pixelSizeY)+_y)*(frame.width*pixelSizeX))) + (((frame.width-1)*pixelSizeX)-(w*pixelSizeX)+_x);
                   img.pixels[pixelId2] = frame.pixels[pixelId];
                }
            }
        }
    }
    pushMatrix();
    scale(1.1,0.9);
    img.updatePixels();
    image(img,-32, -50);
    popMatrix();
    
}

//----------------------------------------------------

