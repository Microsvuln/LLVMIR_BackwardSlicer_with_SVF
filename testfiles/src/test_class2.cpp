class B {
public:
    int mB1;
    int mB2;
    int mB3;
    int mB4;
};

class A {
public:
    int mA1;
    int mA2;
    int mA3;
    int mA4;
    B *objB;
};

class C {
public:
    int c;
};

class D : public C {
public:
    double d;
};

class E : public C {
public:
    int i1;
    int i2;
};

int main ( void )
{
    A a;
    a.mA1 = 1;
    a.mA2 = 2;
    a.mA3 = 3;
    a.mA4 = 4;
    a.mA1 = 11;
    a.mA2 = 22;
    a.mA3 = 33;
    a.mA4 = 44;
    a.objB = new B;

    a.objB->mB1 = 5;
    a.objB->mB2 = 6;
    a.objB->mB3 = 7;
    a.objB->mB4 = 8;
    a.objB->mB1 = 9;
    a.objB->mB2 = 10;
    a.objB->mB3 = 11;
    a.objB->mB4 = 12;

    A *pa = new A;
    pa->mA1 = 1;
    pa->mA2 = 2;
    pa->mA3 = 3;
    pa->mA4 = 4;

    pa->objB = new B;
    pa->objB->mB1 = 5;
    pa->objB->mB2 = 6;
    pa->objB->mB3 = 7;
    pa->objB->mB4 = 8;

    D *objd = new D;
    E *obje = new E;

    C *pc = objd;
    pc->c = 1;

    pc = obje;
    pc->c = 2;

    return 0;
}