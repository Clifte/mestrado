package opencv.fundamentos.mestrado;


import java.util.ArrayList;
import java.util.List;

import org.opencv.core.Core;
import org.opencv.core.CvType;
import org.opencv.core.Mat;
import org.opencv.core.Scalar;
import org.opencv.core.Size;
import org.opencv.imgproc.Imgproc;

public class ColorSegment {
	Mat hsv = null;
	Mat h = null;
	Mat h1 = null;
	Mat h2 = null;
	Mat s = null;
	Mat v = null;
	Mat dst = null;
	List<Mat> lst = new ArrayList<Mat>();

	private double sValue;	
	private int hueValue = 10;
	private int hueWidth = 10;
	
	public void getFilteredImage(Mat frame,Mat dst) {
		
		if(hsv == null){
			Size d = new Size(frame.cols(), frame.height());
			hsv = new Mat(d, CvType.CV_8UC3);
			
			h = new Mat(d, CvType.CV_8U);
			s = new Mat(d, CvType.CV_8U);
			v = new Mat(d, CvType.CV_8U);
			
			h1 = new Mat(d, CvType.CV_8U);
			h2 = new Mat(d, CvType.CV_8U);
		
		}
		
		
		Imgproc.cvtColor(frame, hsv, Imgproc.COLOR_BGR2HSV);
	    Core.split(hsv, lst);
		
	    h = lst.get(0);
	    s = lst.get(1);
	    v = lst.get(2);
	    
		Imgproc.threshold(v, v, 20, 255, Imgproc.THRESH_BINARY);

		Imgproc.threshold(s, s, sValue, 255, Imgproc.THRESH_BINARY);
		
		
		int ls = hueValue+hueWidth;
		int li = hueValue-hueWidth;
		
		if( li>=0 && ls<=180){
			Core.inRange(h, new Scalar(li),new Scalar(ls), dst);
			System.out.println("^L1 = " + (li) + "     L2=" + (ls));
		}else{
			if( ls > 180){
				Core.inRange(h, new Scalar(ls-180),new Scalar(li), dst);
				Core.bitwise_not(dst, dst);
				System.out.println("^L1 = " + (ls-180) + "     L2=" + (li));
			}else{
				Core.inRange(h, new Scalar(ls),new Scalar(180+li), dst);
				Core.bitwise_not(dst, dst);
				System.out.println("^L1 = " + (ls) + "     L2=" + (180+li));
			}
		}
			
		
		Core.bitwise_and(dst, v, dst);
		Core.bitwise_and(dst, s, dst);

}
	
	public int getHueValue() {
		return hueValue;
	}

	public void setHueValue(int hueValue) {
		this.hueValue = hueValue;
	}

	public int getHueWidth() {
		return hueWidth;
	}

	public void setHueWidth(int hueWidth) {
		this.hueWidth = hueWidth;
	}

	public void setSatValue(int value) {
		this.sValue = value;	
	}
}
