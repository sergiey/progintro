namespace Task10._12;

internal abstract class Prism
{
    private double _height;

    public Prism(double height)
    {
        _height = height;
    }

    public abstract double Square();

    public double Volume()
    {
        return Square() * _height;
    }
}
