namespace Task10._15;

internal class Program
{
    static void Swap3<T>(ref T x, ref T y, ref T z)
    {
        T tmp = x;
        x = y;
        y = z;
        z = tmp;
    }

    static void Main(string[] args)
    {
        int a = 3, b = 5, c = 1;
        Console.WriteLine($"a = {a} b = {b} c = {c}");
        Swap3(ref a, ref b, ref c);
        Console.WriteLine($"a = {a} b = {b} c = {c}");
    }
}