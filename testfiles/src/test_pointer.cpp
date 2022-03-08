int main ( void )
{
    int n = 1;
    int *np = &n;
    int **npp = &np;

    int *rp = &n;

    **(npp) = 2;
    npp = &rp;
    **(npp) = 3;

    for ( int i = 0; i < 4; i ++ ) {
        if ( i % 2 == 0 ) {
            npp = &rp;
            **(npp) = 4;
        }
        else {
            npp = &np;
            **(npp) = 5;
        }
    }

    int n1 = 6, n2 = 7;
    int **a = new int*[2];
    a[0] = &n1;
    a[1] = &n2;
    *a[0] = 8;
    *a[1] = 9;
/*
    int *a = new int[2];
    np = a;
    *np = 4;
    np += 1;
    *np = 5;

    a[0] = 6;
    a[1] = 7;

    for ( int i = 0; i < 2; i ++ ) {
        a[i] = 8;
    }
*/
    return 0;
}