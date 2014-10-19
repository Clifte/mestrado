package opencv.fundamentos;

import opencv.util.gui.base.ImageFrameView;

import org.opencv.*;
import org.opencv.core.*;
import org.opencv.highgui.Highgui;

public class OpenImage {

	public static void main(String[] args) {
	    System.loadLibrary( Core.NATIVE_LIBRARY_NAME );
		Mat infrared =  Highgui.imread("/home/clifte/Imagens/GEIR.JPG",Highgui.CV_LOAD_IMAGE_COLOR);
		ImageFrameView.showResult(infrared);
		
		Mat visible =  Highgui.imread("/home/clifte/Imagens/GEVS.JPG",Highgui.CV_LOAD_IMAGE_COLOR);
		ImageFrameView.showResult(visible);
		
		System.out.println("DONE");
	}
}
