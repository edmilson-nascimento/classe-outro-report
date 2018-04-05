REPORT file .
  START-OF-SELECTION.                                                          
    CALL METHOD ('\PROGRAM=Z_REPORT_A\CLASS=LCL_LOCAL_CLASS')=>('SAY_FOO').    
            " --> writes 'Foo from program Z_REPORT_A'  
            
data:
  cls_name  type string,
  ref       type ref to object .

cls_name = '\PROGRAM=ZSDI0029_CLASS\CLASS=Z_CLASS'.

create object ref type (cls_name).

break-point.

call method ref->('TESTE') .            
