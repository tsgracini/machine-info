#!/bin/bash

##########################################################
#							 #
# Relatorio-2.sh - Exibe informações da máquina.	 #
#							 #
# Autor: Thiago Gracini <tsgracini@outlook.com>		 #
# Data Criação: 21/11/2020				 #
#							 #
# Descrição: Script exibe um relatório da máquina	 #
#            com as seguintes informações: Nome da	 #
#            máquina tempo de execução, quantidade	 #
#            de CPU's, memória total, versão do		 #
#            kernel e partições.			 #
#							 #
# Exemplo de uso: ./Relatorio-2.sh			 #
#							 #
##########################################################

HOSTNAME=$(hostname)
QTDECPU=$(grep -c "processor" /proc/cpuinfo)
MODELOCPU=$(grep "model name" /proc/cpuinfo | cut -d":" -f2 | head -n1)
MEMORIA=$(free -m | grep "Mem" | tr -s " " | cut -d" " -f2)
PARTICOES=$(df -h | grep -E '(hd[a-z]|sd[a-z]|Sist\.)')
KERNEL=$(uname -r)
UPTIME=$(uptime -s)

clear
echo "==============================================================="
echo "Relatório da Máquina: $HOSTNAME"
echo "Data/Hora: $(date)"
echo "==============================================================="
echo ""
echo "Máquina ativa desde: $UPTIME"
echo ""
echo "Versão do Kernel: $KERNEL"
echo ""
echo "CPUs:"
echo "Quantidade de CPUs/Core: $QTDECPU"
echo "Modelo da CPU: $MODELOCPU"
echo ""
echo "Memória Total: $MEMORIA MB"
echo ""
echo "Partições:"
echo "$PARTICOES"
echo ""
echo "==============================================================="
