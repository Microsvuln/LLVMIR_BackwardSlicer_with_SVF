int main( void )
{
    int n = 1;
    int s;

    switch ( n ) {
    case 1:
        s = 1;
        break;
    case 2:
        s = 2;
        break;
    case 3:
    case 4:
        s = 7;
        break;
    default:
        s = 0;
    }


    return 0;
}