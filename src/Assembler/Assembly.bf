using System;
using System.Collections;

using BES.Types;
using BES.Components;

namespace BES.Assembler;

class Assembly
{
	public Word startAddress;
	public String interruptLabel;
	public List<ASTNode> code;

	public this(String path, bool verbose = false)
	{
		var r = Parser.ReadLines(path, true);
		switch(r)
		{
		case .Ok(let val):
			(this.code, (this.startAddress, this.interruptLabel)) = val;
			if(verbose)
				Console.WriteLine($"Start Address will be {this.startAddress}");
		case .Err(let err):
			Console.WriteLine($"Error reading assembly: {err}");
		}

	}

	public ~this()
	{
		delete this.code;
	}

	public void Add(ASTNode a) => code.Add(a);

	public Byte[64 * 1024] Export(bool verbose = false)
	{
		Dictionary<String, Word> labels = scope .();
		if(verbose)
		{
			Console.WriteLine("\n\nAssembling\n");

			Console.WriteLine($".brk label: {this.interruptLabel}");
		}
		Byte[64 * 1024] r = .();
		Word i = this.startAddress - 1;

		//Console.WriteLine($"startpos: {startAddress}");

		r[CPU.resetVector] = (Byte)startAddress;
		//Console.WriteLine($"low byte: {r[CPU.resetVector]}");
		r[CPU.resetVector + 1] = (Byte)(startAddress >> 8);
		//Console.WriteLine($"high byte: {r[CPU.resetVector + 1]}");

		for (var inst in this.code)
		{
			i++;
			r[i] = inst.instruction;
			if (verbose)
				inst.Debug();
			if (!inst.label.IsEmpty)
				labels.Add(new .(inst.label), i);
			
			switch(inst.argument)
			{
			case .Byte(let b):
				 i++;
				r[i] = b;
			case .Word(let w):
				i++;
				r[i] = w.LowByte;
				i++;
				r[i] = w.HighByte;
			case .Label(let s):
				if(s.type == .Absolute)
					i+=2;
				else
					i++;
				
			case .None:
				if (inst.instruction == CPU.INS_BRK)
					i++; // padding byte
			}
		}
		i = this.startAddress - 1;



		for (var inst in this.code)
		{
			i++;
			switch(inst.argument)
			{
			case .Byte: i++;
			case .Word: i+=2;
			case .None:
			case .Label(let s):
				Word r2 = labels.GetValue(s.label);
				if (s.type == .Absolute)
				{
					i++;
					r[i] = r2.LowByte;
					i++;
					r[i] = r2.HighByte;
				}

				else if(s.type == .Relative)
				{
					
					SByte offset = SByte(r2 - i) - 2; // - 2 cause i is address  of bmi, it hasn't gone to after the argument + we go to return - 1
					i++;
					r[i] = (Byte)offset;
				}

			}
			delete inst;
		}

		var brk = labels.GetValue(this.interruptLabel);
		if (brk case .Ok(let ad))
		{
			if(verbose)
				Console.WriteLine($"interrupt address: {ad}");
			r[CPU.interruptVector] = ad.LowByte;
			r[CPU.interruptVector + 1] = ad.HighByte;
		}
		else
			if (verbose)
				Console.WriteLine("No .brk");

		for (var kv in labels)
			delete kv.key;
		delete interruptLabel;
		if (verbose)
			Console.WriteLine("Finished assembling\n");
		return r;
	}
}