namespace Task10._05;

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

    public int this[int col, int row]
    {
        set
        {
            if (IsInRange(col, row))
                _matrix[col - 1, row - 1] = value;
            else
                throw new IndexOutOfRangeException();
        }
        get
        {
            if (IsInRange(col, row))
                return _matrix[col - 1, row - 1];
            else
                throw new IndexOutOfRangeException();
        }
    }

    public static M operator +(M a, M b)
    {
        var m = new M();
        for (var i = 1; i <= MaxColumns; i++)
            for (var j = 1; j <= MaxRows; j++)
                m[i, j] = a[i, j] + b[i, j];
        return m;
    }

    private bool IsInRange(int col, int row)
    {
        if ((col >= 1 && col <= 3) &&
            (row >= 1 && row <= 3))
            return true;
        else
            return false;
    }
}
