namespace Task10._12
{
    internal class Program
    {
        static void Main(string[] args)
        {
            var a = new Box(0.5, 2);
            var b = new Box(5, 0.2);
            var c = new Cube(0.5);
            Console.WriteLine($"Squares: {a.Square():N3} {b.Square():N3} {c.Square():N3}");
            Console.WriteLine($"Volumes: {a.Volume():N3} {b.Volume():N3} {c.Volume():N3}");
        }
    }
}