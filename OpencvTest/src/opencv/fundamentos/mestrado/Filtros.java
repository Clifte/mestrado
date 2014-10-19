package opencv.fundamentos.mestrado;

import java.util.Arrays;
import java.util.Iterator;

import opencv.util.gui.base.ImageFrameView;
import opencv.util.gui.base.Plot;

import org.omg.CORBA.IMP_LIMIT;
import org.opencv.core.Core;
import org.opencv.core.CvType;
import org.opencv.core.Mat;
import org.opencv.core.Scalar;
import org.opencv.core.Size;
import org.opencv.highgui.Highgui;
import org.opencv.imgproc.Imgproc;

public class Filtros {

	private static Mat media(Mat source) {
		System.loadLibrary(Core.NATIVE_LIBRARY_NAME);

		// Criacao de Matriz temporaria
		Mat tmp = new Mat(source.rows(), source.cols(), source.type());
		Mat destination = new Mat(source.rows(), source.cols(), source.type());

		// Criacao do kernel para executar a convolucao
		Mat kernel = Mat.ones(new Size(7, 7), CvType.CV_32F);
		Core.multiply(kernel,
				new Scalar((float) 1 / (kernel.rows() * kernel.cols())), kernel);

		// Executando a convolucao
		Imgproc.filter2D(source, destination, -1, kernel);

		// Salvando imagem apos a execucao da media
		Highgui.imwrite(kernel.rows() + "X" + kernel.cols() + ".jpeg", destination);

		return destination;
	}

	private static Mat gaussiano(Mat source) {

		Mat destination = new Mat(source.rows(), source.cols(), source.type());

		double sigma = 2;

		Mat kernel = Imgproc.getGaussianKernel(3, sigma, CvType.CV_32F);
		// Produto de matrizes para gerar a mascara 2D
		// O processo pode ser otimizado realizando a operação
		// em cada dimensão separadamente
		Core.gemm(kernel, kernel.t(), 1, 
				  Mat.zeros(3, 3, CvType.CV_32F), 0,
				  kernel);


		Imgproc.filter2D(source, destination, -1, kernel);

		return destination;
	}

	private static void mediana(Mat source, Mat destination, int aw, int ah) {

		// Pegando raster da imagem
		int size = (int) (source.total() * source.channels());
		byte[] temp = new byte[size];
		byte[] destAr = new byte[size];
		source.get(0, 0, temp);

		int ar[] = new int[aw * ah];

		int index = 0;
		int cont = 0;
		int w = aw / 2;
		int h = ah / 2;

		for (int i = 0; i < source.cols(); i++) {
			for (int j = 0; j < source.rows(); j++) {

				cont = 0;
				for (float a = -w; a <= w; a++) {
					for (float b = -h; b <= h; b++) {
						index = (int) ((j + b) * source.cols() + i + a);

						if (index < 0 || index >= temp.length)
							ar[cont] = 0;
						else {
							ar[cont] = temp[index];
						}
						cont++;
					}
				}

				index = j * source.cols() + i;

				//ordenando para pegar o valor da mediana
				Arrays.sort(ar);
				//Alocando na nova imagem
				destAr[index] = (byte) ar[ar.length / 2];

			}
			byte b = temp[i];

		}

		destination.put(0, 0, destAr);
		//Highgui.imwrite("mediana " + ah + "X" + aw + ".jpeg", destination);
	}

	private static Mat laplace(Mat source,int tipo) {

		if(tipo==4){
			Mat laplace4 = new Mat(source.rows(), source.cols(), CvType.CV_32F);
			//Inicializando mascara
			Mat laplace4K = new Mat(new Size(3, 3), CvType.CV_32F);
			double laplace4KData[] = { 0, -1, 0, -1, 4, -1, 0, -1, 0 };
			laplace4K.put(0, 0, laplace4KData);
			//Executando convolucao
			Imgproc.filter2D(source, laplace4, CvType.CV_32F, laplace4K);
			return laplace4;
		}else{
			Mat laplace8 = new Mat(source.rows(), source.cols(), CvType.CV_32F);
			//Inicializando mascara
			Mat laplace8k = new Mat(new Size(3, 3), CvType.CV_32F);
			double laplace8kData[] = { -1, -1, -1, -1, 8, -1, -1, -1, -1 };
			laplace8k.put(0, 0, laplace8kData);
			//Executando convolucao
			Imgproc.filter2D(source, laplace8, CvType.CV_32F, laplace8k);
			return laplace8;	
		}
	}

	private static Mat[] prewit(Mat source) {

		Mat m = new Mat();
		Mat destinationDx = new Mat(source.rows(), source.cols(), CvType.CV_32F);
		Mat destinationDy = new Mat(source.rows(), source.cols(), CvType.CV_32F);
		Mat destination = new Mat(source.rows(), source.cols(), CvType.CV_32F);

		
		Mat kernelDx = new Mat(new Size(3, 3), CvType.CV_32F);
		Mat kernelDy = new Mat(new Size(3, 3), CvType.CV_32F);
		
		double kernelDxData[] = { -1, -1, -1, 0, 0, 0, 1, 1, 1 };
		double kernelDyData[] = { -1, 0, 1, -1, 0, 1, -1, 0, 1 };
		
		kernelDx.put(0, 0, kernelDxData);
		kernelDy.put(0, 0, kernelDyData);
		
		
		Imgproc.filter2D(source, destinationDx, CvType.CV_32F, kernelDx);
		Imgproc.filter2D(source, destinationDy, CvType.CV_32F, kernelDy);

		
		// Calculando a matriz resultante para o filtro de prewit
		Core.multiply(destinationDx, destinationDx, destinationDx);
		Core.multiply(destinationDy, destinationDy, destinationDy);
		Core.add(destinationDx, destinationDy, destination);
		Core.pow(destination, 0.5, destination);

		Core.normalize(destination, destination, 0, 255, Core.NORM_MINMAX);

		//retornando matrizes
		Mat res[] = new Mat[3];
		res[0] = destinationDx;
		res[1] = destinationDy;
		res[2] = destination;
		return res;
	}

	private static Mat[] sobel(Mat source) {

		//Alocando dados iniciais
		Mat m = new Mat();
		Mat destinationDx = new Mat(source.rows(), source.cols(), CvType.CV_32F);
		Mat destinationDy = new Mat(source.rows(), source.cols(), CvType.CV_32F);
		Mat destination = new Mat(source.rows(), source.cols(), CvType.CV_32F);

		
		//Criando mascara vertical e horizontal
		double kernelDxData[] = { -1, -2, -1, 0, 0, 0, 1, 2, 1 };
		double kernelDyData[] = { -1, 0, 1, -2, 0, 2, -1, 0, 1 };
		
		Mat kernelDx = new Mat(new Size(3, 3), CvType.CV_32F);
		Mat kernelDy = new Mat(new Size(3, 3), CvType.CV_32F);
		
		kernelDx.put(0, 0, kernelDxData);
		kernelDy.put(0, 0, kernelDyData);
		
		//Executando convolucao para calcular componente vertical e horizontal
		Imgproc.filter2D(source, destinationDx, CvType.CV_32F, kernelDx);
		Imgproc.filter2D(source, destinationDy, CvType.CV_32F, kernelDy);

		
		// Calculando a matriz resultante para o filtro de prewit
		Core.multiply(destinationDx, destinationDx, destinationDx);
		Core.multiply(destinationDy, destinationDy, destinationDy);
		Core.add(destinationDx, destinationDy, destination);
		Core.pow(destination, 0.5, destination);

		//Normalizando magnitude
		Core.normalize(destination, destination, 0, 255, Core.NORM_MINMAX);

		//retornando matrizes
		Mat res[] = new Mat[3];
		res[0] = destinationDx;
		res[1] = destinationDy;
		res[2] = destination;
		return res;
	}

	private static void limiarizacao(int limiar, Mat source, Mat destination) {
		int size = (int) (source.total() * source.channels());

		// Raster da imagem
		byte[] temp = new byte[size];
		source.get(0, 0, temp);

		// Realizando limiarizacao
		for (int i = 0; i < temp.length; i++) {
			if (((int) temp[i] & 0xFF) >= limiar)
				temp[i] = (byte) 255;
			else
				temp[i] = 0;
		}

		destination.put(0, 0, temp);
	}

	/*
	 * @limiar Array na forma [l1 l2 l3 ... l4]. Os limites definirão os intervalos da
	 * limiarização e o valor colocado é o valor do limite inferior. 
	 * */
	private static void multilimiarizacao(int[] limiar, Mat source, Mat destination) {
		int size = (int) (source.total() * source.channels());

		// Raster da imagem
		byte[] temp = new byte[size];
		source.get(0, 0, temp);

		// Realizando limiarizacao
		int v = 0;
		
		for (int i = 0; i < temp.length; i++) {
			v = (int) temp[i] & 0xFF;

			for (int j = 1; j < limiar.length; j++) {
				
				if (v >= limiar[j - 1] && v <= limiar[j]) {
					
					temp[i] = (byte) ((limiar[j - 1] + limiar[j]) / 2);
				}
			}
		}

		destination.put(0, 0, temp);
	}
	

	private static int[] histograma(Mat source) {

		// Raster da imagem
		int size = (int) (source.total() * source.channels());
		byte[] temp = new byte[size];
		source.get(0, 0, temp);

		// Calculando histograma
		int[] H = new int[256];
		for (int i = 0; i < H.length; i++) {
			H[i] = 0;
		}

		for (int i = 0; i < temp.length; i++) {
			H[(int) temp[i] & 0xFF]++;
		}

		return H;
	}

	private static void equaliza(Mat source, Mat destination) {

		int Hl[] = new int[256];
		int H[] = histograma(source);

		// Raster da imagem
		int size = (int) (source.total() * source.channels());
		byte[] temp = new byte[size];
		source.get(0, 0, temp);

		// Calculando função acumulativa não normalizada
		int sum = 0;

		for (int i = 0; i < Hl.length; i++) {
			sum += H[i];
			Hl[i] = sum;
		}
		Plot.showChart(Hl, "funcão acumulativa");

		// Equalizando
		for (int i = 0; i < temp.length; i++) {
			temp[i] = (byte) ((float) Hl[(int) temp[i] & 0xFF] / sum * 255);
		}

		destination.put(0, 0, temp);

	}

	public static void histogramaTest() {
		// Carregando imagem e a libOpencv
		System.loadLibrary(Core.NATIVE_LIBRARY_NAME);
		Mat m = new Mat();
		Mat source = Highgui.imread("/home/clifte/Imagens/pivete.JPG",
					 Highgui.CV_LOAD_IMAGE_GRAYSCALE);
		Mat destination = new Mat(source.rows(), source.cols(), CvType.CV_8U);

		int H[] = histograma(source);
		Plot.showChart(H, "histograma original");

		equaliza(source, destination);

		ImageFrameView.showResult("Original", source);
		ImageFrameView.showResult("Destination", destination);

		H = histograma(destination);
		Plot.showChart(H, "histograma resultante");
		Highgui.imwrite("equalizada.jpeg", destination);
	}

	public static void limiarizacaoTeste() {
		int limiar = 200;
		// Carregando imagem e a libOpencv
		System.loadLibrary(Core.NATIVE_LIBRARY_NAME);

		Mat source = Highgui.imread("/home/clifte/Imagens/pivete.JPG",
				Highgui.CV_LOAD_IMAGE_GRAYSCALE);
		Mat destination = new Mat(source.rows(), source.cols(), CvType.CV_8U);

		limiarizacao(limiar, source, destination);
		ImageFrameView.showResult("Original", source);
		ImageFrameView.showResult("Destination", destination);
		Highgui.imwrite( limiar + "Destination.jpeg", destination);
	}

	public static void multilimiarizacaoTeste() {
		int limiar[] = { 0, 32, 64, 98, 255};
		// Carregando imagem e a libOpencv
		System.loadLibrary(Core.NATIVE_LIBRARY_NAME);

		Mat source = Highgui.imread("/home/clifte/Imagens/pivete.JPG",
				Highgui.CV_LOAD_IMAGE_GRAYSCALE);
		Mat destination = new Mat(source.rows(), source.cols(), CvType.CV_8U);

		multilimiarizacao(limiar, source, destination);

		ImageFrameView.showResult("Original", source);
		ImageFrameView.showResult("Destination", destination);
		Highgui.imwrite( (Arrays.toString(limiar) + "Destination.jpeg").replace("[","").replace("]", "").replace(" ","").replace(",","l"),
				destination);
	}

	public static void medianaTeste() {

		// Carregando imagem e a libOpencv
		System.loadLibrary(Core.NATIVE_LIBRARY_NAME);

		Mat source = Highgui.imread(
				"/home/clifte/Imagens/resoltion chart smaller.JPG",
				Highgui.CV_LOAD_IMAGE_GRAYSCALE);
		Mat destination = new Mat(source.rows(), source.cols(), CvType.CV_8U);

		mediana(source, destination, 1, 7);

		ImageFrameView.showResult("Original", source);
		ImageFrameView.showResult("Destination", destination);
	}

	public static void main(String[] args) {
		/*
		System.loadLibrary(Core.NATIVE_LIBRARY_NAME);
		Mat source = Highgui.imread("/home/clifte/Imagens/orangeG.jpg",
				Highgui.CV_LOAD_IMAGE_GRAYSCALE);
		Mat res = media(source);
		ImageFrameView.showResult("source", source);
		ImageFrameView.showResult("Destination", res);
		
		*/
		limiarizacaoTeste();
	}
}
