namespace Task10._11
{
    internal class Program
    {
        static void Main(string[] args)
        {
            var a = new Cube(2, 10);
            var b = new Cube(5, 0.1);
            var c = new Tetrahedron(6, 2.5);
            Console.WriteLine($"Volumes: {a.Volume:N3} {b.Volume:N3} {c.Volume:N3}");
            Console.WriteLine($"Weights: {a.Mass():N3} {b.Mass():N3} {c.Mass():N3}");
        }
    }
}