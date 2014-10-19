package opencv.util.gui.base;

import java.awt.Dimension;
import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;

import javax.imageio.ImageIO;
import javax.swing.JPanel;

import org.opencv.core.Mat;
import org.opencv.core.MatOfByte;
import org.opencv.highgui.Highgui;

public class ImagePanel extends JPanel{
	
	private BufferedImage image = null;
	private int tipo = 0;   // 0- original , 1 - fit panel 
	
	public ImagePanel(int atipo) {
		this.tipo = atipo;
		this.setPreferredSize(new Dimension(150, 150));
	}
	public void paint(java.awt.Graphics g) {
		switch(tipo){
		case 0:
			g.drawImage(image, 0, 0,null);
			break;
		case 1:
			g.drawImage(image, 0, 0,this.getWidth(),this.getHeight(),null);
			break;
		}
		
	}
	public BufferedImage getImage() {
		return image;
	}
	public void setImage(BufferedImage image) {
		
		this.image = image;
		if(this.tipo==0)
			this.setPreferredSize(new Dimension(this.image.getWidth(), this.image.getHeight()));
		
		
		this.repaint();
	};
	
	
public void setImage(Mat img) {
	
	    BufferedImage bufImage = matToBufferedImage(img);
				
		this.setImage(bufImage);
    
}
	
	
	   public static BufferedImage matToBufferedImage(Mat matrix) {  
		     int cols = matrix.cols();  
		     int rows = matrix.rows();  
		     int elemSize = (int)matrix.elemSize();  
		     byte[] data = new byte[cols * rows * elemSize];  
		     int type;  
		     matrix.get(0, 0, data);  
		     

		     switch (matrix.channels()) {  
		       case 1:  
		         type = BufferedImage.TYPE_BYTE_GRAY;  
		         break;  
		       case 3:  
		         type = BufferedImage.TYPE_3BYTE_BGR;  
		         // bgr to rgb  
		         byte b;  
			         for(int i=0; i<data.length; i=i+3) {  
			           b = data[i];  
			           data[i] = data[i+2];  
			           data[i+2] = b;  
			         } 
		         
		         break;  
		       default:  
		         return null;  
		     }  
		     
		     BufferedImage image = new BufferedImage(cols, rows, type);  
		     image.getRaster().setDataElements(0, 0, cols, rows, data);  
		     return image;  
		   }  
}
