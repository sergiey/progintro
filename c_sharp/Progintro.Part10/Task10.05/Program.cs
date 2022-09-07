namespace Task10._05
{
    internal class Program
    {
        static void Main(string[] args)
        {
            var m1 = new M();
            Console.WriteLine($"{m1[1, 1]} {m1[2, 2]} {m1[2, 3]}");
            var m2 = new M();
            m1[2, 3] = 7;
            m2[2, 3] = 350;
            var m3 = m1 + m2;
            Console.WriteLine($"{m3[1, 1]} {m3[2, 2]} {m3[2, 3]}");
        }
    }
}