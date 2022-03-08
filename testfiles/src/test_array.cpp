int main( void )
{
    int *a;
    a = new int[4];
    a[0] = 1;
    a[1] = 2;
    a[2] = 3;
    a[3] = 4;

    for ( int i = 0; i < 4; i ++ ) {
        a[i] = i;
    }

    return 0;
}