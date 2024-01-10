CLASS zcm_demo_s4_how DEFINITION
  PUBLIC INHERITING FROM cx_static_check
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_t100_message.
    INTERFACES if_t100w_dyn_msg.
    INTERFACES if_abap_behv_message.

    CONSTANTS:
      BEGIN OF initial_project_name,
        msgid TYPE symsgid VALUE 'ZCM_DEMO_S4_HOW',
        msgno TYPE symsgno VALUE '001',
        attr1 TYPE scx_attrname VALUE '',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF initial_project_name.

    CONSTANTS:
      BEGIN OF priority_invalid,
        msgid TYPE symsgid VALUE 'ZCM_DEMO_S4_HOW',
        msgno TYPE symsgno VALUE '002',
        attr1 TYPE scx_attrname VALUE 'PRIORITY',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF priority_invalid.

    CONSTANTS:
      BEGIN OF status_invalid,
        msgid TYPE symsgid VALUE 'ZCM_DEMO_S4_HOW',
        msgno TYPE symsgno VALUE '003',
        attr1 TYPE scx_attrname VALUE 'STATUS',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF status_invalid.

    CONSTANTS:
      BEGIN OF projected_date_invalid,
        msgid TYPE symsgid VALUE 'ZCM_DEMO_S4_HOW',
        msgno TYPE symsgno VALUE '004',
        attr1 TYPE scx_attrname VALUE 'PROJECTED_DATE',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF projected_date_invalid.

    CONSTANTS:
      BEGIN OF transaction_code_invalid,
        msgid TYPE symsgid VALUE 'ZCM_DEMO_S4_HOW',
        msgno TYPE symsgno VALUE '005',
        attr1 TYPE scx_attrname VALUE 'TRANSACTION_CODE',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF transaction_code_invalid.

    CONSTANTS:
      BEGIN OF user_not_found,
        msgid TYPE symsgid VALUE 'ZCM_DEMO_S4_HOW',
        msgno TYPE symsgno VALUE '006',
        attr1 TYPE scx_attrname VALUE 'USERNAME',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF user_not_found.

    CONSTANTS:
      BEGIN OF objects_with_tr_not_found,
        msgid TYPE symsgid VALUE 'ZCM_DEMO_S4_HOW',
        msgno TYPE symsgno VALUE '007',
        attr1 TYPE scx_attrname VALUE 'TRANSPORT_REQUEST',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF objects_with_tr_not_found.

    CONSTANTS:
      BEGIN OF duplicate_objects_added,
        msgid TYPE symsgid VALUE 'ZCM_DEMO_S4_HOW',
        msgno TYPE symsgno VALUE '008',
        attr1 TYPE scx_attrname VALUE 'TRANSPORT_REQUEST',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF duplicate_objects_added.

    CONSTANTS:
      BEGIN OF progress_value_more_than_100,
        msgid TYPE symsgid VALUE 'ZCM_DEMO_S4_HOW',
        msgno TYPE symsgno VALUE '009',
        attr1 TYPE scx_attrname VALUE 'PROGRESS_VALUE',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF progress_value_more_than_100.

    CONSTANTS:
      BEGIN OF start_date_invalid,
        msgid TYPE symsgid VALUE 'ZCM_DEMO_S4_HOW',
        msgno TYPE symsgno VALUE '010',
        attr1 TYPE scx_attrname VALUE 'START_DATE',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF start_date_invalid.

    CONSTANTS:
      BEGIN OF user_already_assigned,
        msgid TYPE symsgid VALUE 'ZCM_DEMO_S4_HOW',
        msgno TYPE symsgno VALUE '011',
        attr1 TYPE scx_attrname VALUE 'USERNAME',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF user_already_assigned.

    CONSTANTS:
      BEGIN OF initial_it_group,
        msgid TYPE symsgid VALUE 'ZCM_DEMO_S4_HOW',
        msgno TYPE symsgno VALUE '012',
        attr1 TYPE scx_attrname VALUE '',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF initial_it_group.

    CONSTANTS:
      BEGIN OF initial_project_start_date,
        msgid TYPE symsgid VALUE 'ZCM_DEMO_S4_HOW',
        msgno TYPE symsgno VALUE '013',
        attr1 TYPE scx_attrname VALUE '',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF initial_project_start_date.

    CONSTANTS:
      BEGIN OF not_started_initial_start_date,
        msgid TYPE symsgid VALUE 'ZCM_DEMO_S4_HOW',
        msgno TYPE symsgno VALUE '014',
        attr1 TYPE scx_attrname VALUE '',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF not_started_initial_start_date.

    CONSTANTS:
      BEGIN OF transport_request_not_initial,
        msgid TYPE symsgid VALUE 'ZCM_DEMO_S4_HOW',
        msgno TYPE symsgno VALUE '015',
        attr1 TYPE scx_attrname VALUE '',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF transport_request_not_initial.

    CONSTANTS:
      BEGIN OF transport_request_not_valid,
        msgid TYPE symsgid VALUE 'ZCM_DEMO_S4_HOW',
        msgno TYPE symsgno VALUE '016',
        attr1 TYPE scx_attrname VALUE 'TRANSPORT_REQUEST',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF transport_request_not_valid.

    CONSTANTS:
      BEGIN OF objects_created_success,
        msgid TYPE symsgid VALUE 'ZCM_DEMO_S4_HOW',
        msgno TYPE symsgno VALUE '900',
        attr1 TYPE scx_attrname VALUE '',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF objects_created_success.

    DATA:
      priority          TYPE zi_demo_s4_project_interface-Priority,
      status            TYPE zi_demo_s4_project_interface-TestStatus,
      projected_date    TYPE zi_demo_s4_project_interface-ProjectedDate,
      transaction_code  TYPE zi_demo_s4_project_interface-S4Tcode,
      username          TYPE zi_demo_s4_project_interface-CreatedBy,
      transport_request TYPE zi_demo_s4_objects-TransportRequest,
      progress_value    TYPE zi_demo_worklog-ProgressValue,
      start_date        TYPE zi_demo_s4_project_interface-StartDate.

    METHODS constructor
      IMPORTING
        textid            LIKE if_t100_message=>t100key OPTIONAL "RAP or fiori message
        previous          LIKE previous OPTIONAL
        severity          TYPE if_abap_behv_message=>t_severity DEFAULT if_abap_behv_message=>severity-error
        priority          TYPE zi_demo_s4_project_interface-Priority OPTIONAL
        status            TYPE zi_demo_s4_project_interface-TestStatus OPTIONAL
        projected_date    TYPE zi_demo_s4_project_interface-ProjectedDate OPTIONAL
        transaction_code  TYPE zi_demo_s4_project_interface-S4Tcode OPTIONAL
        username          TYPE zi_demo_s4_project_interface-CreatedBy OPTIONAL
        transport_request TYPE zi_demo_s4_objects-TransportRequest OPTIONAL
        progress_value    TYPE zi_demo_worklog-ProgressValue OPTIONAL
        start_date        TYPE zi_demo_s4_project_interface-StartDate OPTIONAL.

  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.



CLASS zcm_demo_s4_how IMPLEMENTATION.


  METHOD constructor ##ADT_SUPPRESS_GENERATION.

    super->constructor( previous = previous ).

    CLEAR me->textid.
    IF textid IS INITIAL.
      if_t100_message~t100key = if_t100_message=>default_textid.
    ELSE.
      if_t100_message~t100key = textid.
    ENDIF.

    me->if_abap_behv_message~m_severity = severity.
    me->priority = priority.
    me->status = status.
    me->projected_date = projected_date.
    me->transaction_code = transaction_code.
    me->username = username.
    me->transport_request = transport_request.
    me->progress_value = progress_value.
    me->start_date = start_date.
  ENDMETHOD.
ENDCLASS.
