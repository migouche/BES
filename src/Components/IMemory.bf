using System;
using BES.Types;

namespace BES.Components;

public interface IMemory
{
	public Byte GetByte(Word address);
	public void WriteByte(Byte val, Word address) mut;
	public Word GetWord(Word address);
	public void WriteWord(Word val, Word address) mut;


	public Byte[] data{ get; };

	public Byte this[Word i]{get; set;};
}