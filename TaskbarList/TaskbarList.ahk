/**************************************************************************************************************
class: TaskbarList
extends Unknown

Requirements:
	- This requires AHK_L v1.1
	- It also requires Windows 2000 Professional, Windows XP, Windows 2000 Server or higher
***************************************************************************************************************	
*/
class TaskbarList extends Unknown
	{
	/**************************************************************************************************************
	Variable: CLSID
	This is CLSID_TaskbarList. It is required to create the object.
	***************************************************************************************************************	
	*/
	static CLSID := "{56FDF344-FD6D-11d0-958A-006097C9A090}"
	
	/**************************************************************************************************************
	Variable: IID
	This is IID_ITaskbarList. It is required to create the object.
	***************************************************************************************************************	
	*/
	static IID := "{56FDF342-FD6D-11d0-958A-006097C9A090}"
	
	/**************************************************************************************************************
	Function: HrInit
	initializes the interface.

	Returns:
		bool success - true on success, false otherwise.
		
	Example:
>		ITBL.HrInit()
		
	Remarks:
		- This is required to work with ITaskbarList(1-4).
	***************************************************************************************************************	
	*/
	HrInit(){
		return this._Error(DllCall(NumGet(this.vt+03*A_PtrSize), "ptr", this.ptr))
		}
	
	/**************************************************************************************************************
	Function: AddTab
	adds a new item to the taskbar
	
	Parameters:
		handle hWin - the handle to the window to add.
		
	Returns:
		bool success - true on success, false otherwise.
		
	Example:
>	Gui +LastFound
>	ITBL.AddTab(WinExist())
	***************************************************************************************************************	
	*/
	AddTab(hWin){
		return this._Error(DllCall(NumGet(this.vt+04*A_PtrSize), "Ptr", this.ptr, "UInt", hWin))
		}
	
	/**************************************************************************************************************
	Function: DeleteTab
	deletes an item from the taskbar
	
	Parameters:
		handle hWin - the handle to the window to remove.
		
	Returns:
		bool success - true on success, false otherwise.
		
	Example:
>	ITBL.DeleteTab(WinExist("Notepad"))
	***************************************************************************************************************	
	*/
	DeleteTab(hWin){
		return this._Error(DllCall(NumGet(this.vt+05*A_PtrSize), "Ptr", this.ptr, "UInt", hWin))
		}
	
	/**************************************************************************************************************	
	Function: ActivateTab
	Activates an item on the taskbar.
	
	Parameters:
		handle hWin - the handle to the window whose item should be activated.
	
	Returns:
		bool success - true on success, false otherwise.
		
	Example:
>	ITBL.ActivateTab(WinExist("Mozilla Firefox"))

	Remarks:
		- The window is not actually activated; the window's item on the taskbar is merely displayed as active.
	***************************************************************************************************************	
	*/
	ActivateTab(hWin){
		return this._Error(DllCall(NumGet(this.vt+06*A_PtrSize), "Ptr", this.ptr, "UInt", hWin))
		}
	
	/**************************************************************************************************************	
	Function: SetActiveAlt
	Marks a taskbar item as active but does not visually activate it.

	Parameters:
		handle hWin - the handle to the window that should be marked as active.

	Returns:
		bool success - true on success, false otherwise.

	Example:
>	ITBL.SetActiveAlt(WinExist())

	Remarks:
		- SetActiveAlt marks the item associated with hwnd as the currently active item for the window's process without changing the pressed state of any item. Any user action that would activate a different tab in that process will activate the tab associated with hwnd instead. The active state of the window's item is not guaranteed to be preserved when the process associated with hwnd is not active. To ensure that a given tab is always active, call SetActiveAlt whenever any of your windows are activated. Calling SetActiveAlt with a NULL hwnd clears this state.
	***************************************************************************************************************	
	*/
	SetActiveAlt(hWin){
		return this._Error(DllCall(NumGet(this.vt+07*A_PtrSize), "Ptr", this.ptr, "UInt", hWin))
		}
	}