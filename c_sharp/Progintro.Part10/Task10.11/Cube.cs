namespace Task10._11;

internal class Cube : Body
{
    private double _edgeLength;

    public override double Volume 
    {
        get => _volume;
    }

    public Cube(double edgeLength, double density) : base(density)
    {
        _edgeLength = edgeLength;
        _volume = _edgeLength * _edgeLength * _edgeLength;
    }
}
