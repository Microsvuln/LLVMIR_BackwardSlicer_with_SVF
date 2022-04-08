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
    foo ( 1 );

    return 0;
}