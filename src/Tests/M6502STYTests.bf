using System;
using BES.Components;
namespace BES.Tests;

class M6502STYTests
{
	// no flags checks
	[Test]
	public static void STYZeroPage()
	{
		RAM mem = scope .();
		CPU cpu = scope CPU(mem);
		cpu.Y = 0x37;

		mem[0xFFFC] = CPU.INS_STY_ZP;
		mem[0xFFFD] = 0x15;

		int cyclesNeeded = 3;
		int c = cpu.Execute(cyclesNeeded);

		Test.AssertEq(cpu.Y, mem[0x15]);
		Test.AssertEq(cyclesNeeded, c);
	}

	[Test]
	public static void STYZeroPageX()
	{
		RAM mem = scope .();
		CPU cpu = scope CPU(mem);
		cpu.Y = 0x37;
		cpu.X = 0x07;

		mem[0xFFFC] = CPU.INS_STY_ZPX;
		mem[0xFFFD] = 0x15;

		int cyclesNeeded = 4;
		int c = cpu.Execute(cyclesNeeded);

		Test.AssertEq(cpu.Y, mem[0x15 + cpu.X]);
		Test.AssertEq(cyclesNeeded, c);
	}

	[Test]
	public static void STYAbsolute()
	{
		RAM mem = scope .();
		CPU cpu = scope CPU(mem);
		cpu.Y = 0x37;

		mem[0xFFFC] = CPU.INS_STY_ABS;
		mem[0xFFFD] = 0x42;
		mem[0xFFFE] = 0x43; //0x4342

		int cyclesNeeded = 4;
		int c = cpu.Execute(cyclesNeeded);

		Test.AssertEq(cpu.Y, mem[0x4342]);
		Test.AssertEq(c, cyclesNeeded);
	}

}