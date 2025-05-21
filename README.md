# Acessar Classes em outro objeto ou report #

[![ABAP](https://img.shields.io/badge/ABAP-0FAAFF?style=flat&logo=sap&logoColor=white)](https://www.sap.com/brazil/developer.html)
[![SAP](https://img.shields.io/badge/SAP-0FAAFF?style=flat&logo=sap&logoColor=white)](https://www.sap.com/)
[![SAP On Premise](https://img.shields.io/badge/SAP%20On%20Premise-2B4C9B?style=flat&logo=sap&logoColor=white)](https://www.sap.com/)
[![ABAP OO](https://img.shields.io/badge/ABAP%20OO-0FAAFF?style=flat)](https://help.sap.com/doc/abapdocu_latest_index_htm/latest/en-US/index.htm?file=abenabap_objects_glosry.htm)
[![GitHub](https://img.shields.io/badge/GitHub-100000?style=flat&logo=github&logoColor=white)](https://github.com/edmilson-nascimento/classe-outro-report)
[![Commits](https://img.shields.io/github/commit-activity/t/edmilson-nascimento/classe-outro-report?style=flat)](https://github.com/edmilson-nascimento/classe-outro-report/commits)
[![Development](https://img.shields.io/badge/Development-ABAP-blue?style=flat&logo=sap&logoColor=white)](https://community.sap.com/topics/abap)

Em alguns momentos houve a necessidade de **acessar uma classe local (criada dentro de um report) de outro include/report/classe**. A primeira solução que foi sugerida a mim era criar pela SE24 essa mesma classe que estava local. Quando houve a primeira necessidade, foi o que fiz realmente, mas ainda fiquei tendencioso a achar uma maneira de fazer esse acesso. Depois de mais duas ou três incidencias dessa necessidade eu decidi não mais fazer isso, por ter mais tempo para montar a solução. Logo, aqui será exemplificado um [include](/z_outro_report.abap) que utilizará métodos de uma classe local que esta em um [programa](/z_report.abap) diferente.

* [Tipos de report's](#tipos-de-reports)
* [Declaração](#declara%C3%A7%C3%A3o)
* [Atribuição de valores](#atribui%C3%A7%C3%A3o-de-valores)
* [Utilização do objeto](#utiliza%C3%A7%C3%A3o-do-objeto)

Essa implementação é uma amostra básica e vou fazer isso usando parametros no método. Creio eu que a parte mais _importante_ ~~se é que existe algo mais importante em algo que um ponto faz com que o resto todo não funcione~~ é a forma de declarar as variaveis e os objetos.

## Tipos de Report's ##
Não mais e nem menos importante, mas estamos tratando com dois report's. O primeiro, para a necessidade que eu tive, era um include dentro de uma `exit`, onde os métodos da classe serão chamados, logo, esse é um `include` e o tipo desse report não afeta nada na solução. O segundo report, onde a classe foi implementada, **Programa executável (1)**. A classe pode ser implementada, ativada, mas quando for chamada no report `include`, não vai ter a funcionalidade acessível.

## Declaração ##

```abap
data:
  class_name type string,
  obj        type ref to object .
```
O `class_name` como `string`, e o objeto`obj` ~~as vezes me falta criatividade para declaração de variaveis~~ como `type ref to OBJECT`. Não sei porque ~~talvez por estar à muitas horas sem café~~ mas eu sempre usava como `type ref to DATA`, logo, essa declaração acertiva me tomou muito tempo e isso foi bom para que eu não tivesse mais dúvidas sobre como fazer. 

## Atribuição de valores ##

```abap
class_name = '\PROGRAM=ZTESTE_ENJ\CLASS=LOCAL_CLASS'.
```
Colocado como primero _parâmetro_ o nome do programa `'\PROGRAM=ZTESTE_ENJ`, e segundo _parâmetro_ `\CLASS=LOCAL_CLASS'` classe local que se referêncía. São as apenas essas as informações que devem ser passadas.

## Utilização do Objeto ##

```abap
create object obj type (class_name).

try .

  call method obj->('IDADE')
    exporting
      nascimento = '19000101'
    receiving
      value      = idade .

  catch cx_sy_dyn_call_param_not_found .

endtry .
```
Ao criar o objeto, será informado o seu `tipo`, que no caso, uma referência da classe. A partir da criação, o objeto passa a ser portar como um objeto da classe que foi passada, com acesso aos seus métodos e atribuidos como um objeto local e todas as suas caracteristicas. A chamada de métodos sempre deve ser feita usando `call method`. Eu particularmente, utilizo muito pouco dessa forma. Acho que o código fica mais limpo com a outra utilização (conforme abaixo).
```abap
call method obj->('CHECK_INITIAL')
  receiving
    value = check .

* utulizações diferentes do mesmo método

check = 
  obj->check_initial() .
```
Mas, para esse caso é necessário da primeira forma, com `call method`. 
Algo tambem muito importante que a falta de café me fez demorar entender, é que o **nome do método deve estar sempre em maiúsculo** (igual na chamada de uma `call function`). Pela linguagem não ser `case sensitive`, eu não vejo vantagem em programar com _upper case_.

Enfim, espero que esse exemplo ajude a mim (porque essa foi minha primeira motivação ao documentar) e outros ABAPer's :+1:
