namespace Task9._10;

internal class PascalsTriangle
{
    public int LineNumber { get; private set; }
    public int ItemNumber { get; private set; }
    public int Combination { get; private set; }

    public PascalsTriangle()
    {
        LineNumber = ItemNumber = 0;
        Combination = 1;
    }

    public void Next()
    {
        if (LineNumber == ItemNumber)
        {
            LineNumber++;
            ItemNumber = 0;
        }
        else
            ItemNumber++;
        Combination = GetCombination(LineNumber, ItemNumber);
        Console.Write($"({LineNumber}, {ItemNumber}, {Combination})");
    }

    private int GetCombination(int lineNumber, int itemNumber)
    {
        if (itemNumber > lineNumber)
            throw new Exception("Item number cannot be more than line number");
        if (itemNumber == 0 || lineNumber == itemNumber)
            return 1;
        return GetCombination(lineNumber - 1, itemNumber - 1) +
            GetCombination(lineNumber - 1, itemNumber);
    }
}
