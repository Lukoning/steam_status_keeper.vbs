' Copyright (c) 2025 Lukoning (https://github.com/Lukoning)
vbsName = "Steam Status Keeper"
Set shell = CreateObject("WScript.Shell")
Set file = CreateObject("Scripting.FileSystemObject")
shell.CurrentDirectory = file.GetParentFolderName(WScript.ScriptFullName)

msgAfterRun = "如要结束状态，请在 Steam 内单击""停止""按钮。"

' 接受命令行参数
Set objArgs = WScript.Arguments

' 运行程序
If objArgs.Count > 0 Then
    ' 检查程序是否存在
    If Not file.FileExists(objArgs(0)) Then
        MsgBox "要启动的游戏程序 "&objArgs(0)&" 不存在。"_
        , vbCritical, "Target game not found." & " - " & vbsName
    Else
        ' 第一个参数是程序本体
        program = Chr(34) & objArgs(0) & Chr(34)
        parameters = ""
        ' 将后续参数传递给程序
        If objArgs.Count > 1 Then
            parameters = objArgs(1)
            For i = 2 To objArgs.Count - 1
                parameters = parameters & " " & objArgs(i)
            Next
        End If
        ' 使用start命令创建新进程，这样不受Steam停止游戏的影响
        shell.Run "cmd /c start """" /B " & program &" "& parameters, 0, False
        msgAfterRun = "已启动游戏进程: " &vbCrLf& objArgs(0) &vbCrLf& msgAfterRun
    End If
End If

MsgBox msgAfterRun, vbInformation, vbsName

Do While True
    WScript.Sleep 100000
Loop