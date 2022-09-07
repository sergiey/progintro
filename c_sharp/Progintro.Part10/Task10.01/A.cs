using System;

public class A
{
	private readonly int _index;

	public A(int index)
	{
		_index = index;
	}

	public int this[int @value]
	{
		get { return @value + _index; }
	}
}