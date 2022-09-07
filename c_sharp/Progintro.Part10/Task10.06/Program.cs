namespace Task10._06;

internal class Program
{
    static void Main(string[] args)
    {
        var e = new E();
        Console.WriteLine($"{e[0,0]} {e[100, 100]} {e[-10, -10]}");
        Console.WriteLine($"{e[1500,7]} {e[7, 55]} {e[-8, -16]}");
    }
}