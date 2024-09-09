'----------------------------------------------------------------------------------------------------------------------------------
' CITRA IT - EXCELÊNCIA EM TI
' Script para Instalação Automática do Sophos Endpoint Intercept X
' @Autor: luciano@citrait.com.br
' @Data: 07/11/2021  Versão 1.0
'----------------------------------------------------------------------------------------------------------------------------------
Option Explicit
On Error Resume Next



'----------------------------------------------------------------------------------------------------------------------------------
' HELP FUNCTIONS
'----------------------------------------------------------------------------------------------------------------------------------

' Function NotifyTelegram
' Notifies a telegram chat with some text
' @ input String bot ID - ID of telegram bot that will send the message
' @ input String Chat ID - ID of the chat as target to send the message
' @ input String sText - the text to submit to the chat
' @ output Void
Function NotifyTelegram(ByVal BotId, ByVal ChatId, ByVal sText)
	Dim http
	Set http = CreateObject("WinHttp.WinHttpRequest.5.1")
	http.Open "GET", "https://api.telegram.org/bot" & BotId & "/sendMessage?chat_id=" & ChatId & "&parse_mode=HTML&text=" & sText
	http.SetRequestHeader "Content-Type", "application/x-www-form-urlencoded"
	http.Send
End Function


' Function GetComputerName
' Get local computer name
' @ input void
' @ output String Computername
Function GetComputerName()
	Dim objNetwork
	Set objNetwork = CreateObject("WScript.Network")
	GetComputerName = objNetwork.Computername
End Function


'----------------------------------------------------------------------------------------------------------------------------------
' MAIN SCRIPT ROUTINE
'----------------------------------------------------------------------------------------------------------------------------------
Dim wshShell
Dim SophosInstallerPath
DIm SophosCmdArgs
Dim ThisComputername
Dim BotId
Dim ChatId
Dim ReturnCode

SophosInstallerPath = "\\DEPLOY-SERVER\SHARE$\Sophos\SophosSetup.exe"
SophosCmdArgs = "--quiet --products=antivirus,intercept"

' User defined Variables
BotId = "<MY_TELEGRAM_BOT_ID>"
ChatId = "<MY_TELEGRAM_CHAT_ID>"

' Notifying on telegram the start of installation
ThisComputername = GetComputerName
NotifyTelegram BotId, ChatId, "<pre>Starting Sophos Endpoint installation on computer  <b>" & ThisComputername & vbCrLf & vbCrLf & "</b></pre>"
Set wshShell = CreateObject("WScript.Shell")
ReturnCode = wshShell.Run(SophosInstallerPath & " " & SophosCmdArgs, 1, 1)

' Evaluating result code from installer
Dim message
If ReturnCode = 0 Then
	message = "<pre>Sophos successfully installed on endpoint <b>" & ThisComputername & vbCrLf & vbCrLf & "</b></pre>"
	NotifyTelegram BotId, ChatId, message
Else
	message = "<pre>Sophos failed to install on endpoint <b>" & ThisComputername & vbCrLf & vbCrLf & "</b></pre>"
	NotifyTelegram BotId, ChatId, message
End If

