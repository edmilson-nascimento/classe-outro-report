# Acessar Classes em outro objeto ou report #

[![N|Solid](https://wiki.scn.sap.com/wiki/download/attachments/1710/ABAP%20Development.png?version=1&modificationDate=1446673897000&api=v2)](https://www.sap.com/brazil/developer.html)

Em alguns momentos houve a necessidade de **acessar uma classe local (criada dentro de um report) de outro include/report/classe**. A primeira solução que foi sugerida a mim era criar pela SE24 essa mesma classe que estava local. Quando houve a primeira necessidade, foi o que fiz realmente, mas ainda fiquei tendencioso a achar uma maneira de fazer esse acesso. Depois de mais duas ou três incidencias dessa necessidade eu decidi não mais fazer isso, por ter mais tempo para montar a solução.

* (declaração)[#declaração]
* (atribuição de valores)[#]
* (utilização do objeto)[#]

Essa implementação é uma amostra basica e vou fazer isso usando parametros. Creio eu que a parte mais _importante_ ~~se é que existe algo mais importante em algo que um ponto faz com que o resto todo não funcione~~ é a forma de declarar as variaveis e os objetos.

## Declaração ##

```abap

data:
  class_name type string,
  obj        type ref to object .
  
```
O `class_name` como `string`, e o objeto`obj` ~~~as vezes me falta criatividade para declaração de variaveis~~ como `type ref to OBJECT`. Não sei porque ~~~talvez por estar a muitas horas sem café~~ mas eu sempre usava como `type ref to data`. 

## Atribuição de valores ##

```abap

class_name = '\PROGRAM=ZTESTE_ENJ\CLASS=LOCAL_CLASS'.

```
Essa parte deve ser colocado como primero parâmetro o nome do programa `'\PROGRAM=ZTESTE_ENJ`, e segundo parâmetro `\CLASS=LOCAL_CLASS'` classe local que se referência.

## Utilização do Objeto ##

```àbap

create object obj type (class_name).

break-point.

try .

  call method obj->('IDADE')
    exporting
      nascimento = '19000101'
    receiving
      value      = idade .

  catch cx_sy_dyn_call_param_not_found .

endtry .

```
Ao criar o objeto, será informado o seu _tipo_, que no caso, uma referência da classe que deve receber suas caracteristicas. A chamada sempre deve ser feita usando `call method`. Eu particularmente, utilizo muito ponto. Acho que o código fica mais limpo com a outra utilização.
```abap

call method obj->('CHECK_INITIAL')
  receiving
    value = check .

* utulizações diferentes do mesmo método

check = 
  obj->check_initial() .
  
```
Mas, para esse caso é necessário da primeira forma, com `call method`. 
Algo tambem muito importante que a falta de café me fez demorar entender, é que o **nome do método deve estar sempre em maiúsculo**. Pela linguagem não ser `case sensitive`, eu não vejo vantagem em programa com _upper case_ em qualquer coisa que não seja obrigatório.

Enfim, espero que esse exemplo ajude a mim (porque essa foi minha primeira motivação do documentar) e outros ABAPer's :+1:
