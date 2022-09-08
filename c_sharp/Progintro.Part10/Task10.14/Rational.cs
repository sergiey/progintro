namespace Task10._14;

internal class Rational
{
    public long Numerator { private set; get; }
    public long Denominator { private set; get; }

    public Rational(long numerator, long denominator)
    {
        if (denominator == 0)
            throw new ZeroDenominatorException("Denominator cannot be zero");
        Numerator = numerator;
        Denominator = denominator;
    }

    private Rational() { }

    public static Rational operator +(Rational num1, Rational num2)
    {
        var res = new Rational();
        res.Numerator = num1.Numerator * num2.Denominator +
            num2.Numerator * num1.Denominator;
        res.Denominator = num1.Denominator * num2.Denominator;
        return res;
    }

    public static Rational operator -(Rational num1, Rational num2)
    {
        var res = new Rational();
        res.Numerator = num1.Numerator * num2.Denominator -
            num2.Numerator * num1.Denominator;
        res.Denominator = num1.Denominator * num2.Denominator;
        return res;
    }

    public static Rational operator *(Rational num1, Rational num2)
    {
        return new Rational(num1.Numerator * num2.Numerator,
            num1.Denominator * num2.Denominator);
    }

    public static Rational operator /(Rational num1, Rational num2)
    {
        throw new NotImplementedException();
    }

    public double ToDouble()
    {
        return (double)Numerator / (double)Denominator;
    }

    public long ToLong()
    {
        return Numerator / Denominator;
    }
}
