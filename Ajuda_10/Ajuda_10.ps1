function exibe_title(){
echo ""    
echo " ██████     ██ ██  ██     ██  ████     ███   ███      "
echo " ██  ██     ██ ██  ██     ██ ██  ██     ██  ██ ██     "
echo " ██████     ██ ██  ██  █████ ██████ ███ ██  ██ ██     "
echo " ██  ██     ██ ██  ██ ██  ██ ██  ██     ██  ██ ██     "
echo " ██  ██ ██  ██ ██  ██ ██  ██ ██  ██     ██  ██ ██     "
echo " ██  ██  ████   ████   █████ ██  ██    ████  ███      "

}

######################################################################

function exibe_msg (){
echo ""
echo "--------------------------------------------------"
echo "        [*] Selecione a Opçao desejada            "
echo "                                                  "
echo "    [1] Desabilitar programas em segundo plano    "
echo "    [2] Infornaçoes tecnicas do hardware ou Bios  "
echo "    [3] Backup de Drivers do sistema              "
echo "    [4] Lista de Programas instalados             "
echo "--------------------------------------------------"
echo ""

$consulte = Read-Host "Opçao"
echo ""

If($consulte -like "1") {Se_1}
    Elseif ($consulte -like "2") {Se_2}
    Elseif ($consulte -like "3") {Se_3}
    Elseif ($consulte -like "4") {Se_4}
    Else {Write-Output "Opçao Invalida - [Exit]"}

}

######################################################################

function Se_1() {

If($consulte -like "1"){Get-AppxPackage | Where-Object {$_.name -notlike "store"} | Remove-AppxPackage}

Continua  
  
}

######################################################################

function Se_2() {
echo "--------------------------------------------------"
echo "        [*] Selecione a Opçao desejada            "
echo "                                                  "
echo "        [1] Infornaçoes do hardware               "
echo "        [2] Infornaçoes da Bios                   "
echo "--------------------------------------------------"   

$consulte2 = Read-Host "Opçao"
echo ""

If($consulte2 -like "1") {Get-WmiObject -Class Win32_ComputerSystem}
    Elseif ($consulte2 -like "2") {Get-WmiObject win32_bios}
    Else{echo "nao"}
    
Continua 

}

######################################################################

function Se_3 () {

echo "[ Aguarde um instante -> Buscando Drivers... ]"
If($consulte -like "3"){$BackupDrives = Export-WindowsDriver -Online -Destination C:\Drives}

echo ""
echo "[ Os Drivers estão na pasta C:\Drives ]"
echo ""

$Lista = Read-Host "Deseja guardar em .txt as informaçoes dos drives? [s/n]"
If($Lista -like "s"){$BackupDrives | Select-Object ClassName, ProviderName, Date, Version | Export-CSV C:\Drives\Lista.txt}
    Else{Continua}

echo "[ Lista com as informaçoes dos drives esta na pasta  C:\Drives ]"

Continua 

}

######################################################################

function Se_4 () {

If($consulte -like "4"){Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | Select-Object DisplayName, DisplayVersion | Sort-Object -Property DisplayName -Unique | Format-Table -Autosize}
echo ""
$Lista2 = Read-Host "Deseja guardar em .txt as informaçoes dos Programas? [s/n]"

echo ""
If($Lista2 -like "s"){Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | Select-Object DisplayName, DisplayVersion | Sort-Object -Property DisplayName -Unique | Format-Table -Autosize > "$env:userprofile\desktop\programas_Instalados.txt"}
    Else{Continua}

echo "[ Lista com as informaçoes dos Programas esta na Desktop ]"

Continua 

}

######################################################################

function continua() {
echo ""
echo "--------------------------------------------------"
$continua = Read-Host "Deseja continuar? [s/n]"

If($continua -like "s")
    {
    clear
    exibe_title
    exibe_msg
    }

    Else{
    clear
    echo "---------------------------------------------------------------------------------------"
    Write-Output "                              Ajuda-10 1.0 - [Exit]                                   "
    echo ""
    Write-Output "[Https:/canalbpv.com/powershell-otimize-seu-sistema-windows-e-aprenda-dicas-para-t-i/]"
    echo "---------------------------------------------------------------------------------------"
    }

}

######################################################################

clear 
exibe_title
exibe_msg