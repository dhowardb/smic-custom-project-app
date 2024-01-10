CLASS zcl_projects_demo_helper DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    CLASS-METHODS:
      get_initial_demo_status
        RETURNING
          VALUE(result) TYPE zdt_demo_status-status,
      get_initial_demo_priority
        RETURNING
          VALUE(result) TYPE zdt_demo_prio-value.

    CLASS-METHODS:
      get_project_status
        IMPORTING VALUE(iv_status_description) TYPE zdt_demo_status-description
        RETURNING VALUE(result)                TYPE zdt_demo_status-status.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_projects_demo_helper IMPLEMENTATION.
  METHOD get_initial_demo_status.
    SELECT FROM zdt_demo_status
      FIELDS
        status,
        description
      WHERE status = '00' "Initial status
      INTO TABLE @DATA(statuses)
      UP TO 1 ROWS.

    result = VALUE #( statuses[ 1 ]-status OPTIONAL ).

  ENDMETHOD.

  METHOD get_initial_demo_priority.
    SELECT FROM zdt_demo_prio
      FIELDS
        value
      WHERE value = 5 "Status Low
      INTO TABLE @DATA(priorities)
      UP TO 1 ROWS.

    result = VALUE #( priorities[ 1 ]-value OPTIONAL ).
  ENDMETHOD.

  METHOD get_project_status.

    SELECT FROM zi_demo_status
      FIELDS
        Description,
        Status
      WHERE Status IS NOT NULL
      ORDER BY Status
      INTO TABLE @DATA(statuses).

    result = REDUCE #( INIT initial TYPE zi_demo_status-Status
                       FOR <status> IN statuses WHERE ( Description CP iv_status_description )
                       NEXT initial = <status>-Status ).
  ENDMETHOD.
ENDCLASS.
