package opencv.util.gui.base;

import java.awt.Dimension;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;
import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.InputStream;

import javax.imageio.ImageIO;
import javax.swing.JFrame;

import org.opencv.core.*;
import org.opencv.highgui.Highgui;
import org.opencv.imgproc.*;

public class ImageFrameView extends JFrame{
	
	
	public static void showResult(Mat img) {
		showResult("Title", img);
	}

	public static void showResult(String title, Mat img) {
	    
	    MatOfByte matOfByte = new MatOfByte();
	    Highgui.imencode(".jpg", img, matOfByte);
	    byte[] byteArray = matOfByte.toArray();
	    BufferedImage bufImage = null;
	    
	    
	    try {
	        InputStream in = new ByteArrayInputStream(byteArray);
	        bufImage = ImageIO.read(in);
	        ImagePanel imPanel = new ImagePanel(0);
	        
	        imPanel.setImage(bufImage);

	        JFrame frame = new JFrame(title);

	        frame.getContentPane().add(imPanel);
	        frame.pack();
	        frame.setVisible(true);
	        
	        
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
		
	}
	
	public ImageFrameView() {
		createMouseMenu();
		loadMouseEvents();
	}

	private void createMouseMenu() {
		// TODO Auto-generated method stub
		
	}

	private void loadMouseEvents() {
	
	}
	
}
