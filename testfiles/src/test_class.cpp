class A {
public:
    int mNumPtr;
};

int main( void )
{
    int n = 2;
    A *objA = new A;
    A *objB = new A;

    objA->mNumPtr = 2;
    objA->mNumPtr += n;
    objB->mNumPtr = 2;
    objB->mNumPtr += n;

    return 0;
}