#!/bin/bash

##########################################################
#                                                        #
# BuscaArquivos.sh - Busca arquivos JPG, MP3 e MP$.      #
#                                                        #
# Autor: Thiago Gracini <tsgracini@outlook.com>          #
# Data Criação: 25/11/2020                               #
#                                                        #
# Descrição: Busca por arquivos JPG, MP3 e MP4		 #
# no diretorio home de todos os usuários.		 #
#                                                        #
# Exemplo de uso: ./BuscaArquivos.sh                     #
#                                                        #
##########################################################


OLDIFS=$IFS
IFS=$'\n'

# Obtendo os UID's de usuários (humanos)
UIDMIN=$(grep "^UID_MIN" /etc/login.defs | expand | tr -s " " | cut -d " " -f2)
UIDMAX=$(grep "^UID_MAX" /etc/login.defs | expand | tr -s " " | cut -d " " -f2)

# Percorre cada linha do /etc/passwd
for USUARIO in $(cat /etc/passwd)
do
	USERID=$(echo $USUARIO | cut -d":" -f3)

	if [ $USERID -ge $UIDMIN -a $USERID -le $UIDMAX ]
	then
		USERHOME=$(echo $USUARIO | cut -d":" -f6)
		USERLOGIN=$(echo $USUARIO | cut -d":" -f1)
		JPG=0
		MP3=0
		MP4=0

		# loop for para cada resultado do find que busca os arquivos no home do usuário
		for BUSCA in $(find $USERHOME -iname '*.jpg' -o -iname '*.mp4' -o -iname '*.mp3')
		do
			if echo $BUSCA | grep -i "jpg" > /dev/null
			then
				JPG=$(($JPG + 1))
			elif echo $BUSCA | grep -i "mp3" > /dev/null
			then
				MP3=$(($MP3 + 1))
			else
				MP4=$(($MP4 + 1))
			fi
		done # Fim do for do find.

		echo "Usuario: $USERLOGIN"
		echo "Arquivo JPG: $JPG"
		echo "Arquivo MP3: $MP3"
		echo "Arquivo MP4: $MP4"
		echo
	fi
done # Fim do for do arquivo /etc/passwd

IFS=$OLDIFS
