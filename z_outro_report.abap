
report  z_outro_report.

class local_class definition .

  public section .

    methods idade
      importing
        !nascimento  type sydatum
      returning
        value(value) type i .

  protected section .

  private section .

endclass .

class local_class implementation .

  method idade .

    if nascimento is not initial .

      call function 'HR_99S_INTERVAL_BETWEEN_DATES'
        exporting
          begda           = nascimento
          endda           = sy-datum
*         tab_mode        = ' '
        importing
*         days            =
*         c_weeks         =
*         c_months        =
          c_years         = value
*         weeks           =
*         months          =
*         years           =
*         d_months        =
*         month_tab       =
                .

    endif .

  endmethod .


endclass .


initialization .

*data:
*  obj   type ref to local_class,
*  idade type i .
*
*create object obj.
*
*  idade =
*    obj->idade( '19000101' ) .
*
*write:/ 'Você tem ', idade, 'anos' .
