*&---------------------------------------------------------------------*
*& Report z_smic_demo_alv_ida
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_smic_demo_alv_ida.

START-OF-SELECTION.

  "Use only for non CDS
*  DATA(is_supported) = cl_salv_gui_table_ida=>db_capabilities( )->is_table_supported( 'ZC_DEMO_S4_PROJECT_INTERFACE' ).
*  DATA(is_supported) = cl_salv_gui_table_ida=>db_capabilities( )->is_table_supported( 'ZI_DEMO_USERS' ).
*  DATA(is_supported) = cl_salv_gui_table_ida=>db_capabilities( )->is_table_supported( 'ZI_DEMO_ALV_IDA' ).
*  IF is_supported <> abap_true.
*    MESSAGE |Not Supported!| TYPE 'S'.
*    RETURN.
*  ENDIF.

  TRY.
*      cl_salv_gui_table_ida=>create_for_cds_view( iv_cds_view_name = 'ZC_DEMO_S4_PROJECT_INTERFACE'
*      cl_salv_gui_table_ida=>create_for_cds_view( iv_cds_view_name = 'ZI_DEMO_USERS'
*                               )->fullscreen(
*                               )->display( ).
*      DATA(alv_ida) = cl_salv_gui_table_ida=>create_for_cds_view( iv_cds_view_name = 'ZC_DEMO_S4_PROJECT_INTERFACE' ).
*      DATA(alv_ida) = cl_salv_gui_table_ida=>create_for_cds_view( iv_cds_view_name = 'ZI_DEMO_USERS' ).
      DATA(alv_ida) = cl_salv_gui_table_ida=>create_for_cds_view( iv_cds_view_name = 'ZI_DEMO_ALV_IDA' ).
    CATCH
        cx_salv_db_connection
        cx_salv_db_table_not_supported
        cx_salv_ida_contract_violation
        cx_salv_function_not_supported INTO DATA(alv_ida_error).

      MESSAGE |{ alv_ida_error->get_text( ) }| TYPE 'S' DISPLAY LIKE 'E'.
      LEAVE LIST-PROCESSING.
  ENDTRY.

  alv_ida->toolbar( )->add_button( iv_fcode = 'TEST'
                                       iv_text = 'Button Test' ).

  alv_ida->fullscreen( )->display( ).
