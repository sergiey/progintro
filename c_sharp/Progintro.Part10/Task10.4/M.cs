namespace Task10._4;

internal class M
{
    public const int MaxColumns = 3;
    public const int MaxRows = 3;
    private int[,] _matrix = new int[MaxColumns, MaxRows]
    {
        { 1, 0, 0 },
        { 0, 1, 0 },
        { 0, 0, 1 }
    };

    public int this[I index]
    {
        set
        {
            if (IsInRange(index))
                _matrix[index.Column - 1, index.Row - 1] = value;
            else
                throw new IndexOutOfRangeException();
        }
        get
        {
            if (IsInRange(index))
                return _matrix[index.Column - 1, index.Row - 1];
            else
                throw new IndexOutOfRangeException();
        }
    }

    public static M operator +(M a, M b)
    {
        var m = new M();
        for (var i = 1; i <= MaxColumns; i++)
            for (var j = 1; j <= MaxRows; j++)
                m[new I(i, j)] = a[new I(i, j)] + b[new I(i, j)];
        return m;
    }

    private bool IsInRange(I index)
    {
        if ((index.Column >= 1 && index.Column <= 3) &&
            (index.Row >= 1 && index.Row <= 3))
            return true;
        else
            return false;
    }
}
