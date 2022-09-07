namespace Task10._03;

internal class Program
{
    static void Main(string[] args)
    {
        var x = new D();
        var y = new D(x);
        var z = new D(y);
        Console.WriteLine($"{x.Prop} {y.Prop} {z.Prop}");
    }
}