#include <WinAPISysWin.au3>
#include <Array.au3>

; Constants
Const $INTERVAL = 1
Const $ATTACK_KEY = 'x'

; Bind Actions
HotKeySet('!q', 'Stop')
HotKeySet('x', 'SpamX')

; Global Variable
Global $continue = True
Global $instances[0] = []

; Tooltip
ToolTip('Dragonica Spam X - Alt+q to quit', 0, 0)

; Main Loop
While $continue
   For $i = 0 To UBound($instances) - 1
	  SendI($ATTACK_KEY, $i)
   Next
   Sleep($INTERVAL) ; preserve CPU
WEnd

; Functions
Func Stop ()
   $continue = 0
EndFunc

Func SpamX ()
   Local $title = '[TITLE:' & WinGetTitle('[ACTIVE]') & ']'
   ;ConsoleWrite($title & @CRLF)
   If StringInStr($title, 'Dragon') Then ; Just Dragon to  so it should works on DragonSaga too (not tested)
	  Local $pos = _ArraySearch($instances, $title)
	  if $pos <> -1 Then
		 _ArrayDelete($instances, $pos)
	  Else
		 _ArrayAdd($instances, $title)
	  EndIf
   EndIf
EndFunc

Func SendI ($command, $i)
   ControlSend($instances[$i], '', '', $command)
EndFunc
