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

	clock_t start, end;
	double elapsed;

	int m = 1000;
	int n = 1000;

	//Inicializando matriz
	double *_r2 = new double[ m * n ];
	for(int i=0;i<m;i++){
		for(int j=0;j<n;j++){
			_r2[ i * m + j ] = (i==j) ? 4:0;
		}
	}


	alglib::real_2d_array a;
    a.setcontent(m,n,_r2);
    ae_int_t info;
    matinvreport rep;


    //Calculando inversa
    start = clock();
    rmatrixinverse(a, info, rep);
    end = clock();
    elapsed = ((double) (end - start)) / CLOCKS_PER_SEC;

    printf("Time%.4f\n", double(elapsed)); // EXPECTED: 0.5
    return 0;
}
