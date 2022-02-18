class A {
public:
    void foo( int *a );
    void bar( int *a );
    int *mNumPtr;
};

void A::foo( int *a )
{
    int *foo_local = a;
    *mNumPtr = *foo_local;
}

void A::bar( int *a )
{
    int *foo_a = a;
    foo( foo_a );
}

int main( void )
{
    int n = 2;
    A *objA = new A;

    objA->bar( &n );

    return 0;
}