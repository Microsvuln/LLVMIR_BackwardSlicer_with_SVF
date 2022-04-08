void foo( int &a, int *b)
{
    a += 3;
    *b += 4;
}

int main( void )
{
    int n1 = 1;
    int n2 = 2;

    foo( n1, &n2 );

    return 0;
}