"! <p class="shorttext synchronized" lang="en">Fill DB tables to used in S4 Remediated objects</p>
"! <strong>Use only for initializing demo components/artifacts</strong>
CLASS zcl_demo_fill_db_s4rm_projects DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES:
      if_oo_adt_classrun.

    TYPES:
      BEGIN OF ty_db_status,
        db_name     TYPE char20,
        is_success  TYPE abap_bool,
        message_log TYPE string,
      END OF ty_db_status.

    METHODS:
      fill_up_demo_trm_projects
        RETURNING
          VALUE(r_status) TYPE ty_db_status,
      fill_up_demo_trm_objects
        RETURNING
          VALUE(r_status) TYPE ty_db_status,
      fill_up_demo_trm_transport_req
        RETURNING
          VALUE(r_status) TYPE ty_db_status.

    "Other tables(value helps or static tables)
    METHODS:
      fill_up_demo_systems
        RETURNING
          VALUE(r_status) TYPE ty_db_status,
      fill_up_demo_status
        RETURNING
          VALUE(r_status) TYPE ty_db_status,
      fill_up_demo_priority
        RETURNING
          VALUE(r_status) TYPE ty_db_status,
      fill_up_demo_user_role_lists
        RETURNING
          VALUE(r_status) TYPE ty_db_status.

  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA status TYPE ty_db_status.
    METHODS:
      get_timestamp_local
        RETURNING
          VALUE(result) TYPE timestampl.
ENDCLASS.



CLASS zcl_demo_fill_db_s4rm_projects IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
*    me->status = fill_up_demo_trm_projects( ).
*    out->write( |{ me->status-message_log }| ).
*
*    CLEAR me->status.
*    me->status = fill_up_demo_trm_transport_req( ).
*    out->write( |{ me->status-message_log }| ).
*
*    CLEAR me->status.
*    me->status = fill_up_demo_trm_objects( ).
*    out->write( |{ me->status-message_log }| ).
*
*    CLEAR me->status.
*    me->status = fill_up_demo_systems( ).
*    out->write( |{ me->status-message_log }| ).

*    CLEAR me->status.
*    me->status = fill_up_demo_status( ).
*    out->write( |{ me->status-message_log }| ).

*    CLEAR me->status.
*    me->status = fill_up_demo_priority( ).
*    out->write( |{ me->status-message_log }| ).

    CLEAR me->status.
    me->status = fill_up_demo_user_role_lists( ).
    out->write( |{ me->status-message_log }| ).
  ENDMETHOD.

  METHOD fill_up_demo_trm_projects.
    DELETE FROM zdt_demo_s4_trm.
    TRY.
        INSERT zdt_demo_s4_trm FROM TABLE @( VALUE #(
                      ( project_uuid = cl_system_uuid=>if_system_uuid_rfc4122_static~create_uuid_x16_by_version( 4 )
                        project_name = |Open Item Posting(IDOC Inbound Interface)| system_source = 'DEV' remediated_by = 'TEAM' priority = 1
                        workstream_lead = 'Ana Cordero' developer_assigned = 'Howard Baking' projected_date = '20240101' test_status = '01'
                        created_by = sy-uname created_at = me->get_timestamp_local( )  )
                      ( project_uuid = cl_system_uuid=>if_system_uuid_rfc4122_static~create_uuid_x16_by_version( 4 )
                        project_name = |Reclass Interest Expense Payment to Facility Agent| system_source = 'DEV' remediated_by = 'TEAM' priority = 1 s4_tcode = 'ZTF_LENDERS_TO_AGENT'
                        workstream_lead = 'Ana Cordero' developer_assigned = 'Howard Baking' projected_date = '20240101' test_status = '02'
                        created_by = sy-uname created_at = me->get_timestamp_local( ) )
                      ( project_uuid = cl_system_uuid=>if_system_uuid_rfc4122_static~create_uuid_x16_by_version( 4 )
                        project_name = |IRS Netting Posting| system_source = 'DEV' remediated_by = 'TEAM' priority = 1 s4_tcode = 'ZTF_IRS_NETTING'
                        workstream_lead = 'Ana Cordero' developer_assigned = 'Howard Baking' projected_date = '20240101' test_status = '02'
                        created_by = sy-uname created_at = me->get_timestamp_local( ) )
                      ( project_uuid = cl_system_uuid=>if_system_uuid_rfc4122_static~create_uuid_x16_by_version( 4 )
                        project_name = |CCS Interest Netting| system_source = 'DEV' remediated_by = 'TEAM' priority = 1 s4_tcode = 'ZTF_CCS_NETTING'
                        workstream_lead = 'Ana Cordero' developer_assigned = 'Howard Baking' projected_date = '20240101' test_status = '00'
                        created_by = sy-uname created_at = me->get_timestamp_local( ) )
                      ( project_uuid = cl_system_uuid=>if_system_uuid_rfc4122_static~create_uuid_x16_by_version( 4 )
                        project_name = |Excel Upload for maintenance tables with multiple lines| system_source = 'DEV' remediated_by = 'TEAM' priority = 1
                        workstream_lead = 'Ana Cordero' developer_assigned = 'Howard Baking' projected_date = '20230701' test_status = '01'
                        created_by = sy-uname created_at = me->get_timestamp_local( ) )
                      ( project_uuid = cl_system_uuid=>if_system_uuid_rfc4122_static~create_uuid_x16_by_version( 4 )
                        project_name = |Lift and Shift Objects By Team| system_source = 'DEV' remediated_by = 'TEAM' priority = 2
                        workstream_lead = 'Ana Cordero' developer_assigned = 'Howard Baking' projected_date = '20230720' test_status = '01'
                        created_by = sy-uname created_at = me->get_timestamp_local( ) )
                      ( project_uuid = cl_system_uuid=>if_system_uuid_rfc4122_static~create_uuid_x16_by_version( 4 )
                        project_name = |Lift and Shift Objects By Consultant| system_source = 'DEV' remediated_by = 'TEAM' priority = 2
                        workstream_lead = 'Ana Cordero' developer_assigned = 'Howard Baking' projected_date = '20230701' test_status = '05'
                        created_by = sy-uname created_at = me->get_timestamp_local( ) )
                      ) ) ACCEPTING DUPLICATE KEYS.
      CATCH cx_sy_open_sql_db INTO DATA(sql_insert_error).
        r_status = VALUE #( is_success = abap_false
                            db_name = |zdt_demo_s4_trm|
                            message_log = |{ r_status-db_name } { sql_insert_error->get_text( ) } | ).
        RETURN.
    ENDTRY.

    r_status = VALUE #( is_success = abap_true
                        db_name = |zdt_demo_s4_trm|
                        message_log = |App started.. DB { r_status-db_name } has been successfully updated!!| ).

*    IF sy-subrc = 0.
*      r_status = VALUE #( is_success = abap_true
*                          db_name = |zdt_demo_s4_trm|
*                          message_log = |App started.. DB { r_status-db_name } has been successfully updated!!| ).
*      RETURN.
*    ENDIF.
*
*    r_status = VALUE #( is_success = abap_false
*                        db_name = |zdt_demo_s4_trm|
*                        message_log = |App started.. DB { r_status-db_name } has failed to update!!| ).
  ENDMETHOD.

  METHOD fill_up_demo_trm_objects.
    DATA(local_timestamp) = me->get_timestamp_local( ).
    DELETE FROM zdt_demo_s4_obj.
    TRY.
        INSERT zdt_demo_s4_obj FROM (
          SELECT FROM zdt_demo_s4_tr AS trm_data
            INNER JOIN zdt_demo_s4_trm AS project_data
            ON trm_data~project_name = project_data~project_name
            INNER JOIN e070 AS tr_header
            ON trm_data~transport_request = tr_header~trkorr
            INNER JOIN e071 AS tr_entries
            ON tr_header~trkorr = tr_entries~trkorr
            INNER JOIN tadir AS repository_objects
            ON repository_objects~object = tr_entries~object
            AND repository_objects~pgmid = tr_entries~pgmid
            AND repository_objects~obj_name = tr_entries~obj_name
            FIELDS
              uuid( ) AS object_uuid,
              project_data~project_uuid,
              project_data~project_name,
              tr_entries~obj_name AS object_name,
              tr_entries~as4pos AS object_line_item,
              tr_entries~object AS object_type,
              tr_header~trkorr AS transport_request,
              repository_objects~devclass AS object_package,
              tr_header~as4user AS object_owner,
              tr_header~as4date AS object_changed_at,
              tr_header~as4user AS created_by,
              @local_timestamp AS created_at
            ORDER BY transport_request ).
      CATCH cx_sy_open_sql_db INTO DATA(sql_insert_error).
        r_status = VALUE #( is_success = abap_false
                            db_name = |zdt_demo_s4_obj|
                            message_log = |{ r_status-db_name } { sql_insert_error->get_text( ) } | ).
        RETURN.
    ENDTRY.

    IF sy-subrc = 0.
      r_status = VALUE #( is_success = abap_true
                          db_name = |zdt_demo_s4_obj|
                          message_log = |App started.. DB { r_status-db_name } has been successfully updated!!| ).
      RETURN.
    ENDIF.
    r_status = VALUE #( is_success = abap_false
                        db_name = |zdt_demo_s4_obj|
                        message_log = |App started.. DB { r_status-db_name } has failed to update!!| ).
  ENDMETHOD.

  METHOD fill_up_demo_trm_transport_req.
    "TRs used
    TYPES ty_transport_request TYPE RANGE OF trkorr.
    DATA(lt_transport_request_used) = VALUE ty_transport_request( sign = if_fsbp_const_range=>sign_include
                                                                  option = if_fsbp_const_range=>option_equal
                                                                ( low = 'D4SK900539')
                                                                ( low = 'D4SK902310')
                                                                ( low = 'D4SK902554')
                                                                ( low = 'D4SK903464')
                                                                ( low = 'D4SK903586')
                                                                ( low = 'DEVK971614')
                                                                ).

    "Method to append TRs from consultant
*    APPEND VALUE #( sign = if_fsbp_const_range=>sign_include
*                    option = if_fsbp_const_range=>option_equal
*                    low = '' ) TO lt_transport_request_used.

    DELETE FROM zdt_demo_s4_tr.
    SELECT FROM e070 AS tr_header
      INNER JOIN e07t AS tr_text
      ON tr_header~trkorr = tr_text~trkorr
      FIELDS
        tr_header~trkorr AS transport_request,
        tr_header~strkorr AS parent_transport_req,
        tr_text~as4text AS description,
        tr_header~trfunction AS function,
        tr_header~trstatus AS status,
        tr_header~as4user AS userid,
        tr_header~as4date AS changed_on,
        tr_header~as4time AS changed_at
      WHERE tr_header~strkorr IN @lt_transport_request_used
      ORDER BY transport_request
      INTO TABLE @DATA(lt_transport_request_query).

    TRY.
        INSERT zdt_demo_s4_tr FROM (
          SELECT FROM e070 AS tr_header
            INNER JOIN e07t AS tr_text
            ON tr_header~trkorr = tr_text~trkorr
            FIELDS
              tr_header~trkorr AS transport_request,
              CASE WHEN tr_header~strkorr = 'D4SK902310'
                   THEN 'Open Item Posting(IDOC Inbound Interface)'
                   WHEN tr_header~strkorr = 'D4SK902554'
                   THEN 'Excel Upload for maintenance tables with multiple lines'
                   WHEN tr_header~strkorr = 'D4SK903464'
                   THEN 'IRS Netting Posting'
                   WHEN tr_header~strkorr = 'D4SK903586'
                   THEN 'CCS Interest Netting'
                   WHEN tr_header~strkorr = 'D4SK900539'
                   THEN 'Lift and Shift Objects By Team'
                   ELSE 'Lift and Shift Objects by Consultant'
                   END AS project_name,
              tr_header~strkorr AS parent_transport_req,
              tr_text~as4text AS description,
              tr_header~trfunction AS function,
              tr_header~trstatus AS status,
              tr_header~as4user AS userid,
              tr_header~as4date AS changed_on,
              tr_header~as4time AS changed_at
            WHERE tr_header~strkorr IN @lt_transport_request_used
            ORDER BY transport_request ).
      CATCH cx_sy_open_sql_db INTO DATA(sql_insert_error).
        r_status = VALUE #( is_success = abap_false
                            db_name = |zdt_demo_s4_tr|
                            message_log = |{ r_status-db_name } { sql_insert_error->get_text( ) } | ).
        RETURN.
    ENDTRY.

    IF sy-subrc = 0.
      r_status = VALUE #( is_success = abap_true
                          db_name = |zdt_demo_s4_tr|
                          message_log = |App started.. DB { r_status-db_name } has been successfully updated!!| ).
      RETURN.
    ENDIF.
    r_status = VALUE #( is_success = abap_false
                        db_name = |zdt_demo_s4_tr|
                        message_log = |App started.. DB { r_status-db_name } has failed to update!!| ).
  ENDMETHOD.

  METHOD fill_up_demo_systems.
    DATA(db_used) = to_lower( |zdt_demo_systems| ).
    DELETE FROM (db_used).
    TRY.
        INSERT zdt_demo_systems FROM TABLE @( VALUE #(
                                                ( zsystem = 'DEV' description = 'SM New(DAC, SMDC, others...)Dev System' type = 'ECC' version = 'ABAP 740' kernel = '740' )
                                                ( zsystem = 'SED' description = 'SM Old(Belle, Prime, others..)Dev System' type = 'ECC' version = 'ABAP 700' kernel = '700' )
                                                ( zsystem = 'TRM' description = 'SM TRM System' type = 'S4Hana' version = 'S4 HANA 1809' kernel = '753' )
                                                ( zsystem = 'D4S' description = 'SM New S4 Hana Dev System' type = 'S4Hana' version = 'S4 HANA 2021(SP02)' kernel = '756' )
                                                ) ) ACCEPTING DUPLICATE KEYS.
      CATCH cx_sy_open_sql_db INTO DATA(sql_insert_error).
        r_status = VALUE #( is_success = abap_false
                            db_name = db_used
                            message_log = |{ r_status-db_name } { sql_insert_error->get_text( ) } | ).
        RETURN.
    ENDTRY.

    IF sy-subrc = 0.
      r_status = VALUE #( is_success = abap_true
                          db_name = db_used
                          message_log = |App started.. DB { r_status-db_name } has been successfully updated!!| ).
      RETURN.
    ENDIF.
    r_status = VALUE #( is_success = abap_false
                        db_name = db_used
                        message_log = |App started.. DB { r_status-db_name } has failed to update!!| ).
  ENDMETHOD.

  METHOD fill_up_demo_status.
    DATA(db_used) = to_lower( |zdt_demo_status| ).
    DELETE FROM (db_used).
    TRY.
        INSERT zdt_demo_status FROM TABLE @( VALUE #(
                                                ( status = 00 description = 'Not yet Started' )
                                                ( status = 01 description = 'In Progress' )
*                                                ( status = 02 description = 'Paused' )
                                                ( status = 05 description = 'Completed' )
                                                ) ) ACCEPTING DUPLICATE KEYS.
      CATCH cx_sy_open_sql_db INTO DATA(sql_insert_error).
        r_status = VALUE #( is_success = abap_false
                            db_name = db_used
                            message_log = |{ r_status-db_name } { sql_insert_error->get_text( ) } | ).
        RETURN.
    ENDTRY.

    IF sy-subrc = 0.
      r_status = VALUE #( is_success = abap_true
                          db_name = db_used
                          message_log = |App started.. DB { r_status-db_name } has been successfully updated!!| ).
      RETURN.
    ENDIF.
    r_status = VALUE #( is_success = abap_false
                        db_name = db_used
                        message_log = |App started.. DB { r_status-db_name } has failed to update!!| ).
  ENDMETHOD.

  METHOD fill_up_demo_priority.
    DATA(db_used) = to_lower( |zdt_demo_prio| ).
    DELETE FROM (db_used).
    TRY.
        INSERT zdt_demo_prio FROM TABLE @( VALUE #(
*                                                ( value = 0 description = 'Low'      criticality = 0 criticality_desc = 'Neutral(None)'  )
                                                ( value = 1 description = 'High'     criticality = 1 criticality_desc = 'Negative(Red)' )
                                                ( value = 2 description = 'Medium'   criticality = 2 criticality_desc = 'Critical(Orange)' )
                                                ( value = 3 description = 'Positive' criticality = 3 criticality_desc = 'Positive(Green)' )
                                                ( value = 5 description = 'Low'     criticality = 5 criticality_desc = 'New Item(Blue)' )
                                                ) ) ACCEPTING DUPLICATE KEYS.
      CATCH cx_sy_open_sql_db INTO DATA(sql_insert_error).
        r_status = VALUE #( is_success = abap_false
                            db_name = db_used
                            message_log = |{ r_status-db_name } { sql_insert_error->get_text( ) } | ).
        RETURN.
    ENDTRY.

    IF sy-subrc = 0.
      r_status = VALUE #( is_success = abap_true
                          db_name = db_used
                          message_log = |App started.. DB { r_status-db_name } has been successfully updated!!| ).
      RETURN.
    ENDIF.
    r_status = VALUE #( is_success = abap_false
                        db_name = db_used
                        message_log = |App started.. DB { r_status-db_name } has failed to update!!| ).
  ENDMETHOD.


  METHOD fill_up_demo_user_role_lists.

    DATA(db_used) = to_lower( |zdt_demo_roles| ).
    DELETE FROM (db_used).
    TRY.
        INSERT zdt_demo_roles FROM TABLE @( VALUE #(
                                                     ( role_name = 'Developer' description = 'Technical Role' )
                                                     ( role_name = 'Functional' description = 'Functional Role' )
                                                   ) ) ACCEPTING DUPLICATE KEYS.
      CATCH cx_sy_open_sql_db INTO DATA(sql_insert_error).
        r_status = VALUE #( is_success = abap_false
                            db_name = db_used
                            message_log = |{ r_status-db_name } { sql_insert_error->get_text( ) } | ).
        RETURN.
    ENDTRY.

    IF sy-subrc = 0.
      r_status = VALUE #( is_success = abap_true
                          db_name = db_used
                          message_log = |App started.. DB { r_status-db_name } has been successfully updated!!| ).
      RETURN.
    ENDIF.
    r_status = VALUE #( is_success = abap_false
                        db_name = db_used
                        message_log = |App started.. DB { r_status-db_name } has failed to update!!| ).
  ENDMETHOD.

  METHOD get_timestamp_local.
    GET TIME STAMP FIELD result.
  ENDMETHOD.

ENDCLASS.
