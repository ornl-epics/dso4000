#include <aSubRecord.h>
#include <registryFunction.h>
#include <epicsExport.h>

static long asub_compute_x(aSubRecord *prec)
{
    double xincr = ((double *) prec->a)[0];
    double scale = ((double *) prec->b)[0];
    double *va = (double *) prec->vala;
    int N = prec->nova;
    int i;

    /*
    printf("X Incr: %e\n", xincr);
    printf("Scale : %e\n", scale);
    printf("N     : %d\n", prec->nova);
    */

    xincr *= scale;
    for (i=0; i<N; ++i)
        va[i] = i*xincr;
    return 0;
}

epicsRegisterFunction(asub_compute_x);


static long asub_compute_y(aSubRecord *prec)
{
    double mult = ((double *) prec->a)[0];
    signed char *raw = (signed char *) prec->b;
    double *va = (double *) prec->vala;
    int N = prec->nova;
    int i;

    for (i=0; i<N; ++i)
        va[i] = raw[i]*mult;
    return 0;

}

epicsRegisterFunction(asub_compute_y);
