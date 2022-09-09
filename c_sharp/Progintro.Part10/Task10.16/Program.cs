namespace Task10._16
{
    internal class Program
    {
        public static T GetAndZero<T>(ref T b)
        {
            T a = b;
            b = (dynamic)0;
            return a;
        }
        static void Main(string[] args)
        {
            int b = 3;
            int a = GetAndZero(ref b);
            Console.WriteLine($"a = {a} b = {b}");
            double d = 3.9;
            double c = GetAndZero(ref d);
            Console.WriteLine($"c = {c} d = {d}");
        }
    }
}