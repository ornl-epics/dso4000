#include <aSubRecord.h>
#include <registryFunction.h>
#include <epicsExport.h>

static long asub_computex(aSubRecord *prec)
{
    double xincr = ((double *) prec->a)[0];
    double scale = ((double *) prec->b)[0];
    double *va = (double *) prec->vala;
    int N = prec->nova;
    int i;

    printf("X Incr: %e\n", xincr);
    printf("Scale : %e\n", scale);
    printf("N     : %d\n", prec->nova);
    xincr *= scale;
    for (i=0; i<N; ++i)
        va[i] = i*xincr;
    return 0;
}

epicsRegisterFunction(asub_computex);

