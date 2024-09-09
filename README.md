# VBS_Deploy_Sophos_Endpoint
## Script vbs para realizar instalação do Sophos Endpoint Intercept X, via Política de Grupo.

* Crie uma Política de Grupo com uma tarefa agendada para ser executada imediatamente e somente uma vez.
* Na tarefa agendada, adicione uma ação para executar o progra %systemroot%\System32\CScript.exe e passe como argumento o caminho do arquivo DeploySophos.vbs.
* Edite o arquivo DeploySophos.vbs e altere o caminho de rede para apontar para o SophosSetup.exe.
