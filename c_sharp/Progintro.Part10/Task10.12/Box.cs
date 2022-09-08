namespace Task10._12;

internal class Box : Prism
{
    private double _baseEdgeLength;

    public Box(double sideEdgeLength, double baseEdgeLength)
        : base(sideEdgeLength)
    {
        _baseEdgeLength = baseEdgeLength;
    }

    public override double Square()
    {
        return _baseEdgeLength * _baseEdgeLength;
    }
}
