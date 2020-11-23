#!/bin/bash

##########################################################
#							 #
# BackupHome.sh - Realiza backup do diretorio home.	 #
#							 #
# Autor: Thiago Gracini <tsgracini@outlook.com>		 #
# Data Criação: 23/11/2020				 #
#							 #
# Descrição: Script realiza backup da partição,	 	 #
#	     /home do usuário atual. Os arquivos	 #
#            serão agrupados e compactados com o	 #
#	     comando tar.				 #
#							 #
#	     Será gerado um arquivo com o nome		 #
# 	     no seguinte formato:			 #
#							 #
#	     backup_home_AAAAMMDDHHMM.tgz		 #
# 							 #
# Exemplo de uso: ./BackupHome.sh			 #
#							 #
##########################################################

DIRDEST="$HOME/Backup"

clear
# Verifica a a existencia do diretório Backup e cria se necessário
if [ ! -d $DIRDEST ]
then
	echo "Criando diretório $DIRDEST..."
	mkdir $DIRDEST 
fi

# Verifica se há backups realizados nos últimos 7 dias.
PROCURARQ=$(find $DIRDEST -name "*.tgz" -ctime -7)

# Pede para o usuário confirmar se deseja refazer o backup da semana.
if [ "$PROCURARQ" ]
then
	echo "Já foi gerado um backup do diretório $HOME nos últimos 7 dias."
	read -p "Deseja continuar (N/s): " ACAO
	echo " "

	case $ACAO in
		(n | N)
			echo "Backup abortado!"
			exit 1
			;;
		(s | S)
			echo "Será criado mais um backup para a mesma semana"
			;;
		*)
			echo "Opção inválida"	
			exit 1
	esac
fi

ARQUIVO="backup_home_$(date +%Y%m%d%H%M).tgz"
tar zcvpf $DIRDEST/$ARQUIVO --absolute-names --exclude="$DIRDEST" "$HOME"/* > /dev/null

echo "Criando Backup..."
echo ""
echo "O backup de nome \"$ARQUIVO\" foi criado em $DIRDEST"
echo ""
echo "Backup Concluido!"
