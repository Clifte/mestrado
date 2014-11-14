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
static void calculaKmeans(alglib::real_2d_array data, int n, alglib::real_2d_array &mcs);
static void calculaRBF(alglib::real_2d_array &data, alglib::real_2d_array &mc, double sigma, real_2d_array &res);


int mainRBF(int arg, char **argv){
	puts("Iniciando");
	int n = 50;

	alglib::real_2d_array data;
	double *_data = new double[n*2];
	data.setcontent(n,2,_data);

	//Criando dados função f(x)=x
	for (int i = 0; i < data.rows(); i++) {
		data(i,0) = i;
		data(i,1) = i*i*5;
	}

	puts("Chamando kmeans");
	alglib::real_2d_array mcs;
	calculaKmeans(data,10,mcs);

	puts("Chamando o RBF");
	alglib::real_2d_array rbfOut;
	calculaRBF(data,mcs, 100, rbfOut);
	puts(rbfOut.tostring(3).c_str());


	puts("Executando OLAN");
	alglib::real_2d_array olanOut;
	//x * W = y
	//x / y = W;
	//x * y" = W
	//x * (y*y')" * y = W

	puts("Fim");

}



int testaInversa(int arg, char **argv)
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
static void calculaPIV(alglib::real_2d_array &data, alglib::real_2d_array &res){
	real_2d_array s,vt;
	real_1d_array w;
	real_2d_array W;

	alglib::rmatrixsvd(
		data,
	    data.rows(),
	    data.cols(),
	    2,
	    2,
	    2,
	    w,
	    s,
	    vt);

	puts(w.tostring(2).c_str());
	puts(s.tostring(2).c_str());
	puts(vt.tostring(2).c_str());


	ae_int_t info;
	matinvreport rep;

	rmatrixinverse(s, info, rep);
	puts(s.tostring(2).c_str());

	alglib::real_2d_array qM;
	qM.setlength(vt.rows(),s.cols());


	rmatrixgemm(vt.rows(), s.cols(), vt.cols(),
				1,
				vt, 0, 0, 0,
				s, 0, 0, 0,
				1, qM, 0, 0);

	puts(qM.tostring(2).c_str());
	W.setcontent(w.length(),1,w.getcontent());
	rmatrixgemm(qM.rows(), W.cols(), qM.cols(),
					1,
					qM, 0, 0, 0,
					W, 0, 0, 1,
					1, qM, 0, 0);

}
static void calculaPIV2(alglib::real_2d_array &data, alglib::real_2d_array &res){
	//A' * inv(A * A')

	int m = data.rows(),
		n = data.rows();
	int k = data.cols();

	alglib::real_2d_array qM;
	qM.setlength(m,n);

	puts("A");
	puts(data.tostring(2).c_str());
	rmatrixgemm(m, n, k,
				1, data, 0, 0, 0,
				data, 0, 0, 1,
				1, qM, 0, 0);

	puts("A * A'");
	puts(qM.tostring(2).c_str());


	ae_int_t info;
	matinvreport rep;
    alglib::real_2d_array inv(qM);

    rmatrixinverse(inv, info, rep);
    puts("inverse");
    puts(inv.tostring(2).c_str());




    puts("pseudoInverse");
    res.setlength(m,n);
    rmatrixgemm(m, n, k,
    			1, data, 0, 0, 1,
    			inv, 0, 0, 0,
    			1, res, 0, 0);
    puts(res.tostring(2).c_str());
}

int main(int argc, char **argv) {
	alglib::real_2d_array data("[[1 , 2],[3 , 4],[5 , 6]]");
	//alglib::real_2d_array data("[[5 , 0, 0],[0 , 5, 0],[0 , 0, 5]]");
	//alglib::real_2d_array data("[[1 , 0, 0],[0 , 1, 0]]");
	alglib::real_2d_array res;
	calculaPIV(data,res);
}


static void calculaRBF(alglib::real_2d_array &data, alglib::real_2d_array &mc, double sigma, real_2d_array &res){

	double a = 0;


	double *_res = new double[data.rows()];
	res.setcontent(data.rows(),1,_res);

	double p = 0;
	for(int i=0;i< data.rows();i++){

		for (int j = 0; j < mc.rows(); ++j) {
			double e = 0;
			for(int k=0;k<mc.cols();k++){
				e += ((data(i,k) - mc(j,k) ) *  (data(i,k) - mc(j,k)));
			}
			e = e / (2 * sigma);
			//a = 1 / (sigma * sqr(2 * pow(  2*pi()  ,  mc.cols()  )));
			//p = a * exp(-e);
			p = exp(-e);
			res(i,1) = p;
		}

	}

}


static void calculaKmeans(alglib::real_2d_array data, int n, real_2d_array &mc){

	double a = 0;

	double *_mc = new double[n * (data.cols())];
	mc.setcontent(n, data.cols(),_mc);



	int *labels = new int[data.rows()];
	double *dists = new double[data.rows()];
	int *counters = new int[n];

	//Iniciando vetor de medias
	for (int j = 0; j < mc.rows(); ++j) {
		for(int k=0;k<mc.cols();k++){
			mc(j,k) = data(j,k);
		}
	}




	for(int ite=0;ite<50;ite++){
		printf("Iteracao: %d\n", ite);

		//Iniciando contadores
		for (int j = 0; j < mc.rows(); ++j) {
			counters[j] = 0;
		}

		//inicializando distancias
		for (int j = 0; j < data.rows(); ++j) {
			dists[j] = maxrealnumber;
		}


		for(int i=0;i< data.rows();i++){
			for (int j = 0; j < mc.rows(); ++j) {
				double e = 0;

				for(int k=0;k<mc.cols();k++){
					e += ((data(i,k) - mc(j,k) ) *  (data(i,k) - mc(j,k)));
				}

				if(dists[i] > e){
					labels[i] = j;
					dists[i] = e;
				}

			}
		}

		//Atualizando valores da média
		for(int i=0;i< data.rows();i++){

			counters[labels[i]]++;

			if(counters[labels[i]]==1){
				for(int k=0;k<mc.cols();k++){
					mc(labels[i],k) = 0;
				}
			}
			for(int k=0;k<mc.cols();k++){
				mc(labels[i],k) += data(i,k);
			}
		}

		for (int j = 0; j < mc.rows(); ++j) {
			for(int k=0;k<mc.cols();k++){
				mc(j,k) = mc(j,k) / counters[j];
			}
		}
	}
}



