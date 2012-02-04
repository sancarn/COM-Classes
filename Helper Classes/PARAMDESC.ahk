﻿/*
class: PARAMDESC
a structure class that contains information needed for transferring a structure element, parameter, or function return value between processes.

Authors:
	- maul.esel (https://github.com/maul-esel)

License:
	- *LGPL* (http://www.gnu.org/licenses/lpgl-2.1.txt)

Documentation:
	- *class documentation* (http://maul-esel.github.com/COM-Classes/master/PARAMDESC)
	- *msdn* (http://msdn.microsoft.com/en-us/library/windows/desktop/ms221089%28v=VS.85%29.aspx)

Requirements:
	AutoHotkey - AHK v2 alpha
	OS - (unknown)
	Base classes - _CCF_Error_Handler_, StructBase
	Helper classes - PARAMDESCEX, PARAMFLAG
	Other classes - CCFramework
*/
class PARAMDESC extends StructBase
{
	/*
	Field: pparamdescex
	If PARAMFLAG.FHASDEFAULT is specified in <wParamFlags>, this is a PARAMDESCEX structure with the default value.

	Remarks:
		You may set this either to an instance of the PARAMDESCEX class or to a raw memory pointer.
	*/
	pparamdescex := 0

	/*
	Field: wParamFlags
	The parameter flags. You may use the fields of the PARAMFLAG class for convenience.
	*/
	wParamFlags := 0

	/*
	Method: constructor
	creates a new instance of the class

	Parameters:
		[opt] USHORT flags - the initial value for the <wParamFlags> field.
		[opt] PARAMDESCEX value - the initial for the <pparamdescex> field, either as memory pointer or class instance.
	*/
	__New(flags := 0, value := 0)
	{
		this.flags := flags, this.value := value
	}

	/*
	Method: ToStructPtr
	converts the instance to a script-usable struct and returns its memory adress.

	Parameters:
		[opt] PTR ptr - the fixed memory address to copy the struct to.

	Returns:
		PTR ptr - a pointer to the struct in memory
	*/
	ToStructPtr(ptr := 0)
	{
		if (!ptr)
		{
			ptr := this.Allocate(this.GetRequiredSize())
		}

		this.pparamdescex.ToStructPtr(ptr)
		NumPut(this.wParamFlags, 1*ptr, 20, "UShort")

		return ptr
	}

	/*
	Method: FromStructPtr
	(static) method that converts a script-usable struct into a new instance of the class.

	Parameters:
		PTR ptr - a pointer to a PARAMDESC struct in memory

	Returns:
		PARAMDESC instance - the new PARAMDESC instance
	*/
	FromStructPtr(ptr)
	{
		local instance := new PARAMDESC(NumGet(1*ptr, 20, "UShort"), PARAMDESCEX.FromStructPtr(ptr))
		instance.SetOriginalPointer(ptr)
		return instance
	}

	/*
	Method: GetRequiredSize
	calculates the size a memory instance of this class requires.

	Parameters:
		[opt] OBJECT data - an optional data object that may cotain data for the calculation.

	Returns:
		UINT bytes - the number of bytes required

	Remarks:
		- This may be called as if it was a static method.
		- The data object is ignored by this class.
	*/
	GetRequiredSize(data := "")
	{
		return PARAMDESCEX.GetRequiredSize() + 2
	}
}