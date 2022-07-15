function exibe_title() {
echo "     ████████                    ██    ████████                 ██  ██    "
echo "     ███   ██ ████████ ██ ███   ██     ██    ██ ██              ██  ██    "
echo "     ███      ██    ██ ███  ██ ████     ██      ██       █████  ██  ██    "
echo "     ███      ██    ██ ██   ██  ██       ████   ███████ ██   ██ ██  ██    "
echo "     ███      ██    ██ ██   ██  ██          ██  ██   ██ ███████ ██  ██    "
echo "     ███   ██ ██    ██ ██   ██  ██     ██    ██ ██   ██ ██      ██  ██    "
echo "     ████████ ████████ ██   ██  ██  ██ ████████ ██   ██  █████  ███ ███   "


}

#################################################################################

function exibe_msg () {
echo ""
echo "-----------------------------------------------------------------------"
echo "                    [*] Selecione a Opçao desejada"
echo ""
echo ""
echo "            [1] Consultar as Configuraçoes da rede atual."
echo "            [2] Alterar o Endereço IP e a Interface rede atual."
echo "            [3] Alterar o Endereço DNS da Interface rede atual."
echo "            [4] Pingar em em algum hoste da rede."
echo "-----------------------------------------------------------------------"
echo ""

$consulte = Read-Host "Opçao"

If($consulte -like "1"){ Se_1 }
    Elseif ($consulte -like "2"){ Se_2 }
    Elseif ($consulte -like "3"){ Se_3 }
    Elseif ($consulte -like "4"){ Se_4 }
    Else {Write-Output "Opçao Invalida - [Exit]"} 
}

#################################################################################

function Se_1(){

If($consulte -like "1"){ Get-NetIPConfiguration }
    Else {Write-Output "Erro de sistema"} 

Continua
}

#################################################################################

function Se_2(){
echo "-----------------------------------------------------------------------"

$ipSe2 = Read-Host "Novo IP"
echo "-----------------------------------------------------------------------"

echo "Listando interfaces disponiveis...";
Get-NetIPInterface | Format-Table -Property ifIndex,InterfaceAlias
$interfaceSe2 = Read-Host "Qual interface (ifIndex) deseja configurar?"
echo "-----------------------------------------------------------------------"

$gatewaySe2 = Read-Host "Nova Gateway "
echo "-----------------------------------------------------------------------"

$mascaraSe2 = Read-Host "Comprimento da mascara Exp.8 [255.0.0.0] ou 24 [255.255.255.0] "
echo "-----------------------------------------------------------------------"

$ipmodeSe2 = Read-Host "[1] para -> IPV6 ou [2] para -> IPV4"
If($ipmodeSe2 -like "1"){$ipmodeSe2 = "IPV6" }
    Else {$ipmodeSe2 = "IPV4"}

echo "-----------------------------------------------------------------------"

echo ""
$confirmaçaoSe2 = Read-Host "realmente que fazer a operaçao? s/n"
echo ""

If($confirmaçaoSe2 -like "s"){ New-NetIPAddress $ipSe2 -InterfaceIndex $interfaceSe2 -DefaultGateway $gatewaySe2 -AddressFamily $ipmodeSe2 -PrefixLength $mascaraSe2}
    Else { Continua }

Concluido
Continua
}

#################################################################################

function Se_3(){
echo "-----------------------------------------------------------------------"

$DNS1Se3 = Read-Host "Novo Endereço DN1"
$DNS2Se3  = Read-Host "Novo Endereço DN2"
echo "-----------------------------------------------------------------------"

echo "Listando interfaces disponiveis...";
Get-NetIPInterface | Format-Table -Property ifIndex,InterfaceAlias
$interfaceSe3 = Read-Host "Qual interface (ifIndex) deseja configurar?"
echo "-----------------------------------------------------------------------"

echo ""
$confirmaçaoSe3 = Read-Host "realmente que fazer a operaçao? s/n"
echo ""

If($confirmaçaoSe3 -like "s"){ Set-DnsClientServerAddress -InterfaceIndex $interfaceSe3 -ServerAddresses $DNS1Se3,$DNS2Se3 }
    Else { Continua }
Concluido
Continua
}

#################################################################################

function Se_4(){
echo "-----------------------------------------------------------------------"

$PingSe4 = Read-Host "IP di hoste desejado"
echo "-----------------------------------------------------------------------"
echo ""

$confirmaçaoSe4 = Read-Host "realmente que fazer a operaçao? s/n"
echo ""

If($confirmaçaoSe4 -like "s"){ ping $PingSe4 }
    Else { Continua }

Continua
}

#################################################################################

function Concluido(){
echo "-----------------------------------------------------------------------"
echo "-------------------  OPERAÇAO CONCLUÍDA COM SUCESSO  ------------------"
echo "-----------------------------------------------------------------------"
}

#################################################################################

function Se_6(){
}

#################################################################################

function Continua() {
echo ""
echo "-----------------------------------------------------------------------"
$continua = Read-Host "Deseja continuar? [s/n]"

IF($continua -like "s")
    {
    clear
    exibe_title
    exibe_msg
    }

    Else {
    echo "-----------------------------------------------------------------------"
    Write-Output "                      Conf.Shell 1.0 - [Exit]"}
    echo "-----------------------------------------------------------------------"
}

#################################################################################

clear
exibe_title
exibe_msg
