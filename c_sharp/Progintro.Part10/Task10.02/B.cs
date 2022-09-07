namespace Task10._02;

internal class B
{
    private readonly int _index;

    public int Get
    {
        get { return _index; }
    }

    public B(int value)
    {
        _index = value;
    }

    public static B operator +(B a, int b)
    {
        return new B(a.Get + b);
    }
}
