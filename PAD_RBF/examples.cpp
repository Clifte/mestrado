#include <math.h>
#include "alglibinternal.h"
#include "alglibmisc.h"
#include "linalg.h"
#include "statistics.h"
#include "dataanalysis.h"
#include "specialfunctions.h"
#include "solvers.h"
#include "optimization.h"
#include "diffequations.h"
#include "fasttransforms.h"
#include "integration.h"
#include "interpolation.h"

using namespace alglib;

int main(int arg, char **argv)
{
	int m = 1000;
	int n = 1000;

	clock_t t1, t2, t3;
	double elapsed;
	ae_int_t info;
	matinvreport rep;


	//Inicializando matriz
	double *_r2 = new double[ m * n ];
	for(int i=0;i<m;i++){
		for(int j=0;j<n;j++){
			_r2[ i * m + j ] = (i + j) * (i - j) * (i*j);
		}
	}


	alglib::real_2d_array mat;
    mat.setcontent(m,n,_r2);




    //Calculando inversa
    t1 = clock();
    alglib::real_2d_array inv(mat);
    rmatrixinverse(inv, info, rep);
    t2 = clock();
    elapsed = ((double) (t2 - t1)) / CLOCKS_PER_SEC;
    printf("Time rmatrixinverse: %.4f\n", double(elapsed));


    return 0;
}


static alglib::real_2d_array calculaRBF(alglib::real_2d_array data, alglib::real_2d_array mc, double sigma){

	double a = 0;

	real_2d_array res;
	double *_res = new double[data.rows()];
	res.setcontent(data.rows(),1,_res);

	for(int i=0;i< data.rows();i++){

		for (int j = 0; j < mc.rows(); ++j) {
			double e = 0;
			for(int k=0;k<mc.cols();k++){
				e += ((data(i,k) - mc(j,k) ) *  (data(i,k) - mc(j,k)));
			}
			e = e / (2 * sigma);
			a = 1 / (sigma * sqr(2 * pow(  2*pi()  ,  mc.cols()  )));
			res(i,1) = a * exp(-e);
		}

	}

	return res;
}


