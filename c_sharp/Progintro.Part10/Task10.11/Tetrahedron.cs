namespace Task10._11;

internal class Tetrahedron : Body
{
    private double _edgeLength;

    public override double Volume
    {
        get => _volume;
    }

    public Tetrahedron(double edgeLength, double density) : base(density)
    {
        _edgeLength = edgeLength;
        _volume = Math.Sqrt(2) * _edgeLength  * _edgeLength * _edgeLength / 12;
    }
}
