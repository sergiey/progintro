﻿namespace Task10._08;

internal class Program
{
    static void Main(string[] args)
    {
        var n1 = new Rational(6, 2);
        Console.WriteLine($"To double {n1.ToDouble()}");
        var n2 = new Rational(1, 2);
        Console.WriteLine(
            $"{n2.Numerator}/{n2.Denominator} - " +
            $"{n1.Numerator}/{n1.Denominator} = " +
            $"{(n2 - n1).Numerator}/{(n2 - n1).Denominator}");
        Console.WriteLine(
            $"{n2.Numerator}/{n2.Denominator} + " +
            $"{n1.Numerator}/{n1.Denominator} = " +
            $"{(n2 + n1).Numerator}/{(n2 + n1).Denominator}");
        Console.WriteLine(n1.ToLong());

    }
}