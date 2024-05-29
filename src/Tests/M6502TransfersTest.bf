using System;
using BES.Components;
namespace BES.Tests;

class M6502TransfersTest
{
	public static void TestFlags(CPU cpu, bool z, bool n)
	{

		Test.AssertEq(cpu.Z, z);
		Test.AssertEq(cpu.N, n);
		// all other should be zero
		Test.Assert(!(cpu.C || cpu.I || cpu.D || cpu.B || cpu.V));

	}

	[Test]
	public static void TestTXA()
	{
		RAM mem = scope .();
		CPU cpu = scope CPU(mem);

		cpu.X = 0xFE;

		mem[0xFFFC] = CPU.INS_TXA;

		int cyclesNeeded = 2;
		int c = cpu.Execute(cyclesNeeded);

		Test.AssertEq(cpu.X, cpu.A);
		Test.AssertEq(c, cyclesNeeded);
		TestFlags(cpu, false, true);
	}

	[Test]
	public static void TestTAX()
	{
		RAM mem = scope .();
		CPU cpu = scope CPU(mem);

		cpu.A = 0xFE;

		mem[0xFFFC] = CPU.INS_TAX;

		int cyclesNeeded = 2;
		int c = cpu.Execute(cyclesNeeded);

		Test.AssertEq(cpu.X, cpu.A);
		Test.AssertEq(c, cyclesNeeded);
		TestFlags(cpu, false, true);
	}

	[Test]
	public static void TestTYA()
	{
		RAM mem = scope .();
		CPU cpu = scope CPU(mem);

		cpu.Y = 0xFE;

		mem[0xFFFC] = CPU.INS_TYA;

		int cyclesNeeded = 2;
		int c = cpu.Execute(cyclesNeeded);

		Test.AssertEq(cpu.Y, cpu.A);
		Test.AssertEq(c, cyclesNeeded);
		TestFlags(cpu, false, true);
	}

	[Test]
	public static void TestTAY()
	{
		RAM mem = scope .();
		CPU cpu = scope CPU(mem);

		cpu.A = 0xFE;

		mem[0xFFFC] = CPU.INS_TAY;

		int cyclesNeeded = 2;
		int c = cpu.Execute(cyclesNeeded);

		Test.AssertEq(cpu.Y, cpu.A);
		Test.AssertEq(c, cyclesNeeded);
		TestFlags(cpu, false, true);
	}

	[Test]
	public static void TestTXS()
	{
		RAM mem = scope .();
		CPU cpu = scope CPU(mem);

		cpu.X = 0x37;

		mem[0xFFFC] = CPU.INS_TXS;

		int cyclesNeeded = 2;
		int c = cpu.Execute(cyclesNeeded);

		Test.AssertEq(cpu.X, cpu.SP);
		Test.AssertEq(c, cyclesNeeded);
	}

	
	[Test]
	public static void TestTSX()
	{
		RAM mem = scope .();
		CPU cpu = scope CPU(mem);

		cpu.SP = 0x37;

		mem[0xFFFC] = CPU.INS_TSX;

		int cyclesNeeded = 2;
		int c = cpu.Execute(cyclesNeeded);

		Test.AssertEq(cpu.X, cpu.SP);
		Test.AssertEq(c, cyclesNeeded);
		TestFlags(cpu, false, false);
	}
}