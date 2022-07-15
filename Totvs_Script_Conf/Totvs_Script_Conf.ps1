function exibe_title(){
echo ""     
echo "                ██████ ████  ██████ ██   ██  ████                "
echo "                  ██  ██  ██   ██   ██   ██ ██  ██               "
echo "                  ██  ██  ██   ██   ██   ██  ██                  "
echo "                  ██  ██  ██   ██   ██   ██    ██                "
echo "                  ██  ██  ██   ██    ██ ██  ██  ██               "
echo "                  ██   ████    ██     ███    ████                "
echo "-----------------------------------------------------------------"
echo "                           Script_inicio                         "

}

######################################################################

function exibe_msg (){
echo "-----------------------------------------------------------------"
echo "                  [*] Selecione a Opçao desejada                 "
echo "                                                                 "
echo "    [1] Ativar ADMINISTRADOR                                     "
echo "    [2] Coloca no DOMINIO                                        "
echo "    [3] Instalar Programas [VPN, symantec, CrowdStrik e Kace]    "
echo "    [4] Ativando [ Kace ]  									   "
echo "    [6] Apagar USUARIO                                           "
echo "-----------------------------------------------------------------"
echo ""

$consulte = Read-Host "Opção"
echo ""

If($consulte -like "1") {Se_1}
    Elseif ($consulte -like "2") {Se_2}
    Elseif ($consulte -like "3") {Se_3}
    Elseif ($consulte -like "4") {Se_4}
	Elseif ($consulte -like " ") {Se_5}
	Elseif ($consulte -like "6") {Se_6}
    Else {Write-Output "Opçao Invalida - [Exit]"}

}

######################################################################

function Se_1() {

net user administrador /active:yes;
$Password = Read-Host "Senha: " -AsSecureString
$UserAccount = Get-LocalUser -Name "administrador"
$UserAccount | Set-LocalUser -Password $Password

Continua  
  
}

######################################################################

function Se_2 () {

$Dominio = Read-Host "Dominio: " 
$hostname = Read-Host "Hostname: "
Add-Computer -DomainName $Dominio -NewName $hostname -Restart

Continua 

}

######################################################################

function Se_3 () {
	
#While($install.ExitCode -eq $null){Sleep 1}
#$install = msiexec /i C:\Temp\Scrip_power\Test_01\ampagent.msi 
#While($install.ExitCode -eq $null){Sleep 1}
##WindowsSensor_A10BCBCD8C0243C8A3179158FF22A8BE-F9.exe  /install /quiet /norestart /log log.tct %TEMP%
#$install = Start-Process "C:\Temp\Scrip_power\Test_01\BIGIPEdgeClient_win.exe" -ArgumentList "-q" -PassThru 
#While($install.ExitCode -eq $null){Sleep 1}


echo "======== Iniciando instalaçao do CrowdStrik ========"
$install = Start-Process "C:\Temp\CrowdStrike\WindowsSensor_A10BCBCD8C0243C8A3179158FF22A8BE-F9.exe" -ArgumentList "-q" -PassThru 
echo ""

#for($i = 0; $i -le 100; $i++){
#	write-Process -Activity "Aguartde...." -Status "Progresso!" - PercentComplete $i
#}

#wait-event -sourceIdentifier "ProcessStarted" -timeout 90

#echo "======== Iniciando instalaçao do Symantec ========"
#$install = Start-Process "C:\Temp\x64\setup.exe" -ArgumentList "\a" -PassThru
#echo ""

#wait-event -sourceIdentifier "ProcessStarted" -timeout 180

#echo "======== Iniciando instalaçao do kace ========"
#cmd.exe /c '\Temp\Kace.bat'
#echo ""

#While($install.ExitCode -eq $null){Sleep 1}

Continua
}

######################################################################

function Se_4 () {

cmd.exe /c '\Temp\Kace.bat'
}

######################################################################

function Se_5 () {

$install = Start-Process "C:\Temp\x64\setup.exe" -ArgumentList "\a" -PassThru
$install = Start-Process "C:\Temp\CrowdStrike\WindowsSensor_A10BCBCD8C0243C8A3179158FF22A8BE-F9.exe" -ArgumentList "-q" -PassThru

echo KACE

cd C:\Program Files (x86)\Quest\KACE
runkbot 4 0
runkbot 4 0

}

######################################################################

function Se_6() {

$usuario = Read-Host "Usuario: " 
net user $usuario /delete
Remove-item C:\Users\$usuario
echo " ===== [Pasta c:\Users\$usuario] ===== (Apagado)"
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
    Write-Output "                              Totvs - Script_inicio 1.0 - [Exit]                                   "
    echo ""
    echo "---------------------------------------------------------------------------------------"
    }

}
Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy Bypass -Force

######################################################################
#Iniciando como Administrador shell

param([switch]$Elevated)

function Test-Admin {
  $currentUser = New-Object Security.Principal.WindowsPrincipal $([Security.Principal.WindowsIdentity]::GetCurrent())
  $currentUser.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
}

if ((Test-Admin) -eq $false)  {
    if ($elevated) 
    {
        # tried to elevate, did not work, aborting
    } 
    else {
        Start-Process powershell.exe -Verb RunAs -ArgumentList ('-noprofile -noexit -file "{0}" -elevated' -f ($myinvocation.MyCommand.Definition))
}

exit
}

'running with full privileges'


######################################################################

clear 
exibe_title
exibe_msg