struct structA {
    int a;
    double b;
    int *pa;
    double *pb;
    structA *psta;
};

int integer( int a, int &b, int *c )
{
    return a + b + *c;
}

double floating( double a, double &b, double *c )
{
    return a + b + *c;
}

void structure( structA a, structA &b, structA *c )
{

}

int main( void )
{
    int local = 1;
    double f = 1.0;
    structA s;

    local = integer( local, local, &local );
    f = floating( f, f, &f );
    structure( s, s, &s );
    return 0;
}