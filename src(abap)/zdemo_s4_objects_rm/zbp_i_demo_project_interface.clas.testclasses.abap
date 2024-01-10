*"* use this source file for your ABAP unit test classes
CLASS ltc_projects DEFINITION FOR TESTING RISK LEVEL HARMLESS DURATION SHORT.

  PRIVATE SECTION.

    CLASS-DATA:
      cut TYPE REF TO lhc_projects,
      cds_test_environment TYPE REF TO if_cds_test_environment,
      sql_test_environment TYPE REF TO if_osql_test_environment.

    CLASS-METHODS:
      class_setup,
      class_teardown.

    METHODS:
      setup,
      teardown.

    METHODS:
      collate_developers FOR TESTING RAISING cx_static_check.

ENDCLASS.

CLASS ltc_projects IMPLEMENTATION.

  METHOD class_setup.
    CREATE OBJECT cut FOR TESTING.
    cds_test_environment = cl_cds_test_environment=>create_for_multiple_cds(
                           VALUE #(
                                  ( i_for_entity = 'ZI_DEMO_USERS_ASSIGNED' ) )
                                  ).
  ENDMETHOD.

  METHOD class_teardown.

  ENDMETHOD.

  METHOD setup.

  ENDMETHOD.

  METHOD teardown.

  ENDMETHOD.

  METHOD collate_developers.

    DATA:
      mock_test_data TYPE STANDARD TABLE OF zi_demo_users_assigned,
      failed         TYPE RESPONSE FOR FAILED EARLY zi_demo_s4_project_interface,
      reported       TYPE RESPONSE FOR REPORTED EARLY zi_demo_s4_project_interface.


  ENDMETHOD.

ENDCLASS.
