namespace Task10._02
{
    internal class Program
    {
        static void Main(string[] args)
        {
            var first = new B(1);
            var second = new B(2);
            first += 10;
            second += 1000;
            Console.WriteLine($"{first.Get} {second.Get}");
        }
    }
}