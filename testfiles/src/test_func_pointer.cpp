int foo( int a )
{
    return a + 1;
}

int main( void )
{
    int local;
    int (*pfunc)(int) = foo;

    local = pfunc( 2 );

    return 0;
}