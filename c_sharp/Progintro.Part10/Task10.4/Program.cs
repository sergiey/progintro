namespace Task10._04;

internal class Program
{
    static void Main(string[] args)
    {
        var m1 = new M();
        Console.WriteLine($"{m1[new I(1, 1)]} {m1[new I(2, 2)]} " +
            $"{m1[new I(2, 3)]}");
        var m2 = new M();
        m1[new I(2, 3)] = 7;
        m2[new I(2, 3)] = 350;
        var m3 = m1 + m2;
        Console.WriteLine($"{m3[new I(1, 1)]} {m3[new I(2, 2)]} " +
            $"{m3[new I(2, 3)]}");
    }
}