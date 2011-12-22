/*
class: WIN32_FIND_DATA
Contains information about the file that is found by an API method.

Further documentation:
	- *msdn* (http://msdn.microsoft.com/en-us/library/windows/desktop/aa365740)
*/
class WIN32_FIND_DATA
{
	/*
	Field: dwFileAttributes
	The file attributes of a file. You may use the fields of the FILE_ATTRIBUTE class for convenience.
	*/
	dwFileAttributes := 0

	/*
	Field: ftCreationTime
	A FILETIME instance that specifies when a file or directory was created.
	*/
	ftCreationTime := new FILETIME()

	/*
	Field: ftLastAccessTime
	A FILETIME instance. For a file, the structure specifies when the file was last read from, written to, or for executable files, run. For a directory, the structure specifies when the directory is created. If the underlying file system does not support last access time, this member is zero. On the FAT file system, the specified date for both files and directories is correct, but the time of day is always set to midnight.
	*/
	ftLastAccessTime := new FILETIME()

	/*
	Field: ftLastWriteTime
	A FILETIME instance. For a file, the structure specifies when the file was last written to, truncated, or overwritten. The date and time are not updated when file attributes or security descriptors are changed. For a directory, the structure specifies when the directory is created.
	*/
	ftLastWriteTime := new FILETIME()

	/*
	Field: nFileSizeHigh
	The high-order DWORD value of the file size, in bytes. This value is zero unless the file size is greater than MAXDWORD.
	The size of the file is equal to
	> (nFileSizeHigh * (MAXDWORD+1)) + nFileSizeLow

	Remarks:
		MAXDWORD is defined as 0xffffffff (which is 4294967295).
	*/
	nFileSizeHigh := 0

	/*
	Field: nFileSizeLow
	The low-order DWORD value of the file size, in bytes.
	*/
	nFileSizeLow := 0

	/*
	Field: dwReserved0
	If the dwFileAttributes member includes the FILE_ATTRIBUTE_REPARSE_POINT attribute, this member specifies the reparse point tag. Otherwise, this value is undefined and should not be used.
	*/
	dwReserved0 := 0

	/*
	Field: dwReserved1
	Reserved for future use.
	*/
	dwReserved1 := 0

	/*
	Field: cFileName
	The name of the file.
	*/
	cFileName := ""

	/*
	Field: cAlternateFileName
	An alternative name for the file. This name is in the classic 8.3 file name format.
	*/
	cAlternateFileName := ""

	/*
	Method: ToStructPtr
	converts the instance to a script-usable struct and returns its memory adress.

	Parameters:
		[opt] UPTR ptr - the fixed memory address to copy the struct to.

	Returns:
		UPTR ptr - a pointer to the struct in memory
	*/
	ToStructPtr(ptr := 0)
	{
		static struct

		if (!ptr)
		{
			VarSetCapacity(struct, 636, 0)
			ptr := &struct
		}

		NumPut(this.dwFileAttributes,	1*ptr, 00,	"UInt")
		this.ftCreationTime.ToStructPtr(ptr + 04)
		this.ftLastAccessTime.ToStructPtr(ptr + 12)
		this.ftLastWriteTime.ToStructPtr(ptr + 20)
		NumPut(this.nFileSizeHigh,		1*ptr,	28,	"UInt")
		NumPut(this.nFileSizeLow,		1*ptr,	32,	"UInt")
		NumPut(this.dwReserved0,		1*ptr,	36,	"UInt")
		NumPut(this.dwReserved1,		1*ptr,	40,	"UInt")
		StrPut(this.cFileName,			ptr + 44,	260,	"UTF-16")
		StrPut(this.cAlternateFileName,	ptr + 608,	14,		"UTF-16")

		return ptr
	}

	/*
	Method: FromStructPtr
	(static) method that converts a script-usable struct into a new instance of the class

	Parameters:
		UPTR ptr - a pointer to a WIN32_FIND_DATA struct in memory

	Returns:
		WIN32_FIND_DATA instance - the new WIN32_FIND_DATA instance
	*/
	FromStructPtr(ptr)
	{
		instance := new WIN32_FIND_DATA()

		instance.dwFileAttributes	:= NumGet(1*ptr,	00,	"UInt")
		instance.ftCreationTime		:= FILETIME.FromStructPtr(ptr + 04)
		instance.ftLastAccessTime	:= FILETIME.FromStructPtr(ptr + 12)
		instance.ftLastWriteTime	:= FILETIME.FromStructPtr(ptr + 20)
		instance.nFileSizeHigh		:= NumGet(1*ptr,	28,	"UInt")
		instance.nFileSizeLow		:= NumGet(1*ptr,	32,	"UInt")
		instance.dwReserved0		:= NumGet(1*ptr,	36,	"UInt")
		instance.dwReserved1		:= NumGet(1*ptr,	40,	"UInt")
		instance.cFileName			:= StrGet(ptr + 44,	260, "UTF-16")
		instance.cAlternateFileName	:= StrGet(ptr + 608, 14, "UTF-16")

		return instance
	}
}