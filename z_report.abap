REPORT z_report .

data:
  class_name type string,
  obj        type ref to object,
  idade      type i .

class_name = '\PROGRAM=ZTESTE_ENJ\CLASS=LOCAL_CLASS'.

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


if idade is not initial .

  write:/ 'Você tem ', idade, 'anos' .

endif .    
