# Ping Sweep - Programaçao em Script

param($rede)
cls
      
echo " ██████ ██                        █████                                             "           
echo " ██  ██    ██ ███   ████         ██      ██      ███      ██  ████   ████  ██████   "
echo " ██████ ██ ███  ██ ██  ██         ██     ██     ██ ██     ██ ██  ██ ██  ██ ██  ██   "
echo " ██     ██ ██   ██ ██  ██  █████    ███   ██   ██   ██   ██  █████  █████  ██████   "
echo " ██     ██ ██   ██  █████             ██   ██ ██     ██ ██   ██     ██     ██       "
echo " ██     ██ ██   ██     ██         █████     ███       ███     ████   ████  ██       "
echo "                     ███                                                            "

if(!$rede) {

    write-Host "Erro: Digite os argumentos conforme abaixo"
    write-Host "Ex: .\PingSweep.ps1 192.168.15"
    

} else {
   
    foreach ($ip in 1..10) {
        try{
            $resposta = ping -n 1 "$rede.$ip" | Select-String "bytes=32"  
            $resposta.line.Split(' ')[2] -replace ":"," -> Ping OK"
        } catch {
            echo "Rede [ $rede.$ip ] Nao encontrada"
        }
    }
}