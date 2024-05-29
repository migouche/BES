using System;

namespace BES.Types;

struct Bit: IFormattable
{
	public bool bit;

	public this(bool a) => this.bit = a;
	

	public this(Byte a)
	{
		if (a == 0)
			this.bit = false;
		else
			this.bit = true;
	}

	public static operator Bit (Byte a) => .(a);

	public static operator Bit(bool b) => .(b);

	public static operator bool(Bit b) => b.bit;

	public static operator Byte(Bit b) => b.bit ? 1: 0;

	public void ToString(String outString, String format, IFormatProvider formatProvider)
	{
		uint8 v = bit ? 1: 0;
		v.ToString(outString, format, formatProvider);
	}
}
