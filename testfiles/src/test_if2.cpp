int main( void ) 
{
    int a;
    int b;

    a = 1;
    if ( a == 1 ) {
        if ( b == 3 ) {
            a = 2;
        }
        else {
            a = 3;
        }

        if ( a == 0 ) {
            if ( a > 1 ) {
                a = 2;
            }
            else {
                a = 3;
            }
            b = 2;
        }
        else {
            int c;
            b = 4;
            c = 5;
        }

        b = 5;
    }
    else {
        b = 6;
    }
    return 0;
}