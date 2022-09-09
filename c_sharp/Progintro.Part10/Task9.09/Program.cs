namespace Task9._09
{
    internal class Program
    {
        static void Main(string[] args)
        {
            var n = new FibonacciNumber();
            Console.Write($"{n.CurrentNumber} ");
            for (var i = 0; i <= 10; i++)
            {
                Console.Write($"{n.CurrentNumber} ");
                n.Next();
            }
        }
    }
}