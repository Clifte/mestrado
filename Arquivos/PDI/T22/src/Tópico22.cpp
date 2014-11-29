#include "opencv2/highgui/highgui.hpp"
#include "opencv2/imgproc/imgproc.hpp"
#include "opencv2/core/core.hpp"
#include <iostream>
#include <stdio.h>

using namespace cv;
using namespace std;

Mat src;
Mat dst;
int u, w;
uchar v;

int lb,hb;
int range = 10;

void CallBackFunc(int event, int x, int y, int flags, void* userdata) {
	if (event == EVENT_LBUTTONDOWN) {
		cout << "Posição do click (" << x << ", " << y << ")" << endl;

		u = x;
		w = y;

		v = ((int)src.at<uchar>(y, x));

		lb = (v - range) < 0 ? 0:(v-range);
		hb = (v + range) > 255 ? 255:(v+range);

		cout <<" V " << v
			 << "LB: " << lb
			 << " HB: " << hb << endl;

	}else if (event == EVENT_RBUTTONDOWN) {
		exit(0);
	}
}

int main(int argc, char** argv) {
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



	while (true) {

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
		src = imread(file.c_str(), 0);

		dst = imread(file.c_str(), 0);


		namedWindow("Source", CV_WINDOW_AUTOSIZE);
		namedWindow("Destiny", CV_WINDOW_AUTOSIZE);
		setMouseCallback("Source", CallBackFunc, NULL);


		inRange(src,Scalar(lb),Scalar(hb),dst);
		floodFill(dst, Point(u, w), Scalar(128));
		inRange(dst,Scalar(127),Scalar(129),dst);

		add(src,dst,dst);

		imshow("Destiny", dst);
		imshow("Source", src);

		waitKey(1);

	}

	return 0;

}
