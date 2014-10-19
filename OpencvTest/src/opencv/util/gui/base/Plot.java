package opencv.util.gui.base;

import java.awt.BasicStroke;
import java.awt.Color;
import java.awt.Dimension;
import java.awt.Paint;
import java.awt.Stroke;
import java.awt.image.BufferedImage;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;

import javax.imageio.ImageIO;
import javax.swing.JFrame;

import org.jfree.chart.ChartFactory;
import org.jfree.chart.ChartPanel;
import org.jfree.chart.ChartUtilities;
import org.jfree.chart.JFreeChart;
import org.jfree.chart.plot.PlotOrientation;
import org.jfree.chart.plot.XYPlot;
import org.jfree.chart.renderer.xy.XYDifferenceRenderer;
import org.jfree.data.xy.XYRangeInfo;
import org.jfree.data.xy.XYSeries;
import org.jfree.data.xy.XYSeriesCollection;

public class Plot {

	public static void showChart(int inPoints[],String title) {
		try {
		XYSeries series = new XYSeries("XYGraph");

		for (int i = 0; i < inPoints.length; i++) {
			series.add(i, inPoints[i]);

		}

		// Add the series to your data set
		XYSeriesCollection dataset = new XYSeriesCollection();
		dataset.addSeries(series);
		
		// Generate the graph
		JFreeChart chart = ChartFactory.createXYAreaChart(
				title, 			// Title
				"x-axis", 		// x-axis Label
				"y-axis",		// y-axis Label
				dataset,		// Dataset
				PlotOrientation.VERTICAL, // Plot Orientation
				true,			// Show Legend
				true,			// Use tooltips
				false			// Configure chart to generate URLs?
				);

		ChartUtilities.writeChartAsJPEG(new FileOutputStream(title + ".jpeg"),chart,600, 480);		

		XYPlot plot = (XYPlot) chart.getPlot(); 
					plot.setBackgroundPaint(Color.WHITE);
		
		
		plot.getRendererForDataset(plot.getDataset(0)).
					setSeriesPaint(0, Color.BLACK); 
		
		
		
		ChartPanel panel = new ChartPanel(chart);
		panel.setPreferredSize(new Dimension( 600, 480));
		JFrame f = new JFrame(title);
		f.add(panel);
		
		f.pack();
		f.setVisible(true);
		
		
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}		
		
	}
	
}
