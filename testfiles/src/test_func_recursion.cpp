int foo( int a )
{
    if ( a > 100 )
    {
        return a;
    }

    return foo( a ) + 1;
}

int main( void )
{
    int result;
    result = foo ( 1 );

    return 0;
}