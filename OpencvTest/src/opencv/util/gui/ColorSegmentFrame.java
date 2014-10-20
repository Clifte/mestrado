package opencv.util.gui;

import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.File;
import java.util.ArrayList;
import java.util.List;

import javax.swing.*;
import javax.swing.event.ChangeEvent;
import javax.swing.event.ChangeListener;

import opencv.fundamentos.mestrado.ColorSegment;
import opencv.util.gui.base.ImagePanel;

import org.opencv.core.*;
import org.opencv.core.Point;
import org.opencv.highgui.Highgui;
import org.opencv.highgui.VideoCapture;
import org.opencv.imgproc.Imgproc;

class ColorSegmentFrame extends JFrame{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	ImagePanel srcPanel;
	ImagePanel resultPanel;
	JSlider Hslider;
	JSlider Sslider;
	ColorSegment colorSegment = new ColorSegment();
	JSpinner Hspinner;

	Thread th;
	private JButton btnNewButton;
	private JLabel label;
	private JLabel label_1;
	
	public ColorSegmentFrame() {
		
		JSplitPane splitPane = new JSplitPane();
		getContentPane().add(splitPane, BorderLayout.CENTER);
		resultPanel = new ImagePanel(0);
		splitPane.setLeftComponent(resultPanel);
		srcPanel = new ImagePanel(0);
		splitPane.setRightComponent(srcPanel);
		
		JPanel panel = new JPanel();
		panel.setMaximumSize(new Dimension(32767, 30));
		getContentPane().add(panel, BorderLayout.NORTH);
		
		Hslider = new JSlider();
		Hslider.setMaximum(180);
		Hslider.addChangeListener(new ChangeListener() {
			public void stateChanged(ChangeEvent e) {
				atualizaH();
			}
		});
		
		
		Sslider = new JSlider();
		Sslider.setMaximum(255);
		Sslider.addChangeListener(new ChangeListener() {
			public void stateChanged(ChangeEvent e) {
				atualizaS();
			}
		});
		
		
		btnNewButton = new JButton("Play");
		btnNewButton.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				System.out.println("Iniciar Thread");
				if(th!=null){
					th.start();
				}
			}
		});
		panel.setLayout(new FlowLayout(FlowLayout.CENTER, 5, 5));
		panel.add(btnNewButton);
		
		label = new JLabel("");
		panel.add(label);
		
		label_1 = new JLabel("");
		panel.add(label_1);
		panel.add(Hslider);
		panel.add(Sslider);
		
		Hspinner = new JSpinner();
		Hspinner.addChangeListener(new ChangeListener() {
			public void stateChanged(ChangeEvent e) {
				atualizaH();
			}
		});
		
	
		
		
		Hspinner.setModel(new SpinnerNumberModel(5, 3, 180, 1));

		panel.add(Hspinner);

		
		iniciaVideoThread();
	}


	private void iniciaVideoThread() {
		th = new Thread(new Runnable(){
			
			
			@Override
			public void run() {
				
				File f = new File("arquivos/man.mp4");
				
				String  videoFile = f.getAbsolutePath();
				System.out.println("Iniciando");
				//Carregando video
				VideoCapture vc = new VideoCapture(videoFile);
				if(!vc.isOpened()) System.out.println("Erro ao abrir o arquivo : " + videoFile);
				
				//Alocando imagens
				Size d = new Size((int) vc.get(Highgui.CV_CAP_PROP_FRAME_HEIGHT),
								  (int) vc.get(Highgui.CV_CAP_PROP_FRAME_WIDTH));
				
				Mat frame = new Mat(d, CvType.CV_8U	);
				Mat skin = new Mat(d, CvType.CV_8U );
				
				long frameRate = 20;

				while(true){
					
					
					while(vc.read(frame)){
						//System.out.println(sdf.format(new Date()));
						
						
						colorSegment.getFilteredImage(frame,skin);
						
						double data[] = { 1, 0 , 0,  0, 0, 
										  0, 1 , 0,  0, 0,
										  0, 0 , 1,  0, 0,
										  0, 0 , 0,  1, 0,
										  0, 0 , 0,  0, 1};
						
						Mat element = new Mat(new Size(5, 5),CvType.CV_8U);
						element.put(0, 0, data);

						//Imgproc.dilate( skin, skin, element,new Point(0, 0),2 );
						
						
						detectObjects(skin,frame);
						
						srcPanel.setImage(frame);
						resultPanel.setImage(skin);
						
						try {
							Thread.sleep(frameRate);
						} catch (InterruptedException e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						}
					}
					
					vc.release();
				
					vc = new VideoCapture(videoFile);
				}
			}
			
			
		});	
	}


	public static void detectObjects(Mat srcImage,Mat dstImage){
		Mat edges = new Mat(srcImage.size(),CvType.CV_8U);
		
		Imgproc.Canny(srcImage, edges, 128, 255);
		
	    List<MatOfPoint> contours = new ArrayList<MatOfPoint>();  
	    Imgproc.findContours(edges, contours, new Mat(), Imgproc.RETR_LIST,Imgproc.CHAIN_APPROX_SIMPLE);

		for (int i = 0; i < contours.size(); i++) {
			MatOfPoint pts = (MatOfPoint) contours.get(i);
			
			//Filtrando pontos pequenos
			if (pts.rows() < 10)
				continue;
				
			//Filtrando formas quadradas
			Rect rect = Imgproc.boundingRect(contours.get(i));
			float k = Math.abs(1 - rect.width/rect.height);
			if(k>0.1 || rect.height < 30 ) continue;
			
			
			
			double area = Imgproc.contourArea(pts);
			
			System.out.println(k + "   " + rect);
			// System.out.println(rect.x
			// +","+rect.y+","+rect.height+","+rect.width);
			Point pt1 = new Point(rect.x, rect.y);
			Point pt2 = new Point(rect.x + rect.width, rect.y + rect.height);
			Point center = new Point(rect.x + rect.width / 2, rect.y
					+ rect.height / 2);

			Scalar cor = new Scalar(0, 0, 255);

			Core.rectangle(dstImage, pt1, pt2, cor, 3);

			Core.putText(dstImage, "(" + center.toString() + ")", pt2,
					Core.FONT_HERSHEY_TRIPLEX, 0.5, cor);
		}
	}
	
	protected void atualizaH() {
		colorSegment.setHueValue(Hslider.getValue());
		colorSegment.setHueWidth((int) Hspinner.getValue());
	}
	
	protected void atualizaS() {
		colorSegment.setSatValue(Sslider.getValue());
	}

	public static void main(String[] args) throws InterruptedException {
		System.loadLibrary(Core.NATIVE_LIBRARY_NAME);
		ColorSegmentFrame frame = new ColorSegmentFrame();
		frame.setVisible(true);
		frame.pack();
		
	}
}
