#include <vector>

int main( void )
{
    int n = 1; 
    int a;

    a = n > 0 ? 1 : 2 ;
    a = (-a);
    -a;

    std::vector<int> v;
    v.push_back( a );
    v.push_back( a );
    v[0] = 3;
    v[1] = 4;

    return 0;
}