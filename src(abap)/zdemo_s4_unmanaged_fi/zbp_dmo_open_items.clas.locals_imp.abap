CLASS lhc_OpenItems DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR OpenItems RESULT result.

    METHODS create FOR MODIFY
      IMPORTING entities FOR CREATE OpenItems.

    METHODS update FOR MODIFY
      IMPORTING entities FOR UPDATE OpenItems.

    METHODS delete FOR MODIFY
      IMPORTING keys FOR DELETE OpenItems.

    METHODS read FOR READ
      IMPORTING keys FOR READ OpenItems RESULT result.

    METHODS lock FOR LOCK
      IMPORTING keys FOR LOCK OpenItems.
    METHODS earlynumbering_create FOR NUMBERING
      IMPORTING entities FOR CREATE OpenItems.

ENDCLASS.

CLASS lhc_OpenItems IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD create.

    IF lines( entities ) IS NOT INITIAL.

      DATA(entity) = entities[ 1 ].

      DATA(document_header) = VALUE bapiache09( comp_code = entity-CompanyCode
                                                fisc_year = entity-FiscalYear ).

      DATA lt_return TYPE STANDARD TABLE OF bapiret2.
      CALL FUNCTION 'BAPI_ACC_DOCUMENT_CHECK'
        EXPORTING
          documentheader = document_header
        TABLES
          return         = lt_return.

      LOOP AT lt_return REFERENCE INTO DATA(return).

        IF return->type <> 'E'.
          CONTINUE.
        ENDIF.
        "Clear state messages
        APPEND VALUE #( %cid = entity-%cid
                        %state_area = 'VALIDATE_OPEN_ITEM'
                        ) TO reported-openitems.

        IF lines( lt_return ) > 1.

          APPEND VALUE #( %cid = entity-%cid ) TO failed-openitems.
          APPEND VALUE #( %cid = entity-%cid
                          %state_area = 'VALIDATE_OPEN_ITEM'
                          %msg = NEW zcm_dmo_fi_open_post( textid = zcm_dmo_fi_open_post=>initial_error
                                                           severity = if_abap_behv_message=>severity-error
                                                           error_message = CONV #( return->message ) )
*                          %element-DocumentNumber = if_abap_behv=>mk-on
                          ) TO reported-openitems.

        ENDIF.

        RETURN.
      ENDLOOP.

    ENDIF.
  ENDMETHOD.

  METHOD update.
  ENDMETHOD.

  METHOD delete.
  ENDMETHOD.

  METHOD read.

    SELECT * FROM zi_dmo_open_items
      INTO TABLE @DATA(open_items).

    result = CORRESPONDING #( open_items ).

    LOOP AT keys INTO DATA(key).

    ENDLOOP.

    READ ENTITIES OF zi_dmo_open_items IN LOCAL MODE
      ENTITY OpenItems
      ALL FIELDS WITH CORRESPONDING #( keys )
      RESULT result
      REPORTED reported
      FAILED failed.

  ENDMETHOD.

  METHOD lock.
  ENDMETHOD.

  METHOD earlynumbering_create.

    IF lines( entities ) IS NOT INITIAL.

      DATA(entity) = entities[ 1 ].

      "Class or method to get document number for DR

*      SELECT FROM t003 as t003
*      INNER JOIN nriv as nriv
*      ON t003~numkr = nriv~nrrangenr
*        FIELDS

      "For test and simplicity just get from Base CDS
      SELECT FROM zi_dmo_open_items
        FIELDS
          DocumentNumber
        WHERE DocumentType = 'DR'
        ORDER BY DocumentNumber DESCENDING
        INTO @DATA(latest_document_number)
        UP TO 1 ROWS.
      ENDSELECT.

      IF latest_document_number IS NOT INITIAL.

*        latest_document_number += 1.

        SELECT FROM zddt_dmo_open_fi
          FIELDS
            documentnumber
*          WHERE documenttype = 'DR'
          ORDER BY documentnumber DESCENDING
          INTO @DATA(latest_draft_doc_number)
          UP TO 1 ROWS.
        ENDSELECT.

        latest_document_number = COND #( WHEN latest_draft_doc_number IS NOT INITIAL
                                          AND latest_draft_doc_number <> latest_document_number
                                         THEN latest_draft_doc_number + 1
                                         ELSE latest_document_number + 1 ).
      ENDIF.

      DATA(document_header) = VALUE bapiache09( comp_code = entity-CompanyCode
                                                fisc_year = entity-FiscalYear
                                                username = sy-uname
                                                doc_type = 'DR' ).

      "Dummy Data
      TYPES tt_accountgl TYPE STANDARD TABLE OF bapiacgl09 WITH NON-UNIQUE KEY gl_account.

      DATA(account_gl) = VALUE tt_accountgl( ( itemno_acc = '1'
                                               gl_account = '0055900010'
                                               item_text = 'TEST NEW'
                                               comp_code = entity-CompanyCode
                                               fisc_year = entity-FiscalYear
                                               pstng_date = sy-datum ) ).

      DATA lt_return TYPE STANDARD TABLE OF bapiret2.
      CALL FUNCTION 'BAPI_ACC_DOCUMENT_CHECK'
        EXPORTING
          documentheader = document_header
        TABLES
          accountgl      = account_gl
          return         = lt_return.

      LOOP AT lt_return REFERENCE INTO DATA(return).

        IF return->type <> 'E'.
          APPEND VALUE #( %cid = entity-%cid
                          %is_draft = entity-%is_draft
                          %key = entity-%key
                          documentnumber = latest_document_number ) TO mapped-openitems.
          RETURN.
        ENDIF.
        "Clear state messages
        APPEND VALUE #( %cid = entity-%cid
                        %key = entity-%key
                        %is_draft = entity-%is_draft
                        %state_area = 'VALIDATE_OPEN_ITEM'
                        ) TO reported-openitems.

        IF lines( lt_return ) > 1.

          APPEND VALUE #( %cid = entity-%cid
                          %is_draft = entity-%is_draft
*                          %key = entity-%key
                          documentnumber = latest_document_number ) TO failed-openitems.
          APPEND VALUE #( %cid = entity-%cid
                          %key = entity-%key
                          %is_draft = entity-%is_draft
                          %state_area = 'VALIDATE_OPEN_ITEM'
                          %msg = NEW zcm_dmo_fi_open_post( textid = zcm_dmo_fi_open_post=>initial_error
                                                           severity = if_abap_behv_message=>severity-error
                                                           error_message = CONV #( return->message ) )
*                          %element-DocumentNumber = if_abap_behv=>mk-on
                          ) TO reported-openitems.

        ENDIF.

      ENDLOOP.
    ENDIF.
  ENDMETHOD.

ENDCLASS.

CLASS lsc_ZDMO_OPEN_ITEMS DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS finalize REDEFINITION.

    METHODS check_before_save REDEFINITION.

    METHODS save REDEFINITION.

    METHODS cleanup REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_ZDMO_OPEN_ITEMS IMPLEMENTATION.

  METHOD finalize.
  ENDMETHOD.

  METHOD check_before_save.
  ENDMETHOD.

  METHOD save.
  ENDMETHOD.

  METHOD cleanup.
  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.

ENDCLASS.
