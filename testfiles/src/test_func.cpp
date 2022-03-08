int foo( int a )
{
    return a + 1;
}

int main( void )
{
    int local = 1;

    local = foo( local );
    return 0;
}