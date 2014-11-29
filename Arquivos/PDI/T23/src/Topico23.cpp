#include "opencv2/highgui/highgui.hpp"
#include "opencv2/imgproc/imgproc.hpp"
#include "opencv2/core/core.hpp"
#include <iostream>
#include <stdio.h>

using namespace cv;
using namespace std;
int K = 5;
int x = 1;

void CallBackFunc(int event, int x, int y, int flags, void* userdata) {
     if  ( event == EVENT_LBUTTONDOWN ) {
    	 K++;
    	 cout << "Incrementendo K: " << K << " " << endl;
     } else if  ( event == EVENT_RBUTTONDOWN ) {
    	 K--;
    	 if (K < 1) {
    		 K = 1;
    	 }
    	 cout << "K Decreased to: " << K << " " << endl;
     } else if  ( event == EVENT_MBUTTONDOWN ) {
         x = 0;
     }
}

int main() {



	Mat src;



	int opcao = 1;
	cout << "Crescimento de regiões:" << endl;
	cout << "---------------------------" << endl;
	cout << "Botao esquerdo do mouse para escolher local da semente:" << endl;
	cout << "Botão direito do mouse para encerra a aplicação" << endl;
	cout << "---------------------------" << endl;
	cout << "Escolha uma imagem:" << endl;
	cout << "1: camera" << endl;
	cout << "2: house" << endl;
	cout << "3: lena" << endl;
	cin >> opcao;

	int kant = 0;
	while (x == 1) {
		if(kant==K){
			cvWaitKey(200);
			continue;
		}
		kant = K;



		string file;
		switch (opcao) {
			case 1:
				file = "Images/camera.png";
				break;
			case 2:
				file = "Images/house.png";
				break;
			default:
				file = "Images/lena.png";
				break;
		}


		src = imread(file.c_str(), 1);
		imshow("original", src);
		setMouseCallback("original", CallBackFunc, NULL);



		blur(src, src, Size(9, 9));

		Mat data = Mat::zeros(src.cols * src.rows, 5, CV_32F);
		Mat bestLabels, centers, clustered;
		vector<Mat> bgr;
		cv::split(src, bgr);


		for (int i = 0; i < src.cols * src.rows; i++) {

			data.at<float>(i, 0) = (i / src.cols) / src.rows; //Adicionando nº linha normalizada
			data.at<float>(i, 1) = (i % src.cols) / src.cols; //Adicionando nº  coluna normalizada
			data.at<float>(i, 2) = bgr[0].data[i] / 255.0;	   //adicionando valores RGB normalizados
			data.at<float>(i, 3) = bgr[1].data[i] / 255.0;
			data.at<float>(i, 4) = bgr[2].data[i] / 255.0;
		}

		TermCriteria criteria =TermCriteria( CV_TERMCRIT_EPS + CV_TERMCRIT_ITER, 50, 0.1);

		cv::kmeans(data, K, bestLabels,
				   criteria, 3,
				   KMEANS_PP_CENTERS, centers);

		int colors[K];
		for (int i = 0; i < K; i++) {
			colors[i] = (255 / K) * i ;
		}

		clustered = Mat(src.rows, src.cols, CV_32F);

		for (int i = 0; i < src.cols * src.rows; i++) {
			clustered.at<float>(i / src.cols, i % src.cols) =
					(float) (colors[bestLabels.at<int>(0, i)]);
		}

		clustered.convertTo(clustered, CV_8U);
		imshow("clustered", clustered);

	}
	return 0;
}
