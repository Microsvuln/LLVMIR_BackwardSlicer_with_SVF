void foo( int a )
{
    int b = a + 1;
}

int main( void )
{
    void (*pfunc)(int) = foo;

    pfunc( 2 );

    return 0;
}