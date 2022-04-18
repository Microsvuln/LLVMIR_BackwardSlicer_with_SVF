void swap( int &a, int &b )
{
  int temp; 
  temp = a; 
  a = b;
  b = temp; 
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
