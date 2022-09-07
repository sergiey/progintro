namespace Task10._01;

internal class Program
{
    static void Main(string[] args)
    {
        var first = new A(1);
        var second = new A(10);
        Console.WriteLine($"first: {first[100]} {first[200]}");
        Console.WriteLine($"second: {second[100]} {second[200]}");
    }
}