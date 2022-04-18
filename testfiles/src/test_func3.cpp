void foo( int *fa, int &fb )
{
    int local = 10;
    local += 1;
    *fa += 1;
    *fa = local;
    fb = *fa + local;
}

int main( void )
{
  int a = 1, b = 2;
  foo( &a, b );
  return 0;
}
