#!/bin/bash

while true; do
  read -p "Digite uma string (ou 'PARAR' para sair): " string
  if [[ "$string" == "PARAR" ]]; then
    break
  fi
  echo "A string invertida é: $(rev <<< "$string")"
done

#!/bin/bash

cafe=0
suco=0

while true; do
  clear
  echo "*********** Consumo de Bebidas na Cantina ***********"
  echo "Foram consumidos até o momento:"
  echo "* $cafe copos de Café"
  echo "* $suco copos de Suco"
  echo "****************************************************"
  echo "Digite:"
  echo "1 para registrar a venda de um copo de Café"
  echo "2 para registrar a venda de um copo de Suco"
  read opcao

  case $opcao in
    1) cafe=$((cafe+1));;
    2) suco=$((suco+1));;
    *) break;;
  esac
done

#!/bin/bash

total=0
etanol=0
gasolina=0
diesel=0
carros=0

while true; do
  clear
  echo "**** Posto Roberto Carlos ***"
  echo "Valor Apurado no DIA: R$ $total"
  echo "*****************************"
  read -p "Combustível (Etanol, Gasolina, ou Diesel): " combustivel
  read -p "Quantidade de litros abastecida: " litros

  if [[ $litros -eq 0 ]]; then
    break
  fi

  carros=$((carros+1))

  case "$combustivel" in
    Etanol)
      etanol=$((etanol+litros))
      total=$((total+litros*5))
      ;;
    Gasolina)
      gasolina=$((gasolina+litros))
      total=$((total+litros*6))
      ;;
    Diesel)
      diesel=$((diesel+litros))
      total=$((total+litros*7))
      ;;
  esac
done

echo "Quantidade de carros atendidos: $carros"
echo "Quantidade de litros de etanol vendidos: $etanol"
echo "Quantidade de litros de gasolina vendidos: $gasolina"
echo "Quantidade de litros de diesel vendidos: $diesel"
echo "Total apurado no dia: R$ $total"

#!/bin/bash

# Função para verificar se um número é primo (implementar aqui)
function is_prime() {
  # ...
}

> primos.txt

for ((i=2; i<=1000; i++)); do
  if is_prime $i; then
    echo $i >> primos.txt
  fi
done

#Inserção de Dados em Arquivo
def main():
    with open('pedido.txt', 'a') as arquivo:
        while True:
            produto = input("Digite o produto (ou 'fim' para sair): ")
            if produto.lower() == 'fim':
                break
            valor = input("Digite o valor: ")
            arquivo.write(f"{produto}:{valor}\n")

if __name__ == "__main__":
    main()




#!/bin/bash

# Considerando que para um número ser considerado primo ele deve ser divisível somente
# por 1 e por ele mesmo, implemente em Shell Script a função Primo() e faça um loop com
# while que solicite um número e execute a função exibindo como resposta se o número é
# primo ou não até que o usuário digite 0 (zero).

function Primo()
{
    Divisivel=0
    for teste in $(seq $1 -1 1);
    do
        if [ $(($1%$teste)) -eq 0 ]; then
            Divisivel=$(($Divisivel+1))
        fi
    done
    if [ $Divisivel -eq 2 ]; then
        echo "$1 é Primo"
    else
        echo "$1 NÃO é Primo"
    fi
}

while :
do
    read -p "Digite um Número para Testar (ou 0 para SAIR): " Teste
    if [ $Teste -eq 0 ]; then
        break
    fi
    Primo $Teste
done
