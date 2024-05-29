using System;
using BES.Components;
namespace BES.Tests;

class M6502CPUTests
{
	[Test]
	public static void Test0Cycles()
	{
		RAM mem = scope .();
		CPU cpu = scope CPU(mem);

		int cyclesNeeded = 0;
		int c = cpu.Execute(cyclesNeeded);
		Test.Assert(c == cyclesNeeded);
	}
}