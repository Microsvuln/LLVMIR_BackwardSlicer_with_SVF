int swap( int &a, int &b )
{
  int temp; 
  temp = a; 
  a = b;
  b = temp; 
  return 1;
}
void bar(){
  int a = 1, b = 2;
  swap(a,b);
}

int main( void )
{
  int a = 1, b = 2;
  bar();
  swap(a,b);
  return 0;
}
