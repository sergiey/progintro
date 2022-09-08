namespace Task10._11;

internal abstract class Body
{
    private readonly double _density;
    protected double _volume;
    
    public virtual double Volume { get; }

    public double Mass() => _density * Volume;

    public Body(double density)
    {
        _density = density;
    }

}
