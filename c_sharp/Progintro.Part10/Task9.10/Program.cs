namespace Task9._10;

internal class Program
{
    static void Main(string[] args)
    {
        const int MaxItems = 90;
        var p = new PascalsTriangle();
        Console.Write($"({p.LineNumber}, {p.ItemNumber}, {p.Combination}), ");
        for (var i = 0; i < MaxItems; i++)
        {
            p.Next();
            if (i != MaxItems - 1)
                Console.Write(", ");
        }
    }
}