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


void CallBackFunc(int event, int x, int y, int flags, void* userdata) {
	if (event == EVENT_LBUTTONDOWN) {

		cout << "Posição do click (" << x << ", " << y << ")" << endl;

		u = x;
		w = y;


	} else if (event == EVENT_RBUTTONDOWN) {
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
	cout << "1: Borboleta" << endl;
	cout << "2: Camelo" << endl;
	cout << "3: Morcego" << endl;
	cin >> opcao;

	while (true) {
		string file;
		switch (opcao) {
			case 1:
				file = "Images/butterfly.png";
				break;
			case 2:
				file = "Images/camel.png";
				break;
			default:
				file = "Images/bat.png";
				break;
		}
		src = imread(file.c_str(), 1);
		dst = imread(file.c_str(), 1);

		namedWindow("Source", CV_WINDOW_AUTOSIZE);

		setMouseCallback("Source", CallBackFunc, NULL);

		if (u != 0 && w != 0) {
			namedWindow("Destiny", CV_WINDOW_AUTOSIZE);
			floodFill(dst, Point(u, w), Scalar(36.0, 28.0, 237.0));
			imshow("Destiny", dst);
		}

		imshow("Source", src);

		waitKey(1);

	}

	return 0;

}

