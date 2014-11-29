#include "opencv2/highgui/highgui.hpp"
#include "opencv2/imgproc/imgproc.hpp"
#include <stdio.h>
#include <iostream>

using namespace cv;
using namespace std;

int main(int argc, char** argv) {

	int opcao;
	cout << "Escolha uma imagem:" << endl;
	cout << "1: coins" << endl;
	cout << "2: stairs" << endl;
	cin >> opcao;

	string file;
	switch (opcao) {
		case 1:
			file = "Images/coins.jpg";
			break;
		default:
			file = "Images/stairs.jpg";
			break;
	}

	Mat src = imread(file.c_str(), 0);
	Mat src_gray;

	Mat dst, cdst;

	Canny(src, dst, 100, 125, 3);
	imshow("Canny", dst);
	cvtColor(src, cdst, CV_GRAY2BGR);


	vector<Vec4i> lines;
	HoughLinesP(dst, lines, 1, CV_PI / 180, 3, 40, 3);

	for (size_t i = 0; i < lines.size(); i++) {
		Vec4i l = lines[i];
		line(cdst, Point(l[0], l[1]), Point(l[2], l[3]), Scalar(0, 0, 255), 3,
		CV_AA);
	}



	imshow("Source", src);
	imshow("Hough Line", cdst);

	src_gray = src.clone();

	/// Reduce the noise so we avoid false circle detection
	GaussianBlur(src_gray, src_gray, Size(9, 9), 2, 2);

	vector<Vec3f> circles;

	/// Apply the Hough Transform to find the circles
	HoughCircles(src_gray, circles, CV_HOUGH_GRADIENT, 1, src_gray.rows / 20, 125, 60, 0, 0);

	cout << circles.size() << " circulos encontrados" << endl;
	/// Draw the circles detected
	for (size_t i = 0; i < circles.size(); i++) {
		Point center(cvRound(circles[i][0]), cvRound(circles[i][1]));
		int radius = cvRound(circles[i][2]);
		// circle center
		circle(src, center, 3, Scalar(0, 255, 0), -1, 8, 0);
		// circle outline
		circle(src, center, radius, Scalar(0, 0, 255), 3, 8, 0);
	}

	/// Show your results
	namedWindow("Hough Circle Transform Demo", CV_WINDOW_AUTOSIZE);

	imshow("Hough Circle Transform Demo", src);

	waitKey(0);

	return 0;
}
