#!/bin/bash
clear

function titulo() {
echo "   _______     ________    _________            __  __     ______    "
echo "  /______/\   /_______/\  /________/\          /_/\/_/\   /_____/\   "
echo "  \::::__\/__ \__.::._\/  \__.::.__\/          \:\ \:\ \  \:::_ \ \  "
echo "   \:\ /____/\   \::\ \      \::\ \             \:\ \:\ \  \:(_) \ \ "
echo "    \:\|_  _\/   _\::\ \__    \::\ \    _______  \:\ \:\ \  \: ___\/ "
echo "     \:\_\ \ \  /__\::\__/\    \::\ \  /______/\  \:\_\:\ \  \ \ \   "
echo "      \_____\/  \________\/     \__\/  \__::::\/   \_____\/   \_\/   "
echo "======================================================================="
echo "|                           Qual comentario do commit?                |"
echo "======================================================================="
read commit
}

function /titulo() {
echo "======================================================================="
echo "|                           Concuido o envio do Git_UP                |"
echo "======================================================================="
}

function apaga_git() {
# Apaga o .git para iniciar um novo
sudo rm -r .git
}

function inicio_git() {
titulo

# Inicio de um nova linha de tempo
git init
git add .
git commit -m "$commit"
git branch -M main
git remote add origin git@github.com:Ascoid/Script_PowerShall.git
git push -u origin main

/titulo
}

function atualiza_git() {
titulo

# Atualizaçao simples de envio/atualizaçao
git add .
git commit -m "$commit"
git push -u origin main

/titulo
}

################# Chamado de Funcrtion ##################

#atualiza_git
inicio_git
#atualiza_git
#apaga_git
