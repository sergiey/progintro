namespace Task9._09;

internal class FibonacciNumber
{
    private int _prevNumber, _currentNumber;

    public int CurrentNumber { get => _currentNumber; }
    
    public FibonacciNumber()
    {
        _prevNumber = _currentNumber = 1;
    }

    public void Next()
    {
        var tmp = _currentNumber;
        _currentNumber = _prevNumber + _currentNumber;
        _prevNumber = tmp;
    }
}
