int foo1( int a )
{
    return a + 1;
}

int foo2( int a )
{
    return foo1( a ) + 1;
}

int foo3( int a )
{
    if ( a > 100 )
    {
        return a;
    }

    return foo2( a ) + 1;
}

int main( void )
{
    int result;
    result = foo3( 1 );

    return 0;
}