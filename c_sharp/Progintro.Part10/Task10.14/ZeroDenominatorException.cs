namespace Task10._14;

[Serializable]
internal class ZeroDenominatorException : Exception
{
    public ZeroDenominatorException()
    { }

    public ZeroDenominatorException(string message)
        : base(message)
    { }

    public ZeroDenominatorException(string message, Exception innerException)
        : base(message, innerException)
    { }
}
