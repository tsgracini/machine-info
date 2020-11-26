#!/bin/bash

#########################################################################
#									#
# FuncoesDiversas.sh - Funções para realizar tratamento de datas.	#
#							 		#
# Autor: Thiago Gracini <tsgracini@outlook.com>				#
# Data Criação: 26/11/2020				 		#
#							 		#
# Descrição: Realiza o tratamento de datas nos formatos DDMMYYYY,	#
# MMDDYYYY com ou sem /.                                                #
#									#
# --help = Exibe a ajuda para o comando.				#
# -e <DATA>: Exibe a data em formato extenso. Exemplo de 13081918	#
# para 13 de Agosto de 1981"						#
# -b <DATA>: Inclui as barras de data. Exemplo de 13081918 para		#
# 13/08/1918.								#
# -i <DATA>: Inverte formato BR para US e US para BR. Inclui as Barras  #
# -f <DATA>: Retorna 0 para BR, 1 para US e 2 quando impossível		#
# determinar,3 Inválido.						#
# 									#
# Exemplo de uso: ./FuncoesDiversas.sh --help				#
#									#	
#########################################################################

IdentificaFormato () {
# Função para identificar o formato de uma data se BR retorna 0, se US retorna 1
# se impossível detectar pois dia e mês menor que 12 retorna 2 e se a data for
# inválida retorna 3.
	DATA=$(echo $1 | tr -d "/")
	VAL1=$(echo $DATA | cut -c1-2)
	VAL2=$(echo $DATA | cut -c3-4)
	ANO=$(echo $DATA | cut -c5-8)

	if [ $VAL1 -gt 12 -a $VAL1 -le 31 -a $VAL2 -le 12 ]
	then
		return 0
	elif [ $VAL1 -le 12 -a $VAL2 -gt 12 -a $VAL2 -le 31 ]
	then
		return 1
	elif [ $VAL1 -le 12 -a $VAL2 -le 12 ]
	then
		return 2
	else
		return 3
	fi
}

InvertData () {
# Função trasnforma uma data em formato BR para US e vice versa.
# Formato BR -> DD/MM/YYYY
# Formato US -> MM/DD/YYYY
	IdentificaFormato $1
	local RETURN=$?
	
	case $RETURN in
		0)
			echo "$VAL2/$VAL1/$ANO";;
		1)
			echo "$VAL2/$VAL1/$ANO";;
		2)
			echo "$VAL1/$VAL2/$ANO";;
		*)
			echo "Data Inválida"
	esac
}

AdicionaBarra () {
# Função para adicionar / em uma data sem /
# Exemplo -> 08122018 para 08/12/2020
	IdentificaFormato $1
	local RETURN=$?
	
	case $RETURN in
		(0 | 2)
			echo "$VAL1/$VAL2/$ANO";;
		1)
			echo "$VAL2/$VAL1/$ANO";;
		*)
			echo "Data Inválida"
	esac
}

DataExtenso () {
# Função para escrever uma data por extenso.
# 13/08/2020 -> 13 de Agosto de 2020
	IdentificaFormato $1
	local RETURN=$?

	case $RETURN in
		(0 | 2)
			NUMERO_MES=$VAL2;;
		1)
			NUMERO_MES=$VAL1;;
		*)
			echo "Data Inválida"
			exit
	esac

	case $NUMERO_MES in
		"01")
			MES="Janeiro";;
		"02")
			MES="Fevereiro";;
		"03")
			MES="Março";;
		"04")	
			MES="Abril";;
		"05")
			MES="Maio";;
		"06")
			MES="Junho";;
		"07")
			MES="Julho";;
		"08")
			MES="Agosto";;
		"09")
			MES="Setembro";;
		"10")
			MES="Outubro";;
		"11")
			MES="Novembro";;
		"12")
			MES="Dezembro"
	esac
	
	if [ $RETURN -ne 1 ]
	then	
		echo "$VAL1 de $MES de $ANO"
	else
		echo "$VAL2 de $MES de $ANO"
	fi
}

HelpFuncao () {
# Função para exibir a ajuda do comando apenas.
	echo "Uso ./FuncoesDiversas.sh OPÇÃO DATA"
	echo "DATA nos formatos DDMMYYYY ou MMDDYYYY, com ou sem /"
	echo
	echo "Opções:"
	echo
	echo "-f = Retorna 0 para BR, 1 para US e 2 quando impossível determinar, 3 Inválido"
	echo "-i = Inverte formato BR para US e US para BR. Inclui as Barras"
	echo "-b = Inclui Barras de Data. Exemplo: de 13081981 para 13/08/1981"
	echo "-e = Exibe a data em formato extenso. Exemplo de 13081918 para 13 de Agosto de 1981"
}

case $1 in
	"-f")
		IdentificaFormato $2
		echo "$?"
		;;
	"-i")
		InvertData $2
		;;
	"-b")
		AdicionaBarra $2
		;;
	"-e")
		DataExtenso $2
		;;
	"--help")
		HelpFuncao
esac	
