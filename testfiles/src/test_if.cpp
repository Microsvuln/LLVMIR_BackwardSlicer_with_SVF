int main( void )
{
    int n = 1;
    int s = 2;

    if ( n == 1 ) {
        s = 1;
    }
    else {
        s = 2;
    }

    if ( n == 1 && s == 2 ) {
        s = 1;
    }
    else if ( n == 1 ){
        s = 2;
    }
    else {
        s = 3;
    }

    return 0;
}