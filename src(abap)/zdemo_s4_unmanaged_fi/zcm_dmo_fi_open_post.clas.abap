CLASS zcm_dmo_fi_open_post DEFINITION
  PUBLIC INHERITING FROM cx_static_check
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_t100_message.
    INTERFACES if_t100w_dyn_msg.
    INTERFACES if_abap_behv_message.

    CONSTANTS:
      BEGIN OF initial_error,
        msgid TYPE symsgid VALUE 'ZCM_DMO_FI_OPEN_POST',
        msgno TYPE symsgno VALUE '001',
        attr1 TYPE scx_attrname VALUE 'ERROR_MESSAGE',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF initial_error.

    METHODS constructor
      IMPORTING
        textid        LIKE if_t100_message=>t100key OPTIONAL "RAP or fiori message
        previous      LIKE previous OPTIONAL
        severity      TYPE if_abap_behv_message=>t_severity DEFAULT if_abap_behv_message=>severity-error
        error_message TYPE char255 OPTIONAL.

    DATA error_message TYPE char255.
  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.



CLASS zcm_dmo_fi_open_post IMPLEMENTATION.


  METHOD constructor ##ADT_SUPPRESS_GENERATION.

    super->constructor( previous = previous ).

    CLEAR me->textid.
    IF textid IS INITIAL.
      if_t100_message~t100key = if_t100_message=>default_textid.
    ELSE.
      if_t100_message~t100key = textid.
    ENDIF.

    me->if_abap_behv_message~m_severity = severity.
    me->error_message = error_message.
  ENDMETHOD.
ENDCLASS.
