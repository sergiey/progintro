namespace Task10._03;

internal class D
{
    public int Prop { private set; get; }

    public D()
    {
        Prop = 0;
    }

    public D(D instance) :this()
    {
        Prop = instance.Prop + 1;
    }
}
