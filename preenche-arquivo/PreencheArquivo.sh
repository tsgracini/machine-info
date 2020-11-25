#!/bin/bash

#########################################################################
#									#
# PreencheArquivo.sh - Preenche e moitora o tamanho de um arquivo.	#
#							 		#
# Autor: Thiago Gracini <tsgracini@outlook.com>				#
# Data Criação: 25/11/2020				 		#
#							 		#
# Descrição: Recebe como parâmetro o nome de um arquivo um palavra	#
# ou caracter e um tamanho em bytes, em seguida escreve a palavra	#
# no arquivo até completar a quantidade de bytes informada.		#
# 									#
# Exemplo de uso: ./PreencheArquivo.sh arquivo.txt palavra bytes	#
#	          ./PreencheArquivo.sh arquivo.txt Shell 10000		#
#									#	
#########################################################################

# Exibe o modo de uso do script.
if [ $# -lt 3 ]
then
	echo "######################## Modo de Uso ##########################"
	echo "#                                                             #"
	echo "#                   Autor: Thiago Gracini                     #"
	echo "#                                                             #"
	echo "# ./PreencheArquivo.sh arquivo palavra/caracter size(bytes)   #"
	echo "#                                                             #"			
	echo "###############################################################" 
	exit 1
fi

# Limpa arquivo se este existir.
cat /dev/null > $1

FILESIZE=$(stat --printf=%s $1)
PORC_EXIBIDA=0

until [ $FILESIZE -ge $3 ]
do
	echo $2 >> $1
	FILESIZE=$(stat --printf=%s $1)

	PORC_ATUAL=$(expr $FILESIZE \* 100 / $3)

	if [ $(expr $PORC_ATUAL % 10) -eq 0 -a $PORC_ATUAL -ne $PORC_EXIBIDA ]
	then
		echo "Concluído: $PORC_ATUAL% - Tamanho do Arquivo: $FILESIZE"
		PORC_EXIBIDA=$PORC_ATUAL
	fi	
done
