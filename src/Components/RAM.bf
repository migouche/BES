using System;
using System.IO;

using BES.Types;

namespace BES.Components;

public class RAM: IMemory
{
	const uint32 MAX_MEM = 64 * 1024; // 64 Kb
	private Byte[MAX_MEM] _data;
	public this
	{
		Initialize();
	}
	public void Initialize()
	{
		for (uint32 i = 0; i < MAX_MEM; i++)
			this._data[i] = 0xEA;
	}

	public Byte[65536] data{get => _data;}

	public Byte GetByte(Word i)
	{
		return this._data[i];
	}

	public void WriteByte(Byte val, Word i)
	{
		this[i] = val;
	}


	public Byte this[Word i]
	{
		get => _data[i];
		set mut => _data[i] = value;
	}

	public void WriteWord(Word val, Word addr, ref int cycles)
	{
		//Console.WriteLine($"Writing word {val} at address {addr}...");
		this.WriteWord(val, addr);
		cycles -= 2;
	}

	public void WriteWord(Word val, Word addr) // Should not be used
	{
		//Console.WriteLine($"Writing word {val} at address {addr}...");
		this[addr] = (Byte)val;
		this[addr + 1] = (Byte)(val >> 8);
	}

	public Word GetWord(Word address)
	{
		Byte lByte = this[address];
		Byte hByte = this[address + 1];
		return lByte | ((Word)hByte << 8);
	}

	public void HardLoadProgram(Byte[MAX_MEM] m) mut
	{
		this._data = m;
	}

	public Result<void, String> HardLoadProgram(String path) mut
	{
		if(!File.Exists(path))
		{
			return .Err("File not found");
		}

		var code = File.ReadAll(path, ..scope .());
		Word i = 0;
		for (var b in code)
		{
			this[i] = b;
			i++;
		}
		return .Ok;
	}

	public static Result<void, String> DisassembleToHex(String input, String output, int instructionsPerLine = 10)
	{
		if(!File.Exists(input))
		{
			return .Err("File not found");
		}

		BufferedFileStream f = scope .();
		var r = f.Create(output);
		if (r case .Err(let err))
			return .Err(err.ToString(..scope .()));
		var code = File.ReadAll(input, ..scope .());
		int i = 0;
		for(var b in code)
		{

			f.Write(scope $"{b:X2} ");
			if (i % instructionsPerLine == 0)
				f.Write('\n');
			i++;
		}
		f.Close();
		return .Ok;
	}
}